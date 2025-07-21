import requests

def test_postgres_health():
    # This assumes CI has PostgreSQL running
    try:
        response = requests.get("http://localhost:5432")
    except Exception as e:
        assert "Connection refused" not in str(e)
