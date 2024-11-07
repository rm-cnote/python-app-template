from app.main import greet


def test_greet_with_default_greeting():
    """Test greet function with just a name."""
    result = greet("Alice")
    assert result == "Hello, Alice!"


def test_greet_with_custom_greeting():
    """Test greet function with custom greeting and name."""
    result = greet("Bob", greeting="Hi")
    assert result == "Hi, Bob!"


def test_greet_with_special_characters():
    """Test greet function handles special characters."""
    result = greet("María José")
    assert result == "Hello, María José!"
