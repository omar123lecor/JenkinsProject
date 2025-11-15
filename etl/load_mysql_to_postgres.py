import os
import pandas as pd
import mysql.connector
import psycopg2

# Connexion MySQL
mysql_config = {
    'host': os.getenv('MYSQL_HOST', 'mysql'),
    'user': os.getenv('MYSQL_USER', 'appuser'),
    'password': os.getenv('MYSQL_PASSWORD', 'apppass'),
    'database': os.getenv('MYSQL_DB', 'sales_db'),
    'port': int(os.getenv('MYSQL_PORT', 3306))
}

# Connexion PostgreSQL
pg_config = {
    'host': os.getenv('POSTGRES_HOST', 'postgres'),
    'user': os.getenv('POSTGRES_USER', 'pguser'),
    'password': os.getenv('POSTGRES_PASSWORD', 'pgpass'),
    'dbname': os.getenv('POSTGRES_DB', 'sales_warehouse'),
    'port': int(os.getenv('POSTGRES_PORT', 5432))
}

# Charger les données depuis MySQL
print("📥 Connexion à MySQL...")
mysql_conn = mysql.connector.connect(**mysql_config)
df = pd.read_sql("SELECT * FROM sales;", mysql_conn)
mysql_conn.close()
print(f"✅ {len(df)} lignes extraites de MySQL.")

# Créer la table dans PostgreSQL si elle n'existe pas
print("📤 Connexion à PostgreSQL...")
pg_conn = psycopg2.connect(**pg_config)
pg_cursor = pg_conn.cursor()

create_table_query = """
CREATE TABLE IF NOT EXISTS sales (
    Row_ID INT PRIMARY KEY,
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Postal_Code VARCHAR(20),
    Region VARCHAR(50),
    Product_ID VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(255),
    Sales NUMERIC(10,2),
    Quantity INT,
    Discount NUMERIC(5,2),
    Profit NUMERIC(10,4)
);
"""
pg_cursor.execute(create_table_query)
pg_conn.commit()

# Insérer les données
# Insérer les données
print("⬆️ Insertion des données dans PostgreSQL...")
insert_query = """
INSERT INTO sales (
    Row_ID, Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID, Customer_Name,
    Segment, Country, City, State, Postal_Code, Region, Product_ID,
    Category, Sub_Category, Product_Name, Sales, Quantity, Discount, Profit
)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
ON CONFLICT (Row_ID) DO NOTHING;
"""

for row in df.itertuples(index=False, name=None):
    pg_cursor.execute(insert_query, row)

pg_conn.commit()
pg_cursor.close()
pg_conn.close()
print("🎉 Données transférées avec succès vers PostgreSQL !")
