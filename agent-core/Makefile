.DEFAULT_GOAL := help

.PHONY: help dev run test test-cov lint lint-fix format format-check typecheck check migrate migration migrate-down migrate-history db-create sync clean

## ----------------------------------------------------------------------
## Help
## ----------------------------------------------------------------------

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-18s\033[0m %s\n", $$1, $$2}'

## ----------------------------------------------------------------------
## Development
## ----------------------------------------------------------------------

dev: ## Run the development server with auto-reload
	uv run fastapi dev main.py

run: ## Run production server
	uv run fastapi run main.py

## ----------------------------------------------------------------------
## Code Quality & Testing
## ----------------------------------------------------------------------

test: ## Run tests with pytest
	uv run pytest

test-cov: ## Run tests with coverage and missing line numbers
	uv run pytest --cov=. --cov-report=term-missing

lint: ## Check for lint errors with Ruff
	uv run ruff check .

lint-fix: ## Auto-fix lint errors with Ruff
	uv run ruff check --fix .

format: ## Format code with Ruff
	uv run ruff format .
	uv run ruff check --fix .

format-check: ## Check code formatting without modifying files
	uv run ruff format --check .

typecheck: ## Run type checking with mypy
	uv run mypy .

check: format-check lint typecheck test ## Run all checks (format, lint, typecheck, tests)

## ----------------------------------------------------------------------
## Database & Migrations
## ----------------------------------------------------------------------

db-create: ## Create local Postgres database (if it doesn't exist)
	createdb agent_db 2>/dev/null || echo "Database 'agent_db' already exists or createdb failed."

migrate: ## Apply all pending Alembic migrations
	uv run alembic upgrade head

migration: ## Generate a new migration (usage: make migration m="add user table")
	@if [ -z "$(m)" ]; then echo "Error: Migration message required. Usage: make migration m=\"message\""; exit 1; fi
	uv run alembic revision --autogenerate -m "$(m)"

migrate-down: ## Rollback the last migration
	uv run alembic downgrade -1

migrate-history: ## View migration history
	uv run alembic history --verbose

## ----------------------------------------------------------------------
## Dependencies & Maintenance
## ----------------------------------------------------------------------

sync: ## Sync all dependencies and dev tools with uv
	uv sync --dev

clean: ## Remove temporary cache and coverage directories
	rm -rf .pytest_cache .ruff_cache .mypy_cache .coverage htmlcov/ __pycache__ */__pycache__
