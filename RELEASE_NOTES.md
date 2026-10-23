# CodeX v1.2.0 — Multi-Model + CLI Banner + Antigravity Hybrid

> Released: 2026-10-21
> Type: Minor release (backward compatible)

## What's New

### Multi-Model Support
CodeX now supports multiple models:
- **deepseek-coder:6.7b** — default, best quality
- **qwen2.5-coder:1.5b** — lightweight, low-RAM
- **codellama:7b** — alternative

### switch-model.sh
Switch active model easily:
```bash
./switch-model.sh qwen-1.5b
```

### benchmark.sh
Compare model performance:
```bash
./benchmark.sh
```

### codex-cli.sh
CLI wrapper with figlet banner:
```bash
./codex-cli.sh
```

### setup-antigravity.sh (NEW)
Add Google Antigravity as cloud provider:
```bash
./setup-antigravity.sh
opencode auth login
```

### models/ folder
Each model has its own Modelfile in `models/`.

### docs/ folder
Full installation guides for Windows, Linux, Termux, plus troubleshooting and FAQ.

## Hybrid Mode
CodeX is now **hybrid**:
- **Local** (Ollama): offline, private, free
- **Cloud** (Antigravity): online, powerful, Google account

## Improvements
- README completely rewritten with v1.2.0 features
- Added repository structure section
- Added detailed requirements table
- Added badges (CI, release, stars, license)
- Added links to docs, changelog, contributing
- Troubleshooting expanded with 10+ entries

## Upgrade Guide
```bash
cd ~/codex
git pull origin main
./switch-model.sh deepseek-6.7b
```

## Stats
- Files added: 12
- Lines added: ~650
- Breaking changes: None

Full Changelog: https://github.com/InfraSecID/CodeX/compare/v1.1.0...v1.2.0
