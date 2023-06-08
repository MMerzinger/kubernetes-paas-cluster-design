FROM python:3-alpine
RUN pip install flask prometheus-flask-exporter
COPY webapp.py /webapp.py
ENV FLASK_APP=/webapp.py
ENTRYPOINT flask run --host=0.0.0.0 --port=8080