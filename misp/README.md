# MISP

This directory contains a Docker Compose deployment of MISP, the threat intelligence sharing platform. The web interface is exposed on ports **8080** (HTTP) and **8445** (HTTPS).

Documentation: <https://www.misp-project.org/>

1. Copy the environment file:

```bash
cp .env.example .env
```
Adjust values in `.env` such as the `ADMIN_EMAIL` or database credentials if needed.

2. Launch MISP:

```bash
docker compose up -d
```
MISP should then be reachable at [https://localhost:8445](https://localhost:8445).
