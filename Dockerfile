FROM python:3.12-slim

WORKDIR /app

COPY pyproject.toml .
RUN pip install --no-cache-dir --quiet uv && \
    uv pip install --quiet --system .

COPY src/app ./app

ENTRYPOINT ["python", "-m", "app.main"]
CMD ["--name", "World"]
