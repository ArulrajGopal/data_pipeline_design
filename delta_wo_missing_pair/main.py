import psycopg2
import os 
import utils
import pandas as pd

BASE_DIR = os.path.dirname(__file__)

sql_path = f"{BASE_DIR}/createStatement.sql"

utils.run_sql_script(sql_path)

batch_no = 1
storage_account = "arulrajgopalshare"
container = "kaniniwitharul"


orders_url = f"https://{storage_account}.blob.core.windows.net/{container}/delta_wo_missing_pair/{batch_no}/orders.csv"
order_items_url = f"https://{storage_account}.blob.core.windows.net/{container}/delta_wo_missing_pair/{batch_no}/order_items.csv"


# Read CSV directly
orders_df = pd.read_csv(orders_url)
order_itmes_df = pd.read_csv(order_items_url)


