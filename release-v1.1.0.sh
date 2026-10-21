#!/bin/bash
# ============================================================
#  release-v1.1.0.sh — Auto release CodeX v1.1.0
#  Usage: chmod +x release-v1.1.0.sh && ./release-v1.1.0.sh
# ============================================================

set -e

REPO_DIR="$HOME/codex"
REPO="InfraSecID/CodeX"
VERSION="v1.1.0"

cd "$REPO_DIR"

echo "🚀 [1/7] Checkout main + pull..."
git checkout main
git pull origin main

echo "🆕 [2/7] Create release branch..."
git checkout -b "release/$VERSION" || git checkout "release/$VERSION"

# ============================================================
# 📄 Makefile
# ============================================================
echo "📄 [3/7] Writing Makefile..."
cat > Makefile << 'EOF'
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
EOF

# ============================================================
# 📄 docker-compose.yml
# ============================================================
echo "📄 [4/7] Writing docker-compose.yml..."
cat > docker-compose.yml << 'EOF'
# ============================================================
#  CodeX — Docker Compose
#  Usage: docker compose up -d
# ============================================================

services:
  ollama:
    image: ollama/ollama:latest
    container_name: codex-ollama
    ports:
      - "11434:11434"
    volumes:
      - ollama_data:/root/.ollama
    restart: unless-stopped

  sandbox:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: codex-sandbox
    network_mode: none
    volumes:
      - ./work:/work
    stdin_open: true
    tty: true
    profiles: ["sandbox"]

volumes:
  ollama_data:
    driver: local
EOF

# ============================================================
# 📄 .editorconfig
# ============================================================
echo "📄 [5/7] Writing config files..."
cat > .editorconfig << 'EOF'
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

[*.py]
indent_size = 4

[*.{sh,bash}]
indent_size = 2
end_of_line = lf

[*.ps1]
end_of_line = crlf
indent_size = 4

[*.md]
trim_trailing_whitespace = false
indent_size = 2

[Makefile]
indent_style = tab
EOF

# ============================================================
# 📄 .github/workflows/ci.yml
# ============================================================
mkdir -p .github/workflows
cat > .github/workflows/ci.yml << 'EOF'
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  lint:
    name: Lint & Validate
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repo
        uses: actions/checkout@v4

      - name: ShellCheck
        uses: ludeeus/action-shellcheck@master
        with:
          scandir: '.'
          additional_files: 'setup.sh'

      - name: Validate YAML
        run: |
          python3 -c "import yaml; yaml.safe_load(open('docker-compose.yml'))"
          python3 -c "import yaml; yaml.safe_load(open('.github/workflows/ci.yml'))"

      - name: Validate Makefile
        run: make help

      - name: Check file permissions
        run: |
          test -x setup.sh || (echo "❌ setup.sh not executable" && exit 1)
          test -x split.py || (echo "❌ split.py not executable" && exit 1)
          echo "✅ All scripts executable"
EOF

# ============================================================
# 📄 .pre-commit-config.yaml
# ============================================================
cat > .pre-commit-config.yaml << 'EOF'
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.6.0
    hooks:
      - id: check-added-large-files
        args: ['--maxkb=500']
      - id: check-merge-conflict
      - id: check-yaml
      - id: end-of-file-fixer
      - id: trailing-whitespace
      - id: detect-private-key
      - id: forbid-submodules

  - repo: https://github.com/shellcheck-py/shellcheck-py
    rev: v0.10.0.1
    hooks:
      - id: shellcheck
        args: ['--severity=warning']

  - repo: https://github.com/psf/black
    rev: 24.8.0
    hooks:
      - id: black
        files: '\.py$'
EOF

# ============================================================
# 📄 .gitignore (tambahan)
# ============================================================
cat >> .gitignore << 'EOF'

# --- v1.1.0 additions ---
.ollama/
work/
*.tgz
*.tar.gz
.pre-commit-config.yaml.bak
EOF

# ============================================================
# 📄 RELEASE_NOTES.md
# ============================================================
cat > RELEASE_NOTES.md << 'EOF'
# CodeX v1.1.0 — Quality of Life Update

> Released: 2026-10-21
> Type: Minor release (backward compatible)

---

## 🎉 What's New

### 🛠️ Makefile
Shortcut command biar gak perlu ketik panjang:
