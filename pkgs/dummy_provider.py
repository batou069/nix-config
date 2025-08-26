class DummyProvider:
    def __init__(self):
        print("DummyProvider initialized!")

    async def _trigger_llm(self, buffer):
        print("DummyProvider _trigger_llm called!")
        # Simulate a suggestion
        buffer.insert_text("dummy suggestion")
