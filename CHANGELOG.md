# Changelog

All notable changes to CodeX will be documented here.

## [1.2.0] - 2026-10-21

### Added
- Multi-model support: deepseek-coder:6.7b, qwen2.5-coder:1.5b, codellama:7b
- `switch-model.sh` — switch active model
- `benchmark.sh` — compare model performance
- `codex-cli.sh` — CLI wrapper with figlet banner
- `setup-antigravity.sh` — add Antigravity cloud provider
- Hybrid mode: local (Ollama) + cloud (Antigravity)
- `models/` folder with per-model Modelfiles
- `docs/` folder with install guides (Windows, Linux, Termux), troubleshooting, FAQ
- README completely rewritten with v1.2.0 features
- Badges: CI, release, stars, license
- Repository structure section
- Detailed requirements table
- Expanded troubleshooting table (17+ entries)
- Links to docs, changelog, contributing

### Changed
- README now uses full-replace format
- Troubleshooting table expanded
- `codex-cli.sh` banner now shows hybrid mode hint

### Fixed
- CI workflow simplified with dependency install
- ShellCheck severity set to error-only
- OpenCode server port conflict noted in troubleshooting

## [1.0.0] - 2026-10-21

### Added
- Initial release of CodeX offline AI coding assistant.
- Ollama + DeepSeek persona setup.
- Docker sandbox for safe code testing.
- Cross-platform setup scripts (Linux, macOS, Windows, Termux).
- Full documentation with troubleshooting and test prompts.
