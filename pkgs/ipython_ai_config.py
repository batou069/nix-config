c = get_config()

# This is a dedicated configuration for the ipython-ai command.

# Import from the new package structure
import my_providers.custom_gemini_provider

# Only set llm_prefix_from_history to isolate the problem.
c.TerminalInteractiveShell.llm_prefix_from_history = 'input_history'

# Configure the LLM provider class.
# IPython will import and instantiate this class.
c.TerminalInteractiveShell.llm_provider_class = "my_providers.custom_gemini_provider.CustomGeminiProvider"

# Configure constructor arguments for the LLM provider.
c.TerminalInteractiveShell.llm_constructor_kwargs = {"model_id": "gemini-2.5-flash"}

# Enable verbose crash reporting for more detailed tracebacks.
c.Application.verbose_crash=True

# Configure keybinding for LLM autosuggestions.
c.TerminalInteractiveShell.shortcuts = [
    {
        "new_keys": ["c-q"],
        "command": "IPython:auto_suggest.llm_autosuggestion",
        "new_filter": "navigable_suggestions & default_buffer_focused",
        "create": True,
    },
]