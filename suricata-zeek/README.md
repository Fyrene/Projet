# Suricata and Zeek Sensors

This compose file starts Suricata and Zeek network sensors along with a Filebeat shipper.

1. Copy the environment file:

```bash
cp .env.example .env
```

2. Start the sensors:

```bash
docker compose up -d
```
