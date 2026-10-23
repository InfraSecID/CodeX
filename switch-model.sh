#!/bin/bash
# ============================================================
#  switch-model.sh — Switch CodeX active model
#  Usage: ./switch-model.sh <model-name>
#  Example: ./switch-model.sh qwen-1.5b
# ============================================================

set -e

MODELS_DIR="$HOME/codex/models"

if [ -z "$1" ]; then
    echo "Usage: $0 <model-name>"
    echo ""
    echo "Available models:"
    for f in "$MODELS_DIR"/*.Modelfile; do
        [ -e "$f" ] || continue
        basename "$f" .Modelfile
    done
    exit 1
fi

MODEL="$1"
MODEL_FILE="$MODELS_DIR/$MODEL.Modelfile"

if [ ! -f "$MODEL_FILE" ]; then
    echo "❌ Model not found: $MODEL"
    echo "Available models:"
    for f in "$MODELS_DIR"/*.Modelfile; do
        [ -e "$f" ] || continue
        basename "$f" .Modelfile
    done
    exit 1
fi

echo "🔨 Building model: $MODEL..."
ollama create "codex-$MODEL" -f "$MODEL_FILE"

echo "✅ Model built: codex-$MODEL"
echo ""
echo "To use it, update your OpenCode config:"
echo "  Model: codex-$MODEL"
echo ""
echo "Or run directly:"
echo "  ollama run codex-$MODEL"
