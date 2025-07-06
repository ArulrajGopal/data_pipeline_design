import pandas as pd

storage_account = "arulrajgopalshare"
container = "kaniniwitharul"

# Public URL to the CSV file
url = f"https://{storage_account}.blob.core.windows.net/{container}/sample_data.csv"


# Read CSV directly
df = pd.read_csv(url)

print(df.head())
