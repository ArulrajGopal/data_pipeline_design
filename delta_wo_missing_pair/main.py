import psycopg2
import os 
import utils

BASE_DIR = os.path.dirname(__file__)

sql_path = f"{BASE_DIR}/createStatement.sql"

utils.run_sql_script(sql_path)


























# import pandas as pd

# # storage_account = "arulrajgopalshare"
# # container = "kaniniwitharul"

# # # Public URL to the CSV file
# # url = f"https://{storage_account}.blob.core.windows.net/{container}/sample_data.csv"


# # # Read CSV directly
# # df = pd.read_csv(url)

# # print(df)
