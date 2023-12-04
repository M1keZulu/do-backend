import pytest
from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_calculate_valid_data():
    data = {"number1": 5, "number2": 3, "operation": "+"}
    response = client.post("/calculate", json=data)
    assert response.status_code == 200
    assert response.json() == {"result": 8}

def test_calculate_invalid_data():
    data = {"number1": 5, "number2": 3, "operation": "%"}
    response = client.post("/calculate", json=data)
    assert response.status_code == 200
    assert response.json() == {"result": "Invalid operation"}

def test_calculate_invalid_operation():
    data = {"number1": 5, "number2": None, "operation": "+"}
    response = client.post("/calculate", json=data)
    assert response.status_code == 200
    assert response.json() == {"result": "Error occurred"}

def test_calculate_divide_by_zero():
    data = {"number1": 5, "number2": 0, "operation": "/"}
    response = client.post("/calculate", json=data)
    assert response.status_code == 200
    assert response.json() == {"result": "Cannot divide by zero"}

def test_calculate_error():
    data = {"number1": "text", "number2": 3, "operation": "+"}
    response = client.post("/calculate", json=data)
    assert response.status_code == 200
    assert response.json() == {"result": "Error occurred"}
