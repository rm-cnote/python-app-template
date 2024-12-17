APP_NAME := my-python-app
VENV := .venv
PYTHON := $(VENV)/bin/python
UV := $(VENV)/bin/uv
PRE_COMMIT := $(VENV)/bin/pre-commit
PYTEST := $(VENV)/bin/pytest
RUFF := $(VENV)/bin/ruff
MYPY := $(VENV)/bin/mypy

.PHONY: install install install-dev install-emacs test lint format docker-build docker-run clean

$(VENV)/bin/uv:
	python -m venv $(VENV)
	$(PYTHON) -m pip install --quiet uv

install: $(VENV)/bin/uv
	$(UV) pip install --quiet --editable .
	$(UV) pip install --quiet pre-commit
	$(PRE_COMMIT) install

install-dev: install
	$(UV) pip install --quiet --editable ".[dev]"

install-emacs: install-dev
	$(UV) pip install --quiet --editable ".[emacs]"

test: $(VENV)/bin/pytest
	$(PYTEST) tests/ -v --cov=app --cov-report=term-missing --cov-report=html

format: $(VENV)/bin/ruff
	$(RUFF) check --select I --fix
	$(RUFF) format .

lint: $(VENV)/bin/ruff
	$(RUFF) check --output-format=pylint .
	$(RUFF) format --check --diff .
	$(MYPY) src

pre-commit: $(VENV)/bin/pre-commit
	$(PRE_COMMIT) run --all-files

pre-commit-upgrade: $(VENV)/bin/pre-commit
	$(PRE_COMMIT) autoupdate

docker-build:
	docker build --progress=plain -t $(APP_NAME) .

docker-run:
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
