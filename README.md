# Projet

This repository gathers several Docker Compose configurations that together form a small security lab. Each service lives in its own directory with a `docker-compose.yml` file and a `.env.example` to configure the environment.

## Prerequisites

- Docker and the Docker Compose v2 plugin installed
- Clone this repository and run the initialization step which copies each `.env.example` to `.env` and generates the Wazuh certificates:

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

- **Iris** – incident response platform ([Iris/README.md](Iris/README.md))
- **Shuffle** – automation engine ([Shuffle/README.md](Shuffle/README.md))
- **MISP** – threat intelligence sharing ([misp/README.md](misp/README.md))
- **suricata-zeek** – network IDS sensors ([suricata-zeek/README.md](suricata-zeek/README.md))
- **wazuh-docker-main** – SIEM stack ([wazuh-docker-main/README.md](wazuh-docker-main/README.md))

The root `docker-compose.yml` extends the compose files found in each directory so everything can be orchestrated together.
