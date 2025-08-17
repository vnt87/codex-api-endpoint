# Technology Stack

## Core Technologies

- **Python 3.7+**: Main programming language
- **Flask**: Web framework for API server
- **Requests**: HTTP client for upstream ChatGPT API calls
- **OAuth 2.0 + PKCE**: Authentication flow implementation

## Key Dependencies

- `flask`: Web server and API routing
- `requests`: HTTP client for ChatGPT backend communication

## Architecture Patterns

- **Proxy server pattern**: Translates between client APIs and ChatGPT backend
- **OAuth flow**: Secure authentication using ChatGPT credentials
- **Streaming responses**: Server-sent events (SSE) for real-time responses
- **API translation**: Converts OpenAI/Ollama formats to ChatGPT backend format

## Common Commands

### Setup and Authentication
```bash
# Install dependencies
pip install -r requirements.txt

# Login with ChatGPT account
python chatmock.py login

# Verify authentication
python chatmock.py info
```

### Running the Server
```bash
# Start server (default: http://127.0.0.1:8000)
python chatmock.py serve

# With custom reasoning settings
python chatmock.py serve --reasoning-effort low --reasoning-summary none

# With verbose logging
python chatmock.py serve --verbose
```

### Testing
```bash
# Test with curl
curl http://127.0.0.1:8000/v1/chat/completions \
  -H "Authorization: Bearer key" \
  -H "Content-Type: application/json" \
  -d '{"model":"gpt-5","messages":[{"role":"user","content":"hello"}]}'
```

## Configuration

- **Client ID**: Configurable via `CHATGPT_LOCAL_CLIENT_ID` environment variable
- **Home directory**: Configurable via `CHATGPT_LOCAL_HOME` or `CODEX_HOME`
- **Auth storage**: `~/.chatgpt-local/auth.json` (mode 0600)
- **Base instructions**: `prompt.md` file (required in same directory)