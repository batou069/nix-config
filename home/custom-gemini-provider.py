from langchain_google_genai import ChatGoogleGenerativeAI
import os
import asyncio
from typing import ClassVar, List, Optional, AsyncIterator, Any
from jupyter_ai_magics.providers import BaseProvider
from langchain_core.runnables import Runnable, RunnableConfig
from langchain_core.messages import BaseMessage, AIMessage
from langchain_core.outputs import Generation


class CustomGeminiProvider(BaseProvider, Runnable):
    id: ClassVar[str] = "gemini-provider"
    name: ClassVar[str] = "Gemini Provider"
    model_id_key: ClassVar[str] = "model_id"
    models: ClassVar[List[str]] = [
        "gemini-2.5-flash",
        "gemini-1.5-pro-latest",
    ]  # Add supported models
    auth_strategy: ClassVar[Optional[str]] = (
        None  # Assuming API key is handled by env var
    )
    paged_models: ClassVar[List[str]] = []
    model_id: ClassVar[str] = "gemini-2.5-flash"  # Default model

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # Read the model name from an environment variable or use default
        self.model = os.environ.get("GEMINI_MODEL", self.model_id)
        if not os.environ.get("GOOGLE_API_KEY"):
            print(
                "\n[CustomGeminiProvider] Warning: GOOGLE_API_KEY environment variable not set.\n"
            )
        if not os.environ.get("GEMINI_MODEL"):
            print(
                f"\n[CustomGeminiProvider] Warning: GEMINI_MODEL environment variable not set. Using default: {self.model}\n"
            )

        self.llm = ChatGoogleGenerativeAI(model=self.model, temperature=0.1)
        print("DEBUG: CustomGeminiProvider initialized!")

    # Implement abstract methods from BaseProvider
    @property
    def is_chat_provider(self) -> bool:
        return False

    def get_model_id(self, model_name: str) -> str:
        return self.model

    async def predict(self, model_id: str, prompt: str, *args, **kwargs) -> Generation:
        # This method is required by BaseProvider. We'll delegate to our stream/invoke
        full_response = ""
        try:
            # Use invoke for non-streaming predict
            response = await asyncio.wait_for(
                self.invoke({"prompt": prompt}), timeout=10.0
            )
            full_response = response.content
        except asyncio.TimeoutError:
            print("\n[CustomGeminiProvider] Prediction request timed out.\n")
        except Exception as e:
            print(f"\n[CustomGeminiProvider] Prediction Error: {e}\n")
        return Generation(text=full_response)

    # Implement methods from Runnable
    def invoke(
        self, input: Any, config: Optional[RunnableConfig] = None
    ) -> BaseMessage:
        # Check if input is a StringPromptValue and extract text
        if hasattr(input, "text"):
            prompt = input.text
        elif isinstance(input, dict):  # Fallback for dictionary input
            prompt = input.get("prompt", "")
        else:
            prompt = str(input)
        if not prompt.strip():
            return AIMessage(content="")

        try:
            # Note: ainvoke is async, but we are forced to call it synchronously here
            # This might block the event loop if the LLM call is long.
            # This is a workaround for the jupyter-ai-magics/LangChain integration issue.
            response = self.llm.invoke(prompt)  # Use synchronous invoke
            suggestion = response.content
            # The model often includes the prompt in its response; remove it.
            if suggestion.startswith(prompt):
                suggestion = suggestion[len(prompt) :]
            return AIMessage(content=suggestion)
        except Exception as e:
            print(f"\n[CustomGeminiProvider] Invoke Error: {e}\n")
            return AIMessage(content="")

    async def stream(
        self, input: Any, config: Optional[RunnableConfig] = None
    ) -> AsyncIterator[str]:
        # Check if input is a StringPromptValue and extract text
        if hasattr(input, "text"):
            prompt = input.text
        elif isinstance(input, dict):  # Fallback for dictionary input
            prompt = input.get("prompt", "")
        else:
            prompt = str(input)

        if not prompt.strip():
            return

        try:
            first_chunk = True
            async for chunk in self.llm.astream(prompt):
                if chunk.content:
                    if first_chunk:
                        first_chunk = False
                        if chunk.content.startswith(prompt):
                            yield chunk.content[len(prompt) :]
                        else:
                            yield chunk.content
                    else:
                        yield chunk.content

        except asyncio.TimeoutError:
            print("\n[CustomGeminiProvider] Stream request timed out.\n")
        except Exception as e:
            print(f"\n[CustomGeminiProvider] Stream Error: {e}\n")
