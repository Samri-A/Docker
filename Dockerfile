FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# If some deps need compiling, keep build-essential. Otherwise you can remove it later.
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install runtime deps first (cache friendly)
COPY requirements.txt ./
RUN python -m pip install --upgrade pip setuptools wheel \
 && python -m pip install --no-cache-dir -r requirements.txt

# Copy the project and install it (so `import scrape_up` works)
COPY . .
RUN python -m pip install --no-cache-dir -e .

# Default: run unit tests
CMD ["python", "-m", "unittest", "discover", "-s", "src/test", "-p", "*_test.py"]
