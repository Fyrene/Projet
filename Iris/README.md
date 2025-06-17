# Iris

Iris is an incident response platform. The compose file in this directory starts
the web application, the worker, the database and an Nginx frontend. The web
interface is exposed on port **8444** by default.

Documentation: <https://github.com/dfir-iris/iris-web>

1. Copy the example environment file:

```bash
cp .env.example .env
```
Edit `.env` to adjust database credentials or change the exposed port if needed.

2. Launch the service:

```bash
docker compose up -d
```
The web interface will then be available on [https://localhost:8444](https://localhost:8444).
