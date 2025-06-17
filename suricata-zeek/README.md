# Suricata and Zeek Sensors

This compose file starts Suricata and Zeek network sensors along with a Filebeat
shipper. Containers run in host network mode so they can monitor the interface
specified in the `IFACE` variable (default `eth0`).

Suricata: <https://suricata.io/>

Zeek: <https://zeek.org/>

1. Copy the environment file:

```bash
cp .env.example .env
```
Edit `.env` to set the interface name and credentials for your Wazuh Indexer.

2. Start the sensors:

```bash
docker compose up -d
```
Logs are forwarded to the Wazuh stack and stored under the `zeek-logs` and
`suricata-logs` volumes.
