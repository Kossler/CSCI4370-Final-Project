# import pandas as pd

# # List of file names
# file_names = ['player_game_statistics.csv']

# # Iterate over each file, remove duplicate Player Codes, convert Uniform Number to integer, and overwrite the file
# for file_name in file_names:
#     # Read the file
#     df = pd.read_csv(file_name, sep='\t')

#     # Convert Uniform Number to integers
#     # Replace 'Uniform Number' with the exact column name in your CSV files
#     df['Player Code'] = pd.to_numeric(df['Player Code'], errors='coerce').fillna(0).astype(int)

#     # Overwrite the original file
#     df.to_csv(file_name, sep='\t', index=False)

import pandas as pd

# Load the players CSV
players_df = pd.read_csv('players.csv', sep='\t')

# Load the player_game_statistics CSV
player_game_stats_df = pd.read_csv('player_game_statistics.csv', sep='\t')

# Filter player_game_stats_df to only include rows where player_id exists in players_df
filtered_player_game_stats_df = player_game_stats_df[player_game_stats_df['Player Code'].isin(players_df['Player Code'])]

# Save the filtered DataFrame back to CSV
filtered_player_game_stats_df.to_csv('player_game_statistics.csv', sep='\t', index=False)














