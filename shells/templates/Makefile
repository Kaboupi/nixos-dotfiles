LAUNCH_SCRIPT := src/main.py

VENV := .venv
PYTHON_VENV := $(VENV)/bin/python3

.PHONY: help
help:
	@echo "🐍 Python Project Makefile"
	@echo ""
	@echo "Usage: make <target>"
	@echo ""
	@echo "Available targets:"
	@echo ""
	@echo "  make run          - Run the ${LAUNCH_SCRIPT}"
	@echo "                    - * editable in Makefile"
	@echo "  make test         - Run tests"
	@echo "  make test-cov     - Run tests with coverate"
	@echo "  make lint         - Run linters"
	@echo "  make lint-fix     - Run linters and fix with ruff"
	@echo "  make format       - Format code"
	@echo "  make clean        - Clean temporary files"
	@echo "  make clean-logs   - Clean logs only (*.log)"
	@echo "  make tree         - Display the project structure"
	@echo ""

.PHONY: all
all: lint format test

.PHONY: run
run: $(VENV)
	@echo "🚀 Running src/main.py..."
	$(PYTHON_VENV) src/main.py

.PHONY: test
test: $(VENV)
	@echo "🧪 Running tests..."
	pytest -v

.PHONY: test-cov
coverage: $(VENV)
	@echo "📊 Generating coverage report..."
	pytest -v --cov=src --cov-report=html --cov-report=term
	@echo "✅ Coverage report generated in htmlcov/index.html"

.PHONY: lint
lint: $(VENV)
	@echo "🔍 Linting code..."
	ruff check src/ tests/
	@echo "✅ Linting complete"

.PHONY: lint-fix
lint-fix: $(VENV)
	@echo "🔧 Fixing lint issues..."
	ruff check --fix src/ tests/
	@echo "✅ Fixes applied"

.PHONY: format
format: $(VENV)
	@echo "🎨 Formatting code..."
	ruff format src/ tests/
	@echo "✅ Formatting complete"

.PHONY: clean
clean:
	@echo "🧹 Cleaning project..."
	- find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	- find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	- find . -type d -name ".mypy_cache" -exec rm -rf {} + 2>/dev/null || true
	- find . -type d -name ".ruff_cache" -exec rm -rf {} + 2>/dev/null || true
	- find . -type f -name "*.pyc" -delete 2>/dev/null || true
	- find . -type f -name "*.pyo" -delete 2>/dev/null || true
	- find . -type f -name "*.log" -delete 2>/dev/null || true
	- find . -type f -name ".coverage" -delete 2>/dev/null || true
	- rm -rf htmlcov/ 2>/dev/null || true
	- rm -rf dist/ 2>/dev/null || true
	- rm -rf build/ 2>/dev/null || true
	- rm -rf *.egg-info/ 2>/dev/null || true
	@echo "✅ Clean complete"

.PHONY: clean-logs
clean-logs:
	@echo "🧹 Removing log files..."
	- find . -type f -name "*.log" -delete 2>/dev/null || true
	@echo "✅ Logs removed"

.PHONY: tree
tree:
	@echo "📂 Project structure:"
	@tree -L 3 -I '$(VENV)|__pycache__|*.pyc|.git'

.DEFAULT_GOAL := help
