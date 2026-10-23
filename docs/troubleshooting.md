# CodeX Troubleshooting Guide

## Common Issues

### Ollama not found
```bash
# Linux
curl -fsSL https://ollama.com/install.sh | sh

# Windows
winget install Ollama.Ollama
```

### Model not found
```bash
ollama list
ollama pull deepseek-coder:6.7b
```

### OpenCode not connecting
```bash
# Check Ollama
curl http://localhost:11434/v1/models

# Check config
cat ~/.config/opencode/opencode.json
```

### Docker permission denied (Linux)
```bash
sudo usermod -aG docker $USER
# then re-login
```

### Docker can't mount folder (Windows)
- Open Docker Desktop
- Settings → Resources → File Sharing
- Add your drive

### Out of memory
- Use smaller model: `./switch-model.sh qwen-1.5b`
- Close other apps
- Increase swap (Linux)

### figlet not found
```bash
sudo apt install figlet
```

### Script permission denied
```bash
chmod +x switch-model.sh benchmark.sh codex-cli.sh setup-antigravity.sh
```

### Makefile fails (missing separator)
Makefile requires **tabs**, not spaces. Check:
```bash
cat -A Makefile | head -5
```
You should see `^I` (tab) before commands.

### CI fails on ShellCheck
Add `severity: 'error'` to `.github/workflows/ci.yml`:
```yaml
- name: ShellCheck
  uses: ludeeus/action-shellcheck@master
  with:
    severity: 'error'
```

### YAML invalid
```bash
python3 -c "import yaml; yaml.safe_load(open('docker-compose.yml'))"
```

### Antigravity auth fails
```bash
opencode auth logout
opencode auth login
```
Make sure you use the correct Google account.

### Antigravity not showing in `/model`
- Restart OpenCode after `setup-antigravity.sh`
- Check `~/.config/opencode/opencode.json` has `"plugin": ["opencode-antigravity-auth@latest"]`
- Run `opencode auth login` again

### Port 49374 in use (OpenCode server)
```bash
# Kill stale process
pkill -f opencode
# Restart
opencode
```

## Still stuck?
- Open an issue: https://github.com/InfraSecID/CodeX/issues
- Check discussions: https://github.com/InfraSecID/CodeX/discussions
