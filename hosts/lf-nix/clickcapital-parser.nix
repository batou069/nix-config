{pkgs, ...}: let
  # This defines your python script as an executable Nix package.
  process-alerts-script = pkgs.writeScript "process-alerts" ''
    #!${pkgs.nix}/bin/nix-shell
    #!nix-shell -i ${pkgs.python3.interpreter} -p ${pkgs.python3Packages.beautifulsoup4} ${pkgs.python3Packages.google-auth} ${pkgs.python3Packages.google-auth-oauthlib} ${pkgs.python3Packages.google-api-python-client}

    import base64
    import re
    from pathlib import Path
    from datetime import datetime

    from bs4 import BeautifulSoup
    from google.auth.transport.requests import Request
    from google.oauth2.credentials import Credentials
    from google_auth_oauthlib.flow import InstalledAppFlow
    from googleapiclient.discovery import build
    from googleapiclient.errors import HttpError

    # --- CONFIGURATION ---
    CONFIG_DIR = "/home/lf/.config/clickcapitalparser"
    OBSIDIAN_VAULT_PATH = "/home/lf/Obsidian/my_vault/Laurent/"
    OUTPUT_SUBFOLDER = "Tracking/Daily"
    NOTE_TITLE_FORMAT = "%Y-%m-%d Swing Alerts"

    # --- GMAIL API SETTINGS ---
    SCOPES = ['https://www.googleapis.com/auth/gmail.readonly', 'https://www.googleapis.com/auth/gmail.modify']
    TARGET_SENDER = "support@clickcapital.io"
    TARGET_SUBJECT = "Swing Trade Alerts for"
    # --- END CONFIGURATION ---


    def authenticate_gmail():
        """Handles the OAuth 2.0 flow to get valid credentials."""
        creds = None
        config_path = Path(CONFIG_DIR)
        config_path.mkdir(exist_ok=True) # Ensure the directory exists
        token_path = config_path / 'token.json'
        creds_path = config_path / 'credentials.json'

        if token_path.exists():
            creds = Credentials.from_authorized_user_file(str(token_path), SCOPES)

        if not creds or not creds.valid:
            if creds and creds.expired and creds.refresh_token:
                creds.refresh(Request())
            else:
                flow = InstalledAppFlow.from_client_secrets_file(str(creds_path), SCOPES)
                creds = flow.run_local_server(port=0)

            with open(token_path, 'w') as token:
                token.write(creds.to_json())

        return build('gmail', 'v1', credentials=creds)

    def parse_email_content(html_body):
        """Parses the HTML of the email to extract alert information."""
        soup = BeautifulSoup(html_body, 'html.parser')
        alerts = {}

        headers = soup.find_all('td', string=re.compile(r'(Entry|Adjustment|Cancellation|Exit) Alerts'))

        for header in headers:
            header_text = header.get_text(strip=True)
            alert_box_table = header.find_parent('table')
            if not alert_box_table:
                continue

            content_cell = alert_box_table.find('td', id=re.compile(r'bodyText-'))
            if content_cell:
                lines = content_cell.get_text(separator='\n', strip=True).splitlines()
                clean_lines = [line.strip() for line in lines if line.strip()]
                alerts[header_text] = clean_lines

        return alerts

    def format_alerts_for_obsidian(alerts, email_date):
        """Formats the extracted alerts into a Markdown string for Obsidian."""
        date_str = email_date.strftime('%B %d, %Y')
        output = [f"# Swing Alerts for {date_str}\n"]
        alert_order = ["Entry Alerts", "Adjustment Alerts", "Cancellation Alerts", "Exit Alerts"]

        for alert_type in alert_order:
            output.append(f"## {alert_type}")
            content = alerts.get(alert_type)
            if content:
                if any("none today" in line.lower() for line in content):
                    output.append("None Today")
                else:
                    output.append("```")
                    output.extend(content)
                    output.append("```")
            else:
                output.append("Not found in email.")
            output.append("")

        return "\n".join(output)

    def main():
        """Main function to run the email fetching and processing."""
        print("Authenticating with Gmail...")
        service = authenticate_gmail()
        query = f"from:({TARGET_SENDER}) subject:('{TARGET_SUBJECT}') is:unread"

        try:
            print(f"Searching for unread emails with query: {query}")
            response = service.users().messages().list(userId='me', q=query).execute()
            messages = response.get('messages', [])

            if not messages:
                print("No new emails found. Exiting.")
                return

            msg_id = messages[0]['id']
            print(f"Found email with ID: {msg_id}. Fetching content...")
            message = service.users().messages().get(userId='me', id=msg_id, format='full').execute()

            headers = message['payload']['headers']
            date_header = next((h['value'] for h in headers if h['name'].lower() == 'date'), None)
            email_date = datetime.strptime(date_header, '%a, %d %b %Y %H:%M:%S %z') if date_header else datetime.now()

            payload = message['payload']
            html_body = None

            if 'parts' in payload:
                for part in payload['parts']:
                    if part['mimeType'] == 'text/html':
                        data = part['body']['data']
                        html_body = base64.urlsafe_b64decode(data).decode('utf-8')
                        break

            if not html_body:
                print("Could not find HTML part in the email. Exiting.")
                return

            print("Parsing email content...")
            extracted_alerts = parse_email_content(html_body)

            if not extracted_alerts:
                print("Could not parse any alerts from the email body. Exiting.")
                return

            print("Formatting alerts for Obsidian...")
            markdown_content = format_alerts_for_obsidian(extracted_alerts, email_date)

            vault_path = Path(OBSIDIAN_VAULT_PATH)
            output_dir = vault_path / OUTPUT_SUBFOLDER
            output_dir.mkdir(parents=True, exist_ok=True)

            note_title = email_date.strftime(NOTE_TITLE_FORMAT) + ".md"
            output_file = output_dir / note_title

            print(f"Writing alerts to: {output_file}")
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(markdown_content)

            print(f"Marking email {msg_id} as read.")
            service.users().messages().modify(
                userId='me',
                id=msg_id,
                body={'removeLabelIds': ['UNREAD']}
            ).execute()

            print("\n✅ Success! The new Obsidian note has been created.")

        except HttpError as error:
            print(f"An error occurred: {error}")
        except Exception as e:
            print(f"An unexpected error occurred: {e}")

    if __name__ == '__main__':
        main()
  '';

  process-alerts-pkg = pkgs.runCommand "process-alerts-pkg" {} ''
    mkdir -p $out/bin
    cp ${process-alerts-script} $out/bin/process-alerts
    chmod +x $out/bin/process-alerts
  '';
in {
  # This section defines the configuration that the module provides.
  services.cron = {
    enable = true; # Ensures the cron service is running.
    systemCronJobs = [
      "0 9 * * * lf ${process-alerts-script}"
    ];
  };
  users.users.lf.packages = [
    process-alerts-pkg
  ];
}
