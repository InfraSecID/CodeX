# ============================================================
#  CodeX — Makefile
#  Usage: make <target>
# ============================================================

.PHONY: help setup run sandbox build-model clean logs test

help: ## Show this help
	@echo "CodeX — Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

setup: ## Run full setup (Ollama + model + persona + sandbox)
	./setup.sh

run: ## Chat with CodeX persona
	ollama run codex

sandbox: ## Start Docker sandbox (no internet)
	docker run -it --rm --network none -v $(PWD):/work sandbox

build-model: ## Rebuild CodeX persona from Modelfile
	ollama create codex -f Modelfile

clean: ## Remove build artifacts and containers
	docker rmi sandbox 2>/dev/null || true
	git clean -fdx

logs: ## Show Ollama logs (Linux)
	journalctl -u ollama -f

test: ## Run a quick sanity test on CodeX
	@echo "bikin fungsi python buat reverse string" | ollama run codex
