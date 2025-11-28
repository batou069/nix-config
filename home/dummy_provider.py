from jupyter_ai_magics.providers import BaseProvider
from typing import ClassVar, List, Optional
from langchain_core.runnables import Runnable, RunnableConfig
from langchain_core.messages import BaseMessage, AIMessage
from langchain_core.outputs import Generation
from typing import AsyncIterator, Dict, Any


class DummyProvider(BaseProvider, Runnable):
    id: ClassVar[str] = "dummy-completion-provider"
    name: ClassVar[str] = "Dummy Completion Provider"
    model_id_key: ClassVar[str] = "model_id"
    models: ClassVar[List[str]] = ["dummy-model"]
    auth_strategy: ClassVar[Optional[str]] = None
    paged_models: ClassVar[List[str]] = []
    model_id: ClassVar[str] = "dummy-model"

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        print("DEBUG: DummyProvider initialized!")

    @property
    def is_chat_provider(self) -> bool:
        return False

    def get_model_id(self, model_name: str) -> str:
        return self.model_id

    async def predict(self, model_id: str, prompt: str, *args, **kwargs) -> Generation:
        # For debugging, let's just return a fixed Generation object
        return Generation(text="fixed dummy suggestion from predict")

    def invoke(
        self, input: Dict[str, Any], config: Optional[RunnableConfig] = None
    ) -> BaseMessage:
        # For debugging, return a fixed AIMessage
        return AIMessage(content="fixed dummy suggestion from invoke (sync)")

    async def stream(
        self, input: Dict[str, Any], config: Optional[RunnableConfig] = None
    ) -> AsyncIterator[str]:
        # For debugging, yield a single string
        yield "fixed dummy suggestion from stream"
