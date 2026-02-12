FROM python:3.11-slim

WORKDIR /app

# Install Python dependencies (pinned in requirements files)
COPY requirements.txt requirements-dev.txt ./
RUN pip install --no-cache-dir -r requirements.txt -r requirements-dev.txt

# Copy and install the project
COPY . .
RUN pip install --no-cache-dir .

# Run tests by default
CMD ["python3", "-m", "unittest", "discover", "-s", "tests", "-p", "*_test.py"]
