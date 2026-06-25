#!/usr/bin/env bash

set -e

echo "📦 Setting up Python project..."

for dir in src tests docs tmp; do
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
    echo "  📁 Created $dir/"
  fi
done

if [ ! -d ".venv" ]; then
  echo "  🔧  Creating virtual environment..."
  python -m venv .venv
else
  echo "  📦 Virtual environment present, skipping..."
fi

source .venv/bin/activate
echo "  🐍 Virtual environment activated"

if [ ! -f ".gitignore" ]; then
  cp "${BASE_DIR}/templates/gitignore" .gitignore
  echo "  📄 Created sample .gitignore"
fi

if [ ! -f "pyproject.toml" ]; then
  cp "${BASE_DIR}/templates/pyproject.toml" pyproject.toml
  echo "  📄 Created sample pyproject.toml"
fi

if [ ! -f "requirements.txt" ] && [ ! -f "requirements-dev.txt" ]; then
  touch requirements{,-dev}.txt
  echo "  📄 Created dummy requirements.txt"
fi

if [ ! -f "Makefile" ]; then
  cp "${BASE_DIR}/templates/Makefile" Makefile
  echo "  📄 Created sample Makefile"
fi

if [ ! -d ".git" ]; then
  git init &>/dev/null
  git branch -m main &>/dev/null
  git add -A &>/dev/null
  git commit -m "Initial commit" &>/dev/null
  echo "  🌿 Initialized Git repository"
fi

echo "✅ Project setup complete!"
