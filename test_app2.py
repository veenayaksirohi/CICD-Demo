import requests
import pytest

endpoint = 'http://127.0.0.1:5000/'

def test_app():
    response = requests.get(endpoint)
    assert response.status_code == 200
    assert 'Hello, World!' in response.text
