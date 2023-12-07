import pandas as pd

player = pd.read_csv('player.csv')

qb = player[player['Position'] == 'QB']
rb = player[player['Position'].isin(['RB', 'HB'])]
fb = player[player['Position'] == 'FB']
wr = player[player['Position'] == 'WR']
te = player[player['Position'] == 'TE']
ol = player[player['Position'].isin(['OL', 'OT', 'OG', 'C'])]
dl = player[player['Position'].isin(['DL', 'DT'])]
lb = player[player['Position'].isin(['LB', 'OLB', 'MLB', 'ROLB', 'LOLB'])]
db = player[player['Position'].isin(['DB', 'S'])]
p = player[player['Position'] == 'P']
pk = player[player['Position'].isin(['PK', 'K'])]

qb = qb.drop('Position', axis=1)
fb = fb.drop('Position', axis=1)
rb = rb.drop('Position', axis=1)
wr = wr.drop('Position', axis=1)
te = te.drop('Position', axis=1)
ol = ol.drop('Position', axis=1)
dl = dl.drop('Position', axis=1)
lb = lb.drop('Position', axis=1)
db = db.drop('Position', axis=1)
p = p.drop('Position', axis=1)
pk = pk.drop('Position', axis=1)

qb.to_csv('qb.csv', sep='\t', index=False)
rb.to_csv('rb.csv', sep='\t', index=False)
fb.to_csv('fb.csv', sep='\t', index=False)
wr.to_csv('wr.csv', sep='\t', index=False)
te.to_csv('te.csv', sep='\t', index=False)
ol.to_csv('ol.csv', sep='\t', index=False)
dl.to_csv('dl.csv', sep='\t', index=False)
lb.to_csv('lb.csv', sep='\t', index=False)
db.to_csv('db.csv', sep='\t', index=False)
p.to_csv('p.csv', sep='\t', index=False)
pk.to_csv('pk.csv', sep='\t', index=False)
