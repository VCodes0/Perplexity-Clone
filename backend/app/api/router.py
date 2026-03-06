"""
API router — aggregates all route modules.
"""

from fastapi import APIRouter
from app.api.routes import health, search

router = APIRouter()

router.include_router(health.router)
router.include_router(search.router, prefix="/api")
