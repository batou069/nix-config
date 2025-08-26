c = get_config()

# This is a dedicated configuration for the ipython-ai command.

# Add the directory containing the custom provider to sys.path
# This ensures that the extension can be found by IPython.
import sys
import os
config_dir = os.path.dirname(__file__)
sys.path.append(config_dir)
print(f"DEBUG: sys.path after append: {sys.path}")
print(f"DEBUG: config_dir: {config_dir}")

# Point to the location of the custom provider extension.
c.InteractiveShellApp.extensions = [
    'custom_gemini_provider'
]

# Configure the auto-suggestion provider directly.
# IPython will import and instantiate this class.
c.TerminalInteractiveShell.autosuggestions_provider = "dummy_provider.DummyProvider"

# Set the key binding for auto-suggestions.
# This is separate from the provider configuration.
c.TerminalInteractiveShell.shortcuts = [
    {
        "new_keys": ["c-q"],
        "command": "IPython:auto_suggest.llm_autosuggestion",
        "new_filter": "navigable_suggestions & default_buffer_focused",
        "create": True,
    },
]
