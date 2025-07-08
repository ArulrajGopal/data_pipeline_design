import psycopg2
import os 



def run_sql_script(sql_path):

    # Connect to the database
    conn = psycopg2.connect(
        host="localhost",
        database="postgres",
        user="postgres",
        password="Arulraj@1234"
    )

    try:
        with conn:
            with conn.cursor() as cur:
                # Read the SQL file content
                with open(sql_path, "r") as sql_file:
                    sql_script = sql_file.read()

                # Execute the SQL file content
                cur.execute(sql_script)
                print("SQL file executed successfully.")

    finally:
        conn.close()