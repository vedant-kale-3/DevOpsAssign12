# Simple HTTP tests that assume the app is reachable at http://<host> (local or deployed)
import requests

BASE = "http://localhost"  # change to deployed manager node IP or load balancer

def test_register():
    r = requests.post(BASE + "/register/", data={'username':'ITA700','password':'2022PE0000'})
    assert r.status_code in (200,201)

def test_login():
    s = requests.Session()
    r = s.post(BASE + "/login/", data={'username':'ITA700','password':'2022PE0000'})
    # after login, access home
    r2 = s.get(BASE + "/home/")
    assert "Hello ITA700" in r2.text
