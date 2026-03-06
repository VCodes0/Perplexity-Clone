"""
FastAPI application entry point.
Run with: uvicorn app.main:app --reload
"""

from contextlib import asynccontextmanager
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api.router import router
from app.core.config import settings


@asynccontextmanager
async def lifespan(app: FastAPI):
    """Startup and shutdown events."""
    print("🚀 Perplexity Clone API starting...")
    print(f"📡 Model: {settings.gemini_model}")
    print(f"🌐 Docs: http://{settings.app_host}:{settings.app_port}/docs")
    yield
    print("🛑 Perplexity Clone API shutting down...")


app = FastAPI(
    title="Perplexity Clone API",
    description="AI-powered search engine using Google Gemini API",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc",
    lifespan=lifespan,
)

# ── CORS Middleware ─────────────────────────────────────────────────────────
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins_list,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ── Routes ──────────────────────────────────────────────────────────────────
app.include_router(router)


@app.get("/", tags=["Root"])
async def root():
    return {
        "message": "Perplexity Clone API",
        "docs": "/docs",
        "health": "/health",
        "search": "POST /api/search",
    }
