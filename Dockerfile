# ---- Base image ----
FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# ---- System dependencies ----
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# ---- Copy EVERYTHING first (required for editable installs) ----
COPY . .

# ---- Upgrade pip & pin pytest stack ----
RUN pip install --upgrade pip setuptools wheel \
    && pip install \
        pytest==7.4.4 \
        "pluggy<1.4"

# ---- Install Allure mono-repo requirements ----
RUN pip install -r requirements.txt

# ---- Default: run tests ----
CMD ["python3", "-m", "unittest", "discover", "src/test"]
