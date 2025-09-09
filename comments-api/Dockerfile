# Builder stage
FROM python:3.12-slim AS builder

RUN groupadd --gid 1000 appgroup && useradd --uid 1000 --gid appgroup --shell /bin/bash appuser

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Final stage
FROM python:3.12-slim

RUN groupadd --gid 1000 appgroup && useradd --uid 1000 --gid appgroup --shell /bin/bash appuser

WORKDIR /app

COPY --from=builder --chown=appuser:appgroup /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder --chown=appuser:appgroup /usr/local/bin/flask /usr/local/bin/

COPY . .

RUN chown -R appuser:appgroup /app

USER appuser

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0"]