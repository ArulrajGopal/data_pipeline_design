import pandas as pd
from adlfs import AzureBlobFileSystem

# Azure storage details
storage_account_name = "arulrajgopalshare"
storage_account_key = "oGaeFL97VvqFLjVL4TC2BZf1o7bCYVIkdZBlHQbCjiF41+Kaiabk/8ET2x0IXOKfDwqrGHsqD5nF+AStnzWFKg=="
container_name = "kaniniwitharul"
csv_file_path = "sample_data.csv"

# Path in ABFS format
full_path = f"abfs://{container_name}/{csv_file_path}"

# Azure filesystem setup
fs = AzureBlobFileSystem(account_name=storage_account_name, account_key=storage_account_key)

# Read CSV file using pandas
df = pd.read_csv(full_path, storage_options={'account_name': storage_account_name, 'account_key': storage_account_key})

# Display first few rows
print(df.head())



