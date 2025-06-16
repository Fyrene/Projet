SERVICES=Iris Shuffle misp suricata-zeek wazuh-docker-main

.PHONY: init up down config generate-indexer-certs

init: generate-indexer-certs
	@for d in $(SERVICES); do \
		cp $$d/.env.example $$d/.env; \
	done

up:
	docker compose up -d

down:
	docker compose down

config:
	docker compose config

# Generate certificates for Wazuh Indexer
generate-indexer-certs:
	docker compose -f wazuh-docker-main/generate-indexer-certs.yml run --rm generator

