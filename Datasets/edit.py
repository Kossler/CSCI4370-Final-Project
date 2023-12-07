import pandas as pd

# Read the CSV file
df = pd.read_csv('players.csv', sep='\t')

# Convert the 'Player Code' column to int
# Assuming 'Player Code' is the name of the column; adjust if it's different
df['Team Code'] = pd.to_numeric(df['Team Code'], errors='coerce').fillna(0).astype(int)

# Save the modified DataFrame back to the CSV file
df.to_csv('players.csv', sep='\t', index=False)
