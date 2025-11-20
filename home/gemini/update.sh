#!/usr/bin/env bash
# Auto-update script for gemini-cli with interactive version selection

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*"
}

# Check for required tools
check_deps() {
    if ! command -v gh &> /dev/null; then
        log_error "GitHub CLI ('gh') not found. Please install it to continue."
        exit 1
    fi
    if ! command -v gum &> /dev/null; then
        log_error "'gum' not found. Please install it to continue."
        log_info "You can install it with: nix-shell -p gum"
        exit 1
    fi
}

# Main script
main() {
    cd "$(dirname "$0")"
    check_deps

    local OWNER="google-gemini"
    local REPO="gemini-cli"
    local NIX_FILE="package.nix"

    log_info "Starting gemini-cli update check..."

    # Get current version info
    local CURRENT_REV
    CURRENT_REV=$(grep -oP 'rev = "\K[^"]+' "$NIX_FILE")
    local CURRENT_VERSION
    CURRENT_VERSION=$(grep -oP 'version = "\K[^"]+' "$NIX_FILE")
    log_info "Currently installed version: $CURRENT_VERSION (rev: $CURRENT_REV)"

    # Get latest releases
    log_info "Fetching recent releases from GitHub..."
    local RELEASES
    RELEASES=$(gh release list --repo "$OWNER/$REPO" --limit 10 --json tagName --jq '.[].tagName')

    if [[ -z "$RELEASES" ]]; then
        log_error "Could not fetch releases from GitHub."
        exit 1
    fi

    # Let user choose a version
    local SELECTED_TAG
    SELECTED_TAG=$(echo "$RELEASES" | gum choose --header "Choose a version to install")

    if [[ -z "$SELECTED_TAG" ]]; then
        log_info "No version selected. Exiting."
        exit 0
    fi

    log_info "Selected version: $SELECTED_TAG"

    local NEW_VERSION
    NEW_VERSION=$(echo "$SELECTED_TAG" | sed 's/^v//') # Remove 'v' prefix if it exists

    # Get commit SHA for the selected tag
    log_info "Fetching commit SHA for tag '$SELECTED_TAG'..."
    local NEW_REV
    NEW_REV=$(gh api "repos/$OWNER/$REPO/git/ref/tags/$SELECTED_TAG" -q .object.sha)

    if [[ -z "$NEW_REV" ]]; then
        log_error "Could not get commit SHA for tag '$SELECTED_TAG'."
        exit 1
    fi

    log_info "New revision: $NEW_REV"

    # Check if we are already at the selected version
    if [[ "$CURRENT_REV" == "$NEW_REV" ]]; then
        log_info "You are already at the selected version. No update needed."
        exit 0
    fi

    # Fetching the new hash
    log_info "Prefetching source to get new hash..."
    local HASH
    HASH=$(nix-prefetch-github --rev "$NEW_REV" "$OWNER" "$REPO" | jq -r .hash)

    if [[ -z "$HASH" ]]; then
        log_error "Could not fetch hash for new version"
        return 1
    fi

    log_info "New hash: $HASH"

    # Update nix file
    log_info "Updating '$NIX_FILE'..."
    sed -i "s/version = \".*\"/version = \"$NEW_VERSION\"/" "$NIX_FILE"
    sed -i "s/rev = \".*\"/rev = \"$NEW_REV\"/" "$NIX_FILE"
    sed -i "s|hash = \".*\"|hash = \"$HASH\"|" "$NIX_FILE"

    # Invalidate npmDeps hash and add a comment
    log_info "Invalidating npmDeps hash..."
    sed -i '/npmDeps = fetchNpmDeps {/a \
      # The npmDeps hash is likely invalid, please rebuild it.\
      # You can do this by temporarily replacing the hash with an empty string (`""`)\
      # and running `nix-build` to get the new hash from the error message.' "$NIX_FILE"
    sed -i "s/npmDeps = fetchNpmDeps {.*hash = \".*\"/npmDeps = fetchNpmDeps {\n    hash = \"\"/" "$NIX_FILE"


    log_info "Update complete! Version updated to $NEW_VERSION"
    log_warn "The npmDeps hash has been invalidated. You will need to rebuild it to get the new hash."

    # Optionally commit changes
    if command -v git &> /dev/null && [[ -d ../../.git ]]; then
        if gum confirm "Commit changes?"; then
            log_info "Committing changes..."
            git add "$NIX_FILE"
            git commit -m "feat(gemini-cli): update to $NEW_VERSION"
            log_info "Changes committed. Don't forget to push!"
        fi
    fi
}

main "$@"