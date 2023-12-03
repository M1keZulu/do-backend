# app.py (Flask API)

from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, this is a simple Flask API! Updated'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
