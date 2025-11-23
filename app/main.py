ÿþ# app/main.py
from fastapi import FastAPI

app = FastAPI()

@app.get("/health")
def health():
    return {"status": "ok"}

# '¯1 '~ '5DÌ 1' /'1Ì/ H EÌ .H'GÌ/ import ©FÌ/:
# try:
#     from your_real_module import app as real_app
#     app = real_app
# except Exception:
#     pass
