# Projet

This repository contains Docker compose environments for multiple services. Each service directory includes a `docker-compose.yml` file and a `.env.example` that you should copy to `.env` before deploying with Docker Compose.

## Available services
- Iris
- Shuffle
- misp
- suricata-zeek
- wazuh-docker-main

You can now orchestrate everything from the repository root. The provided Makefile automates the setup:

```bash
make init   # copy every .env.example to .env
make up     # start all containers
```

Use `make down` to stop the stack. The root `docker-compose.yml` extends the individual service files, and you can run `docker compose config` to verify the merged configuration.
