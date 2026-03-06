from fastapi import FastAPI
from pydantic_model.chat_body import ChatBody

app = FastAPI()

@app.post("/chat")
def chat_endpoint(body: ChatBody):
    # Search the Web And Find the Appropiate Sources
    # source the sorces
    # Ganrate the Reponse Using LLM
    return body.query