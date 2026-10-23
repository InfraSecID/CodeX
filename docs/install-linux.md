# Install CodeX on Linux

## Prerequisites
- Any modern distro
- 8 GB RAM
- sudo access

## Steps

### 1. Install Ollama
```bash
curl -fsSL https://ollama.com/install.sh | sh
```

### 2. Pull model
```bash
ollama pull deepseek-coder:6.7b
```

### 3. Clone repo
```bash
git clone https://github.com/InfraSecID/CodeX.git
cd CodeX
```

### 4. Setup
```bash
chmod +x setup.sh
./setup.sh
```

### 5. Run
```bash
ollama run codex
```

### 6. (Optional) Antigravity cloud
```bash
chmod +x setup-antigravity.sh
./setup-antigravity.sh
opencode auth login
```

## Troubleshooting
- **Permission denied**: `sudo usermod -aG docker $USER` then re-login
- **Model slow**: use `qwen2.5-coder:1.5b`
- **Ollama not starting**: `systemctl status ollama`
- **Antigravity auth fails**: check Google account, retry `opencode auth login`
