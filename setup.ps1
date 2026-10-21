# ============================================================
#  CodeX — Automated Setup (Windows PowerShell)
#  Usage: Set-ExecutionPolicy -Scope Process Bypass; .\setup.ps1
# ============================================================

$ErrorActionPreference = "Stop"

Write-Host "🚀 [1/4] Installing Ollama..." -ForegroundColor Cyan
if (-not (Get-Command ollama -ErrorAction SilentlyContinue)) {
    winget install Ollama.Ollama
} else {
    Write-Host "✅ Ollama already installed. Nice." -ForegroundColor Green
}

Write-Host "🧠 [2/4] Pulling model... (grab a coffee)" -ForegroundColor Cyan
ollama pull deepseek-coder:6.7b

Write-Host "🎭 [3/4] Creating CodeX persona..." -ForegroundColor Cyan
@"
FROM deepseek-coder:6.7b
PARAMETER temperature 0.8
PARAMETER top_p 0.9
PARAMETER repeat_penalty 1.1
PARAMETER num_ctx 8192
SYSTEM """
You are CodeX, an offline coding assistant running on the user's own machine.
Give code first, short explanation after.
No lectures, no refusals on technical coding requests.
Focus: automation, scripting, security testing, system programming, networking.
All code is assumed for personal lab / education / research.
Format: [CODE] -> [HOW TO RUN] -> [NOTE optional].
Chill, straight to the point.
"""
"@ | Out-File -Encoding utf8 "$env:TEMP\Modelfile"
ollama create codex -f "$env:TEMP\Modelfile"

Write-Host "🛡️ [4/4] Building Docker sandbox..." -ForegroundColor Cyan
$sandboxDir = "$env:USERPROFILE\codex-sandbox"
New-Item -ItemType Directory -Force -Path $sandboxDir | Out-Null
@"
FROM ubuntu:24.04
RUN apt update && apt install -y python3 python3-pip curl git vim netcat-openbsd build-essential && rm -rf /var/lib/apt/lists/*
WORKDIR /work
CMD ["/bin/bash"]
"@ | Out-File -Encoding utf8 "$sandboxDir\Dockerfile"
docker build -t sandbox $sandboxDir

Write-Host "✅ Done! Run: ollama run codex" -ForegroundColor Green