#!/bin/bash
# ============================================================
#  setup-antigravity.sh — Add Antigravity (cloud) to CodeX
#  Usage: ./setup-antigravity.sh
#  Note: Requires internet + Google account
# ============================================================

set -e

CONFIG_DIR="$HOME/.config/opencode"
CONFIG_FILE="$CONFIG_DIR/opencode.json"

echo "🌐 [1/4] Setting up Antigravity for CodeX..."
echo ""

# Check opencode installed
if ! command -v opencode &> /dev/null; then
    echo "❌ opencode not found. Install it first:"
    echo "   https://opencode.ai/docs/install"
    exit 1
fi

# Create config dir
mkdir -p "$CONFIG_DIR"

# Backup existing config
if [ -f "$CONFIG_FILE" ]; then
    echo "📦 Backing up existing config..."
    cp "$CONFIG_FILE" "$CONFIG_FILE.bak.$(date +%s)"
fi

# Write config with Ollama + Antigravity plugin
echo "📝 [2/4] Writing opencode.json..."
cat > "$CONFIG_FILE" << 'JSON_EOF'
{
  "provider": {
    "ollama": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Ollama (Local)",
      "options": {
        "baseURL": "http://localhost:11434/v1"
      },
      "models": {
        "codex": {
          "name": "CodeX (Local Persona)"
        },
        "deepseek-coder:6.7b": {
          "name": "DeepSeek Coder 6.7B"
        },
        "qwen2.5-coder:1.5b": {
          "name": "Qwen 2.5 Coder 1.5B"
        }
      }
    }
  },
  "plugin": [
    "opencode-antigravity-auth@latest"
  ]
}
JSON_EOF

echo "✅ [3/4] Config written: $CONFIG_FILE"
echo ""
echo "🔐 [4/4] Next step: authenticate with Google"
echo ""
echo "Run:"
echo "  opencode auth login"
echo ""
echo "Then switch models in OpenCode with: /model"
echo ""
echo "⚠️  Note: Antigravity models are CLOUD (online)."
echo "    Local Ollama models stay OFFLINE."
echo ""
echo "🎉 Done! CodeX is now HYBRID (local + cloud)."
