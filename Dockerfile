FROM python:3.13-slim

RUN apt-get update && apt-get install -y \
    gcc \
    pipx \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

ENV PATH="$PATH:/root/.local/bin"

WORKDIR /app
COPY app pyproject.toml poetry.lock ./

RUN pipx install poetry
RUN poetry install

# Use an entrypoint script to allow for variable substitution
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]