# Projet

This repository gathers several Docker Compose configurations that together form a small security lab. Each service lives in its own directory with a `docker-compose.yml` file and a `.env.example` to configure the environment.

## Prerequisites

- Docker and the Docker Compose v2 plugin installed
- Clone this repository and run the initialization script which prepares every
  environment file (including the global `.env`), creates required directories
  and generates Wazuh certificates:

```bash
make init
```

## Running the full stack

The provided `Makefile` lets you start or stop every container at once:

```bash
make up       # start all containers
make down     # stop and remove containers
```

You can inspect the resulting configuration with `make config`.

## Service overview

| Service | Role | Ports (default) | Start command |
|---------|------|----------------|---------------|
| [Iris](Iris/README.md) | Incident response platform | 8444/tcp | `docker compose -f Iris/docker-compose.yml up -d` |
| [Shuffle](Shuffle/README.md) | Automation engine | 3001/tcp, 3443/tcp, 5001/tcp, 9220/tcp | `docker compose -f Shuffle/docker-compose.yml up -d` |
| [MISP](misp/README.md) | Threat intelligence sharing | 8080/tcp, 8445/tcp | `docker compose -f misp/docker-compose.yml up -d` |
| [suricata-zeek](suricata-zeek/README.md) | Network IDS sensors | host network | `docker compose -f suricata-zeek/docker-compose.yml up -d` |
| [wazuh-docker-main](wazuh-docker-main/README.md) | SIEM stack | 1514/tcp, 1515/tcp, 514/udp, 55000/tcp, 9200/tcp, 8443/tcp | `docker compose -f wazuh-docker-main/docker-compose.yml up -d` |

The root `docker-compose.yml` extends the compose files found in each directory
so everything can be orchestrated together.

## Data persistence

Persistent data for some services is stored under the top-level `volumes` directory.
The initialization script creates the required folders automatically, but you can
also create them manually:

```bash
mkdir -p volumes/shuffle-database
```
