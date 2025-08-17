# Project Structure

## Root Files

- **`chatmock.py`**: Main application entry point with CLI interface and Flask server
- **`oauth.py`**: OAuth 2.0 + PKCE authentication implementation
- **`models.py`**: Data classes for tokens, auth bundles, and PKCE codes
- **`utils.py`**: Utility functions for auth, JWT parsing, and API translation
- **`prompt.md`**: System instructions for the ChatGPT backend (required)
- **`requirements.txt`**: Python dependencies
- **`README.md`**: Documentation and usage examples
- **`LICENSE`**: Project license

## Code Organization

### Main Application (`chatmock.py`)
- CLI argument parsing and command routing
- Flask app factory with CORS support
- API endpoint handlers (`/v1/chat/completions`, `/api/chat`, `/api/tags`)
- Request/response translation between formats
- Streaming response handling

### Authentication (`oauth.py`)
- OAuth HTTP server and callback handler
- PKCE code generation and verification
- Token exchange and API key generation
- Login success page rendering

### Data Models (`models.py`)
- `TokenData`: OAuth tokens and account info
- `AuthBundle`: Complete authentication package
- `PkceCodes`: PKCE verifier and challenge codes

### Utilities (`utils.py`)
- JWT token parsing and validation
- Auth file read/write operations
- Message format conversion (OpenAI ↔ ChatGPT backend)
- Server-sent events (SSE) translation
- Tool/function call format conversion

## API Endpoints

### OpenAI Compatible
- `GET /` and `GET /health`: Health check
- `POST /v1/chat/completions`: Chat completions (streaming/non-streaming)

### Ollama Compatible  
- `GET /api/tags`: List available models
- `POST /api/show`: Show model information
- `POST /api/chat`: Chat interface (streaming by default)

## Configuration Files

- **Auth storage**: `~/.chatgpt-local/auth.json` (created after login)
- **Environment variables**: `CHATGPT_LOCAL_CLIENT_ID`, `CHATGPT_LOCAL_HOME`

## Coding Conventions

- Use dataclasses for structured data (`models.py`)
- Type hints throughout codebase (`from __future__ import annotations`)
- Error handling with try/except blocks and proper HTTP status codes
- Consistent naming: snake_case for functions/variables
- CORS headers for all API responses
- Streaming responses use generators with proper cleanup