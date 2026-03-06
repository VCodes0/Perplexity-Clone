"""
Health check route — GET /health
"""

from fastapi import APIRouter
from app.models.schemas import HealthResponse

router = APIRouter()


@router.get("/health", response_model=HealthResponse, tags=["Health"])
async def health_check():
    """Returns server health status."""
    return HealthResponse(status="ok")
