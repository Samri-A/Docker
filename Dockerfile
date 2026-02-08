FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1
ENV PIP_NO_CACHE_DIR=1

WORKDIR /app

# Install build dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
         build-essential \
       gcc \
       libffi-dev \
       libssl-dev \
       ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy project files
COPY . .

# Upgrade packaging tools and install package
RUN python -m pip install --upgrade pip setuptools wheel \
    && python -m pip install .

ENTRYPOINT ["i3-agenda"]
CMD ["--help"]


    
