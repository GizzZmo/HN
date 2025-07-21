import pytest
import sys
from flask import Flask
from integration.api_server import app
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from api_server import app

@pytest.fixture
def client():
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client

def test_empathy_query_response(client):
    response = client.post("/empathy-query", json={"message": "I feel anxious"})
    assert response.status_code == 200
    assert response.is_json
    result = response.get_json()
    assert "result" in result
    assert "anxious" in result["result"]
