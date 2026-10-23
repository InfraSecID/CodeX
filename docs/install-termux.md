# Install CodeX on Termux (Android)

## Prerequisites
- Android 8+
- 6 GB RAM
- Termux app

## Steps

### 1. Update packages
```bash
pkg update && pkg upgrade -y
pkg install nodejs-lts -y
```

### 2. Install Ollama Termux fork
```bash
npm install -g @mmmbuto/ollama-termux@latest
```

### 3. Start server
```bash
ollama-termux serve &
```

### 4. Pull small model
```bash
ollama-termux pull qwen2.5-coder:1.5b
```

### 5. Run
```bash
ollama-termux run qwen2.5-coder:1.5b
```

## Limitations
- **Docker sandbox not available** on Termux
- **Large models won't run** — use 1.5b or smaller
- **Antigravity cloud** possible but needs OpenCode + Google account
- **Test code on PC** for safety

## Troubleshooting
- **Out of memory**: close other apps
- **Model slow**: use smaller model
- **Server crash**: restart Termux
