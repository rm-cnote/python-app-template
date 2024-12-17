from typing import Annotated

import typer
from rich import print

app = typer.Typer()


def greet(name: str, greeting: str = "Hello") -> str:
    """Generate a greeting message."""
    return f"{greeting}, {name}!"


@app.command()
def main(
    name: Annotated[str, typer.Option(help="Name to greet")] = "World",
    greeting: Annotated[str, typer.Option(help="Greeting to use")] = "Hello",
) -> None:
    """
    Simple greeting application that can be run directly or in a container.
    """
    message = greet(name, greeting)
    print(f"[green]{message}[/green]")


if __name__ == "__main__":
    app()
