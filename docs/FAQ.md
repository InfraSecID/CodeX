# CodeX FAQ

## General

### What is CodeX?
CodeX is an offline AI coding assistant powered by Ollama + DeepSeek.

### Is it free?
Yes. No API keys, no subscriptions.

### Does it work offline?
Yes. After setup, no internet needed for local models.

### What models are supported?
- deepseek-coder:6.7b (default)
- qwen2.5-coder:1.5b (lightweight)
- codellama:7b (alternative)
- Antigravity cloud models (optional, v1.2.0+)

## Installation

### How much RAM do I need?
- 8 GB minimum (16 GB recommended)
- 4 GB for qwen-1.5b

### Does it work on Termux?
Yes, but with limitations (no Docker, small models only).

### Can I use it on Windows?
Yes. Use `setup.ps1`.

## Usage

### How do I switch models?
```bash
./switch-model.sh qwen-1.5b
```

### How do I benchmark models?
```bash
./benchmark.sh
```

### How do I run with a banner?
```bash
./codex-cli.sh
```

### How do I add Antigravity cloud?
```bash
./setup-antigravity.sh
opencode auth login
```

## Hybrid Mode

### Is Antigravity free?
Antigravity requires a Google account. Check Google's pricing for AI Pro.

### Does Antigravity work offline?
No. Antigravity models are **cloud** — needs internet.

### Can I use both local and cloud?
Yes. CodeX is hybrid: switch with `/model` in OpenCode.

### Is Antigravity plugin official?
No. `opencode-antigravity-auth` is **unofficial** — use at your own risk.

## Troubleshooting

### Why is it slow?
- Model too big for your RAM
- Use smaller model
- Close other apps

### Why does it refuse requests?
- Built-in model safety
- Use persona prompt to reduce refusals
- Not 100% bypassable

### Is it safe to run untrusted code?
- **No.** Always use Docker sandbox.
- `docker run -it --rm --network none -v $(pwd):/work sandbox`
