#!/bin/bash
# ============================================================
#  benchmark.sh — Benchmark CodeX models
#  Usage: ./benchmark.sh
# ============================================================

set -e

PROMPT="bikin fungsi python buat reverse string"
MODELS=("codex" "codex-qwen-1.5b" "codex-codellama-7b")

echo "=== CodeX Model Benchmark ==="
echo "Prompt: $PROMPT"
echo ""

for MODEL in "${MODELS[@]}"; do
    if ! ollama list | grep -q "^$MODEL"; then
        echo "⚠️  Model not found: $MODEL (skipping)"
        continue
    fi

    echo "--- $MODEL ---"
    START=$(date +%s%N)
    echo "$PROMPT" | ollama run "$MODEL" > /dev/null 2>&1 || true
    END=$(date +%s%N)
    DURATION=$(( (END - START) / 1000000 ))
    echo "Time: ${DURATION}ms"
    echo ""
done

echo "=== Done ==="
