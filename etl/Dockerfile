FROM python:3.11-slim

WORKDIR /app

# Installer les dépendances
RUN pip install --no-cache-dir mysql-connector-python psycopg2-binary pandas

COPY load_mysql_to_postgres.py .

CMD ["python", "load_mysql_to_postgres.py"]