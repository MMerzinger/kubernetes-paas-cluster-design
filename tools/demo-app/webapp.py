import os
from flask import Flask
from prometheus_flask_exporter import PrometheusMetrics
app = Flask(__name__)
metrics = PrometheusMetrics(app)
metrics.info('app_info', 'Application info', version='0.2.0')

@app.route("/try-to-find-me/here-i-am")
def hidden():
    return "<h1>You found the hidden endpoint :)</h1>"

@app.route("/")
@metrics.counter('http_requests_webroot', 'Invocations of webroot')
def webroot():
    return "<h1>Hello from the demo app!</h1>"

if __name__ == "__main__":
    app.run()