import psycopg2
import os
from dotenv import load_dotenv
# from psycopg2.extras import execute_batch

def connect_to_db() -> None:
    load_dotenv()  # Load environment variables
    
    hostname = os.getenv('DB_HOST')
    database = os.getenv('DB_NAME')
    username = os.getenv('DB_USER')  # Fixed typo here
    pwd = os.getenv('DB_PASS')
    port_id = os.getenv('DB_PORT')
    
    try:
        conn = psycopg2.connect(
            host=hostname,
            dbname=database,
            user=username,
            password=pwd,
            port=port_id
        )
        print("Connection success")
        return conn
        
    except (Exception, psycopg2.Error) as error:
        print("Error occurred connecting to PostgreSQL", error)
        return None

