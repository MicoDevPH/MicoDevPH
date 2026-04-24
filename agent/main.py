import os
from dotenv import load_dotenv
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from langchain_openai import ChatOpenAI
from langgraph.prebuilt import create_react_agent
from langchain_core.messages import HumanMessage, SystemMessage

# Load environment variables
load_dotenv()

app = FastAPI()

# Enable CORS for React
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize LLM via GitHub Models
llm = ChatOpenAI(
    model="gpt-4o-mini", 
    openai_api_key=os.getenv("GITHUB_TOKEN"), 
    base_url="https://models.inference.ai.azure.com" 
)

def load_prompt(filename):
    path = os.path.join("prompt", filename)
    with open(path, "r") as f:
        return f.read()
    
# Create the modern agent (using an empty list for tools)
agent = create_react_agent(llm, tools=[])

@app.get("/")
def read_root():
    return {"status": "Agent is online"}


class ChatRequest(BaseModel):
    message: str

@app.post("/chat")
async def chat(request: ChatRequest):
    try:
        print(f"Thinking about: {request.message}")
        
        # 1. Load your XML prompts
        persona = load_prompt("persona.xml")
        instructions = load_prompt("mokusei_instructions.xml")
        
        # 2. Build the message list (System + Human)
        messages = [
            SystemMessage(content=f"PERSONA:\n{persona}\n\nINSTRUCTIONS:\n{instructions}"),
            HumanMessage(content=request.message)
        ]
        
        # 3. Invoke the LLM with the structured messages
        response = llm.invoke(messages)
        
        return {"reply": response.content}
    except Exception as e:
        print(f"❌ AI Error: {e}")
        return {"reply": f"Internal Error: {str(e)}"}

