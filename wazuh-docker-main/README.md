# Deploy Wazuh Docker in single node configuration

This directory bundles the official Wazuh containers into a minimal SIEM stack composed of a manager, an indexer and a dashboard.

Copy `.env.example` to `.env` in this directory before starting the stack.

It can be deployed by following these steps:

1) Increase `max_map_count` on your host (Linux). This command must be run with root permissions:
```bash
sysctl -w vm.max_map_count=262144
```
2) Generate the certificates using the provided image. This step is automatically executed when running `make init` from the repository root. If your environment requires a proxy, add the `HTTP_PROXY` variable to `generate-indexer-certs.yml` and run manually:
```bash
docker compose -f generate-indexer-certs.yml run --rm generator
```
3) Start the environment with docker compose:

- In the foreground:
```bash
docker compose up
```
- In the background:
```bash
docker compose up -d
```

The environment takes about 1 minute to get up for the first time since Wazuh Indexer must initialize its data.
