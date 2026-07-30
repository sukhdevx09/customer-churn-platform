import pandas as pd
import sqlite3
import os

DB_PATH = '../data/churn_analytics.db'
REVENUE_CSV = '../outputs/revenue_at_risk.csv'
TELCO_CSV = '../data/telco_churn_cleaned.csv'

for path in [REVENUE_CSV, TELCO_CSV]:
    if not os.path.exists(path):
        raise FileNotFoundError(f"Missing source file: {path}")

conn = sqlite3.connect(DB_PATH)

customers = pd.read_csv(REVENUE_CSV)
clean = pd.read_csv(TELCO_CSV)

customers.to_sql('customers', conn, index=False, if_exists='replace')
clean.to_sql('telco', conn, index=False, if_exists='replace')

tables = pd.read_sql("SELECT name FROM sqlite_master WHERE type='table';", conn)
print("Tables created:", tables['name'].tolist())

conn.close()
print(f"Database created at: {DB_PATH}")