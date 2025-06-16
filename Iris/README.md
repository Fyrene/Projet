# Iris

Iris is an incident response platform. The compose file in this directory starts the web application, the worker, the database and an Nginx frontend.

1. Copy the example environment file:

```bash
cp .env.example .env
```

2. Launch the service:

```bash
docker compose up -d
```
