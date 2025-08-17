FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create directory for auth storage
RUN mkdir -p /app/.chatgpt-local

# Expose port
EXPOSE 8000

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV CHATGPT_LOCAL_HOME=/app/.chatgpt-local

# Run the application
CMD ["python", "chatmock.py", "serve", "--host", "0.0.0.0", "--port", "8000"]