from dotenv import load_dotenv
import os

load_dotenv()

endereco = os.getenv("url")
usuario = os.getenv("user")
senha = os.getenv("pasw")