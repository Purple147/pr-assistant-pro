#!/usr/bin/env bash
set -euo pipefail
REPO=$(basename "$(pwd)")
OUT="../${REPO}-test-report.txt"
echo "Report for $REPO" > "$OUT"
date >> "$OUT"
python --version >> "$OUT" 2>&1

python -m venv .venv || true
source .venv/bin/activate
pip install --upgrade pip setuptools wheel >> "$OUT" 2>&1

if [ -f requirements.txt ]; then
  echo "Installing requirements..." >> "$OUT"
  pip install -r requirements.txt >> "$OUT" 2>&1 || true
else
  echo "No requirements.txt" >> "$OUT"
fi

pip install pip-audit safety bandit flake8 mypy pytest detect-secrets requests >> "$OUT" 2>&1 || true

echo "=== pip-audit ===" >> "$OUT"
pip-audit --progress-spinner off >> "$OUT" 2>&1 || true

echo "=== bandit ===" >> "$OUT"
bandit -r . -ll >> "$OUT" 2>&1 || true

echo "=== flake8 ===" >> "$OUT"
flake8 . >> "$OUT" 2>&1 || true

echo "=== mypy ===" >> "$OUT"
mypy . >> "$OUT" 2>&1 || true

echo "=== pytest ===" >> "$OUT"
if [ -d tests ] || ls test_*.py >/dev/null 2>&1; then
  pytest -q >> "$OUT" 2>&1 || true
else
  echo "No tests found" >> "$OUT"
fi

echo "=== smoke_imports.py output ===" >> "$OUT"
python smoke_imports.py >> "$OUT" 2>&1 || true

echo "Report saved: $OUT"
deactivate || true
