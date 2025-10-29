FROM python:3.10-slim
WORKDIR /app
COPY ../../django_app/requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt
COPY ../../django_app/ /app/
ENV PYTHONUNBUFFERED=1
CMD ["gunicorn", "proj.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3"]
