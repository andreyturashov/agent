.DEFAULT_GOAL := help

.PHONY: help dev run test test-cov lint lint-fix format format-check typecheck check migrate migration migrate-down db-create sync clean

help: ## Show this help message
	@$(MAKE) -C agent-core help

dev: ## Run the development server with auto-reload
	@$(MAKE) -C agent-core dev

run: ## Run production server
	@$(MAKE) -C agent-core run

test: ## Run tests with pytest
	@$(MAKE) -C agent-core test

test-cov: ## Run tests with coverage
	@$(MAKE) -C agent-core test-cov

lint: ## Check lint with Ruff
	@$(MAKE) -C agent-core lint

lint-fix: ## Auto-fix lint with Ruff
	@$(MAKE) -C agent-core lint-fix

format: ## Format code with Ruff
	@$(MAKE) -C agent-core format

typecheck: ## Run type checking with mypy
	@$(MAKE) -C agent-core typecheck

check: ## Run all checks (format, lint, typecheck, tests)
	@$(MAKE) -C agent-core check

migrate: ## Apply Alembic migrations
	@$(MAKE) -C agent-core migrate

migration: ## Generate new migration (usage: make migration m="message")
	@$(MAKE) -C agent-core migration m="$(m)"

db-create: ## Create local database
	@$(MAKE) -C agent-core db-create

clean: ## Clean cache files
	@$(MAKE) -C agent-core clean
