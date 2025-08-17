# ChatMock Docker Deployment

This guide covers deploying ChatMock using Docker and Docker Compose.

## Quick Start

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd chatmock
   ```

2. **Update docker-compose.yml**
   Replace `${GITHUB_REPOSITORY}` with your actual GitHub repository name:
   ```yaml
   image: ghcr.io/your-username/your-repo:latest
   ```

3. **Run with Docker Compose**
   ```bash
   docker-compose up -d
   ```

4. **Initial Setup (Authentication)**
   Since OAuth requires a browser, you'll need to set up authentication first:
   
   ```bash
   # Run login command in the container
   docker-compose exec chatmock python chatmock.py login
   ```
   
   This will display a URL - open it in your browser to complete OAuth flow.

5. **Test the API**
   ```bash
   curl http://localhost:8000/health
   ```

## Configuration

### Environment Variables

- `CHATGPT_LOCAL_CLIENT_ID`: Override the default OAuth client ID
- `CHATGPT_LOCAL_HOME`: Auth storage directory (default: `/app/.chatgpt-local`)

### Volumes

- `chatmock_auth`: Persists authentication data between container restarts
- Optional: Mount custom `prompt.md` file

### Custom Prompt

To use a custom system prompt:

```yaml
volumes:
  - ./custom-prompt.md:/app/prompt.md:ro
```

## GitHub Container Registry

The Docker image is automatically built and pushed to GitHub Container Registry (ghcr.io) via GitHub Actions.

### Available Tags

- `latest`: Latest build from main/master branch
- `v*`: Semantic version tags (e.g., `v1.0.0`)
- Branch names: Builds from specific branches

### Manual Build

```bash
# Build locally
docker build -t chatmock .

# Run locally built image
docker run -p 8000:8000 chatmock
```

## Production Deployment

### Security Considerations

1. **Reverse Proxy**: Use nginx or Traefik for HTTPS termination
2. **Authentication**: Consider adding API key authentication for public deployment
3. **Rate Limiting**: Implement rate limiting to prevent abuse
4. **Monitoring**: Set up logging and monitoring

### Example with Traefik

```yaml
services:
  chatmock:
    image: ghcr.io/your-username/your-repo:latest
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.chatmock.rule=Host(`api.yourdomain.com`)"
      - "traefik.http.routers.chatmock.tls.certresolver=letsencrypt"
      - "traefik.http.services.chatmock.loadbalancer.server.port=8000"
```

## Troubleshooting

### Container Won't Start
- Check logs: `docker-compose logs chatmock`
- Verify `prompt.md` exists in the container

### Authentication Issues
- Ensure OAuth redirect URI matches your deployment URL
- Check that auth volume is properly mounted
- Verify ChatGPT credentials are valid

### Health Check Failing
- Container needs curl installed (included in Dockerfile)
- Port 8000 must be accessible inside container

## API Usage

Once running, the API is compatible with OpenAI and Ollama formats:

```bash
# OpenAI format
curl http://localhost:8000/v1/chat/completions \
  -H "Authorization: Bearer key" \
  -H "Content-Type: application/json" \
  -d '{"model":"gpt-5","messages":[{"role":"user","content":"Hello"}]}'

# Ollama format
curl http://localhost:8000/api/chat \
  -H "Content-Type: application/json" \
  -d '{"model":"gpt-5","messages":[{"role":"user","content":"Hello"}]}'
```