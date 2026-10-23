#!/bin/bash
# ============================================================
#  codex-cli.sh — CodeX CLI with figlet banner
#  Usage: ./codex-cli.sh [model]
#  Requires: figlet (optional: lolcat for color)
# ============================================================

MODEL="${1:-codex}"

# Check figlet
if ! command -v figlet &> /dev/null; then
    echo "⚠️  figlet not installed. Install with: sudo apt install figlet"
    echo "Falling back to plain mode..."
    echo ""
    ollama run "$MODEL"
    exit 0
fi

# Banner
clear
if command -v lolcat &> /dev/null; then
    figlet -f big "CodeX" | lolcat
else
    figlet -f big "CodeX"
fi

echo ""
echo "  🤖 Offline AI Coding Assistant"
echo "  📡 Model: $MODEL"
echo "  🛡️  Sandbox: docker run -it --rm --network none -v \$(pwd):/work sandbox"
echo "  🌐 Hybrid: use Antigravity for cloud models (see README)"
echo ""
echo "  Type /bye to exit"
echo "  ─────────────────────────────────────────────"
echo ""

# Start CodeX
ollama run "$MODEL"
