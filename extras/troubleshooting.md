# Troubleshooting — PR Assistant PRO

## Docker not found
If you see "docker: command not found" on Linux, install Docker CE + Compose plugin (see official docs).

## Service not responding on /health
1. Check containers: `docker compose ps`
2. View logs: `docker compose logs web --tail 200`
3. Ensure .env has correct DATABASE_URL and GITHUB_TOKEN or app credentials.

## GitHub App authentication
If you use GitHub App, ensure GITHUB_APP_ID and GITHUB_PRIVATE_KEY_PATH are set and key file is readable by container.
