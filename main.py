import pyodbc
import os
from faker import Faker

# establish a sql server connection using env variables
conn_string = (
    f'DRIVER={{SQL Server}}; SERVER={os.environ["DB_HOST"]}; DATABASE={os.environ["DB_NAME"]};'
    f'UID={os.environ["USER_NAME"]}; PWD={os.environ["PASSWORD"]};'
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
    email = fake.email()
    sex = fake.random_element(["M", "F"])

    cursor.execute(f"INSERT INTO person (name, last_name, birth_date, email, sex) values (?, ?, ?, ?, ?)",name, last_name, birth_date, email, sex)

# committing the transaction and closing the connection
conn.commit()
conn.close()