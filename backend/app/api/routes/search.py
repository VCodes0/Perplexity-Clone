"""
Search route — POST /api/search
"""

from fastapi import APIRouter, HTTPException, status
from app.models.schemas import SearchRequest, SearchResponse
from app.services.gemini_service import gemini_service

router = APIRouter()


@router.post(
    "/search",
    response_model=SearchResponse,
    status_code=status.HTTP_200_OK,
    tags=["Search"],
    summary="AI-powered search using Gemini",
)
async def search(request: SearchRequest) -> SearchResponse:
    """
    Accepts a search query and returns an AI-generated answer
    with source citations powered by Google Gemini.
    """
    try:
        result = await gemini_service.search(
            query=request.query,
            search_mode=request.search_mode,
        )
        return result
    except Exception as e:
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Gemini API error: {str(e)}",
        )
