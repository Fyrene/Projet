# Projet

This repository contains Docker compose environments for multiple services. Each service directory includes a `docker-compose.yml` file and a `.env.example` that you should copy to `.env` before deploying with Docker Compose.

## Available services
- Iris
- Shuffle
- misp
- suricata-zeek
- wazuh-docker-main

You can now orchestrate everything from the repository root. After copying every `.env.example` to `.env` within each service directory, run:

```bash
docker compose up -d
```

This uses the root `docker-compose.yml` which extends the individual service files. You may also run `docker compose config` to verify the merged configuration.
