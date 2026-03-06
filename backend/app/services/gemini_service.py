"""
Gemini AI service — handles all interactions with the Google Gemini API.
"""

import re
import google.generativeai as genai
from app.core.config import settings
from app.models.schemas import SearchResponse, SourceItem


class GeminiService:
    def __init__(self):
        genai.configure(api_key=settings.gemini_api_key)
        self.model = genai.GenerativeModel(settings.gemini_model)

    async def search(self, query: str, search_mode: str = "auto") -> SearchResponse:
        """
        Send a query to Gemini and return a structured SearchResponse.
        The prompt instructs Gemini to respond with an answer AND
        a list of source citations in a structured format.
        """
        prompt = self._build_prompt(query, search_mode)

        response = self.model.generate_content(prompt)
        raw_text = response.text

        answer, sources = self._parse_response(raw_text, query)

        return SearchResponse(
            query=query,
            answer=answer,
            sources=sources,
            search_mode=search_mode,
            model_used=settings.gemini_model,
        )

    def _build_prompt(self, query: str, search_mode: str) -> str:
        mode_instructions = {
            "academic": "Focus on peer-reviewed research, academic papers, and scholarly sources.",
            "writing": "Help with writing, grammar, and content creation.",
            "math": "Solve mathematical problems step by step with clear explanations.",
            "video": "Suggest relevant video resources and YouTube channels.",
            "social": "Include social media trends and community discussions.",
            "auto": "Provide a comprehensive, well-rounded answer.",
        }
        mode_hint = mode_instructions.get(search_mode, mode_instructions["auto"])

        return f"""You are an expert AI research assistant similar to Perplexity AI.
The user asked: "{query}"

Instructions:
- {mode_hint}
- Provide a clear, detailed, and well-structured answer using markdown formatting.
- Use headers (##), bullet points, bold text, and code blocks where appropriate.
- After your main answer, provide exactly 3-5 relevant source citations.

Format your response EXACTLY like this:

ANSWER:
[Your detailed markdown answer here]

SOURCES:
1. Title: [Source Title 1]
   URL: https://[relevant-url-1.com]
   Snippet: [Brief description of what this source covers]

2. Title: [Source Title 2]
   URL: https://[relevant-url-2.com]
   Snippet: [Brief description of what this source covers]

3. Title: [Source Title 3]
   URL: https://[relevant-url-3.com]
   Snippet: [Brief description of what this source covers]
"""

    def _parse_response(self, raw_text: str, query: str) -> tuple[str, list[SourceItem]]:
        """Parse Gemini's response into answer text + source items."""
        answer = raw_text.strip()
        sources: list[SourceItem] = []

        try:
            if "ANSWER:" in raw_text and "SOURCES:" in raw_text:
                parts = raw_text.split("SOURCES:", 1)
                answer_part = parts[0].replace("ANSWER:", "").strip()
                sources_part = parts[1].strip()

                answer = answer_part

                # Parse numbered source blocks
                source_blocks = re.split(r"\n\d+\.\s+", "\n" + sources_part)
                for block in source_blocks:
                    block = block.strip()
                    if not block:
                        continue
                    title_match = re.search(r"Title:\s*(.+)", block)
                    url_match = re.search(r"URL:\s*(https?://\S+)", block)
                    snippet_match = re.search(r"Snippet:\s*(.+)", block, re.DOTALL)

                    if title_match and url_match:
                        sources.append(
                            SourceItem(
                                title=title_match.group(1).strip(),
                                url=url_match.group(1).strip(),
                                snippet=snippet_match.group(1).strip()[:300] if snippet_match else "",
                            )
                        )
        except Exception:
            # Fallback: return the whole response as answer with no sources
            answer = raw_text.strip()

        return answer, sources


# Singleton instance
gemini_service = GeminiService()
