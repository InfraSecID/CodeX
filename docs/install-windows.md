# Install CodeX on Windows

## Prerequisites
- Windows 10+
- 8 GB RAM (16 GB recommended)
- PowerShell (admin)

## Steps

### 1. Install Ollama
```powershell
winget install Ollama.Ollama
```

### 2. Pull model
```powershell
ollama pull deepseek-coder:6.7b
```

### 3. Clone repo
```powershell
git clone https://github.com/InfraSecID/CodeX.git
cd CodeX
```

### 4. Setup
```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\setup.ps1
```

### 5. Run
```powershell
ollama run codex
```

### 6. (Optional) Antigravity cloud
```powershell
bash setup-antigravity.sh
opencode auth login
```

## Troubleshooting
- **Ollama not found**: restart PowerShell
- **Model slow**: use `qwen2.5-coder:1.5b`
- **Docker error**: enable drive sharing in Docker Desktop
- **Antigravity auth fails**: check Google account, retry `opencode auth login`
