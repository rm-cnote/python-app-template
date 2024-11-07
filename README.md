# Python Application

This is a Python application template configured for containerized deployment.

## Setup

1. Install dependencies (this will create a virtualenv in .venv):
   ```bash
   make install        # verbose output
   make install-quiet  # minimal output
   ```

2. Pre-commit hooks are installed automatically during `make install`

## Development

- Activate the virtualenv when developing locally:
  ```bash
  source .venv/bin/activate
  ```

- Run tests: `make test`
  - Generates coverage report in terminal
  - Creates HTML coverage report in htmlcov/
- Run linting: `make lint`
- Format code: `make format`
- Build container: `make build`
- Build container with plain output: `make build-plain`
- Run container: `make run`
- Clean project and virtualenv: `make clean`

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

To change the application name, modify the `APP_NAME` variable in the Makefile.
