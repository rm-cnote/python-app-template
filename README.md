# Python Application

This is a Python application template configured for containerized deployment.

## Setup

Install dependencies (this will create a virtualenv in .venv):
```bash
make install          # base install
make install-dev      # adds developer tools with pre-commit (depends on install)
make install-emacs    # adds emacs tools (depends on install-dev)
```

## Development

- Activate the virtualenv when developing locally:
  ```bash
  source .venv/bin/activate
  ```

- Run tests: `make test`
  - Generates coverage report in terminal
  - Creates HTML coverage report in htmlcov/
- Run linting: `make lint`
  - Runs ruff checks with Emacs-friendly output
  - Checks code formatting with ruff
  - Runs mypy type checking
- Format code: `make format`
- Run pre-commit checks: `make pre-commit`
  - Runs all pre-commit hooks on all files
  - Includes whitespace, YAML, and large file checks
  - Runs ruff for linting and formatting
  - Runs mypy for type checking
- Update pre-commit hooks: `make pre-commit-upgrade`
- Build container: `make docker-build`
- Run container: `make docker-run`
- Clean project and virtualenv: `make clean`

## Development Tools

- Base install:
  - Core application dependencies

- Development tools (install-dev):
  - Pre-commit hooks for automated code quality checks
  - Ruff for linting and formatting
  - MyPy for static type checking
  - pytest for testing
  - debugpy for debugging support (compatible with VS Code and other editors)

- Emacs tools (install-emacs):
  - python-lsp-server for LSP support
  - LSP integrations for ruff and MyPy
  - Live type checking with MyPy
  - Automatic code formatting with ruff

## Usage

The application provides a simple greeting command:

```bash
# Run directly (make sure virtualenv is activated)
python -m app.main --name Alice
python -m app.main --name "Alice Smith" --greeting "Hi"

# Run in container (no virtualenv needed)
docker run my-python-app --name Alice
docker run my-python-app --name "Alice Smith" --greeting "Hi"
```

## Customization

To change the application name, modify:
- The `name` field under `[project]` in pyproject.toml
- The `APP_NAME` variable in Makefile
