SERVICES=Iris Shuffle misp suricata-zeek wazuh-docker-main

.PHONY: init up down config

init:
	@for d in $(SERVICES); do \
		cp $$d/.env.example $$d/.env; \
	done

up:
	docker compose up -d

down:
	docker compose down

config:
	docker compose config
