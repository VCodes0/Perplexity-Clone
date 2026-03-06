from comnfig import Settings


setting = Settings()
class SearchService:
    def web_search(self, query: str):
        print(setting.GEMINI_API_KEY)