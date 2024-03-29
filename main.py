import pyodbc
import os
import logging
import time
from dotenv import load_dotenv
from prettytable import PrettyTable

start_time = time.time()
load_dotenv()
logging.basicConfig(
    format='%(asctime)s %(levelname)-8s %(message)s',
    level=logging.INFO,
    datefmt='%Y-%m-%d %H:%M:%S')

logging.info(f"connecting to {os.getenv("DB_HOST")}")
# establish a sql server connection using env variables
conn_string = (
    f'DRIVER={{ODBC Driver 17 for SQL Server}}; SERVER={os.getenv("DB_HOST")}; DATABASE={os.getenv("DB_DATABASE")};'
    f'UID={os.getenv("DB_USERNAME")}; PWD={os.getenv("DB_PASSWORD")};'
)
conn = pyodbc.connect(conn_string)

# Open the file queries/report_status.sql and get the contents as string
with open("queries/report_status.sql", "r") as file:
    sql_query = file.read()

cursor = conn.cursor()
cursor.execute(sql_query)
rows = cursor.fetchall()

# Create a PrettyTable instance
pt = PrettyTable()

# Fetch the column names
col_names = [column[0] for column in cursor.description]

# Set the table field names to the column names
pt.field_names = col_names

# Add each row from rows
for row in rows:
    pt.add_row(row)

# Print table as string
print(pt)

conn.close()

end_time = time.time()
execution_time = end_time - start_time
logging.info(f"Execution time: {execution_time} seconds")
