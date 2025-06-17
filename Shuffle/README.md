# Shuffle

Shuffle provides workflow automation for security operations. The web interface
is reachable on port **3001** (HTTP) or **3443** (HTTPS) and the backend listens
on **5001**. It stores its data in `../volumes/shuffle-database` by default.

Documentation: <https://github.com/frikky/shuffle>

1. Prepare the environment:

```bash
cp .env.example .env
mkdir -p ../volumes/shuffle-database
```
You can edit `.env` to change default ports or proxy settings.

2. Start the containers:

```bash
docker compose up -d
```
You can then browse to [http://localhost:3001](http://localhost:3001)
or [https://localhost:3443](https://localhost:3443).
