import json

data = {}

data['describe'] = ['mean', 'variance', 'exc_kurtosis']
data['linregress'] = ['coefficients', 'intercept']

with open('stats_stuff.json', 'w') as f:
    json.dump(data, f)
