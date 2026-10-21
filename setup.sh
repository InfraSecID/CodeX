#!/bin/bash
# ============================================================
#  CodeX — Automated Setup (Linux / macOS)
#  Usage: chmod +x setup.sh && ./setup.sh
# ============================================================

set -e

echo "🚀 [1/5] Installing Ollama..."
if ! command -v ollama &> /dev/null; then
    curl -fsSL https://ollama.com/install.sh | sh
else
    echo "✅ Ollama already installed. Nice."
fi

echo "🧠 [2/5] Pulling model... (grab a coffee, this takes a bit)"
ollama pull deepseek-coder:6.7b

echo "🎭 [3/5] Creating CodeX persona..."
cat > /tmp/Modelfile << 'EOF'
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
EOF
ollama create codex -f /tmp/Modelfile

echo "🛡️ [4/5] Building Docker sandbox..."
mkdir -p ~/codex-sandbox
cat > ~/codex-sandbox/Dockerfile << 'EOF'
FROM ubuntu:24.04
RUN apt update && apt install -y python3 python3-pip curl git vim netcat-openbsd build-essential && rm -rf /var/lib/apt/lists/*
WORKDIR /work
CMD ["/bin/bash"]
EOF
docker build -t sandbox ~/codex-sandbox

echo "✅ [5/5] Done! You're officially a local AI dev now."
echo ""
echo "🔥 How to use:"
echo "   Run model : ollama run codex"
echo "   Sandbox   : docker run -it --rm --network none -v \$(pwd):/work sandbox"
echo "   OpenCode  :"
echo "     Base URL : http://localhost:11434/v1"
echo "     API Key  : ollama"
echo "     Model    : ollama/codex"