import pyodbc
import os
import logging
import time
from faker import Faker
from dotenv import load_dotenv
from random import choice
from string import ascii_uppercase

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

# create a cursor from the connection
cursor = conn.cursor()

# initiate faker
fake = Faker()

# seeding script
for _ in range(1000):   # change the range for the number of records you want to generate
    name = fake.first_name()
    last_name = fake.last_name()
    birth_date = fake.date_of_birth(minimum_age=30, maximum_age=90)
    #generate a random string with 8 characters
    email_key = ''.join(choice(ascii_uppercase) for i in range(8))
    email = email_key + fake.email()
    sex = fake.random_element(["M", "F"])

    cursor.execute(f"INSERT INTO person (name, last_name, birth_date, email, sex) values (?, ?, ?, ?, ?)",name, last_name, birth_date, email, sex)

# committing the transaction and closing the connection
conn.commit()
conn.close()

end_time = time.time()
execution_time = end_time - start_time
logging.info(f"Execution time: {execution_time} seconds")
logging.info("1000 persons generated")
