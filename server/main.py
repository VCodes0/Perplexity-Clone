from fastapi import FastAPI
from pydantic_model.chat_body import ChatBody
from services.search_services import SearchService

app = FastAPI()

search_service = SearchService()

@app.post("/chat")
def chat_endpoint(body: ChatBody):
    # Search the Web And Find the Appropiate Sources
    search_service.web_search(body.query)
    # source the sorces
    # Ganrate the Reponse Using LLM
    return body.query