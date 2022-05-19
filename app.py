from fastapi import FastAPI, Response
import os


name = os.getenv("HELLO_NAME", "unknown")

api = FastAPI()

@api.get("/hello")
async def hello():
        return f"Hello {name}!!!"


@api.get("/healthz")
async def healthz():
        return "OK"
