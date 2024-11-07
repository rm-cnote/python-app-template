APP_NAME := my-python-app
VENV := .venv
PYTHON := $(VENV)/bin/python
UV := $(VENV)/bin/uv
PRE_COMMIT := $(VENV)/bin/pre-commit
PYTEST := $(VENV)/bin/pytest
RUFF := $(VENV)/bin/ruff

.PHONY: install install-quiet test lint format build build-plain run clean

$(VENV)/bin/uv:
	python -m venv $(VENV)
	$(PYTHON) -m pip install --quiet uv

install: $(VENV)/bin/uv
	$(UV) pip install --editable .
	$(UV) pip install pre-commit
	$(PRE_COMMIT) install

install-quiet: $(VENV)/bin/uv
	$(UV) pip install --quiet --editable .
	$(UV) pip install --quiet pre-commit
	$(PRE_COMMIT) install

test: $(VENV)/bin/pytest
	$(PYTEST) tests/ -v --cov=app --cov-report=term-missing --cov-report=html

format: $(VENV)/bin/ruff
	$(RUFF) format .

lint: $(VENV)/bin/ruff
	$(RUFF) check .
	$(RUFF) format --check .

build:
	docker build -t $(APP_NAME) .

build-plain:
	docker build --progress=plain -t $(APP_NAME) .

run:
	docker run $(APP_NAME)

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type f -name "*.pyd" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	find . -type d -name "*.egg" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	find . -type d -name ".ruff_cache" -exec rm -rf {} +
	find . -type d -name ".coverage" -exec rm -rf {} +
	find . -type d -name "htmlcov" -exec rm -rf {} +
	rm -rf $(VENV)
