import os
from flask import Flask
app = Flask(__name__)

@app.route("/try-to-find-me/here-i-am")
def hidden():
    return "<h1>You found the hidden endpoint :)</h1>"

@app.route("/")
def webroot():
    return "<h1>Hello from the demo app!</h1>"

if __name__ == "__main__":
    app.run()