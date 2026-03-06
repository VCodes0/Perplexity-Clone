"""
Pydantic schemas for request/response validation.
"""

from pydantic import BaseModel, Field
from typing import Optional


class SearchRequest(BaseModel):
    query: str = Field(..., min_length=1, max_length=2000, description="User search query")
    search_mode: str = Field(default="auto", description="Search mode: auto, academic, writing, math, video, social")


class SourceItem(BaseModel):
    title: str
    url: str
    snippet: str


class SearchResponse(BaseModel):
    query: str
    answer: str
    sources: list[SourceItem]
    search_mode: str
    model_used: str


class HealthResponse(BaseModel):
    status: str
    version: str = "1.0.0"


class ErrorResponse(BaseModel):
    detail: str
    error_code: Optional[str] = None
