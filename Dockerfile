FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

COPY requirements/test.txt requirements/test.txt
RUN pip install --upgrade pip setuptools wheel && pip install -r requirements/test.txt

COPY . .

RUN pip install -e .

CMD ["pytest", "tests/unit"]
