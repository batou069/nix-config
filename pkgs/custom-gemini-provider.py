from langchain_google_genai import ChatGoogleGenerativeAI
import os
import asyncio

class CustomGeminiProvider:
    """
    A standalone, minimal provider for IPython auto-suggestions that completely
    bypasses the jupyter-ai-magics library.

    This class implements the minimal interface that IPython's auto-suggestion
    engine expects, specifically the __init__ and _trigger_llm methods.
    """
    def __init__(self):
        # Read the model name from an environment variable
        self.model = os.environ.get("GEMINI_MODEL", "gemini-2.5-flash")
        if not os.environ.get("GOOGLE_API_KEY"):
            print("\n[CustomGeminiProvider] Warning: GOOGLE_API_KEY environment variable not set.\n")
        if not os.environ.get("GEMINI_MODEL"):
            print(f"\n[CustomGeminiProvider] Warning: GEMINI_MODEL environment variable not set. Using default: {self.model}\n")

    async def _trigger_llm(self, buffer):
        """
        This method is called by IPython when the suggestion shortcut is pressed.
        It gets the text, calls the Gemini API, and inserts the suggestion.
        """
        # Avoid running on empty or whitespace-only input
        if not buffer.text.strip():
            return

        try:
            prompt = buffer.text
            llm = ChatGoogleGenerativeAI(model=self.model, temperature=0.1)
            
            # Add a 5-second timeout to prevent long hangs.
            response = await asyncio.wait_for(llm.ainvoke(prompt), timeout=5.0)
            
            suggestion = response.content
            
            # The model often includes the prompt in its response; remove it.
            if suggestion.startswith(prompt):
                suggestion = suggestion[len(prompt):]

            if suggestion:
                buffer.insert_text(suggestion)

        except asyncio.TimeoutError:
            print("\n[CustomGeminiProvider] Suggestion request timed out.\n")
        except Exception as e:
            # Log errors to the terminal without crashing the event loop.
            print(f"\n[CustomGeminiProvider] Error: {e}\n")