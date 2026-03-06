# Perplexity Clone — Backend API

FastAPI backend powered by **Google Gemini AI** for the Perplexity Clone project.

## 📁 Folder Structure

```
backend/
├── .env                    ← Your secrets (GEMINI_API_KEY)
├── .env.example            ← Template – commit this, NOT .env
├── requirements.txt        ← Python dependencies
└── app/
    ├── main.py             ← FastAPI entry point
    ├── core/
    │   └── config.py       ← Settings (reads .env)
    ├── models/
    │   └── schemas.py      ← Pydantic request/response models
    ├── services/
    │   └── gemini_service.py  ← Gemini API integration
    └── api/
        ├── router.py       ← Aggregated routes
        └── routes/
            ├── health.py   ← GET  /health
            └── search.py   ← POST /api/search
```

## 🚀 Quick Start

### 1. Set up your Gemini API Key

Edit the `.env` file:
```env
GEMINI_API_KEY=your_actual_gemini_api_key_here
```

> Get your free key at: https://aistudio.google.com/app/apikey

### 2. Install dependencies

```bash
cd backend
pip install -r requirements.txt
```

### 3. Run the server

```bash
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### 4. Test

```bash
# Health check
curl http://127.0.0.1:8000/health

# Search
curl -X POST http://127.0.0.1:8000/api/search \
  -H "Content-Type: application/json" \
  -d '{"query": "What is quantum computing?", "search_mode": "auto"}'
```

## 📖 API Docs

Open [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs) for interactive Swagger UI.

## 🔑 Environment Variables

| Variable | Default | Description |
|---|---|---|
| `GEMINI_API_KEY` | *(required)* | Google Gemini API key |
| `GEMINI_MODEL` | `gemini-1.5-flash` | Gemini model to use |
| `CORS_ORIGINS` | `*` | Allowed CORS origins |
| `APP_HOST` | `0.0.0.0` | Server host |
| `APP_PORT` | `8000` | Server port |

## 🔌 Endpoints

| Method | Path | Description |
|---|---|---|
| `GET` | `/` | API info |
| `GET` | `/health` | Health check |
| `POST` | `/api/search` | AI search with Gemini |

## Search Modes

`auto` · `academic` · `writing` · `math` · `video` · `social`
