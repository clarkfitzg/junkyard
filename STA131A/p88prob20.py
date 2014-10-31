import pandas as pd

df = pd.read_csv('probs.csv')

df['x2'] = df['x'] * df['x']

Ex = sum(df['x'] * df['fx'])
print(Ex)

Ex2 = sum(df['x2'] * df['fx'])

varx = Ex2 - Ex ** 2
print(varx)

sd = np.sqrt(varx)
print(sd)

def within(scale):
    keepers = (df.x > Ex - scale * sd) & (df.x < Ex + scale * sd)
    return sum(df.fx[keepers])
    
inside = list(map(within, (1, 1.5, 2)))
print(inside)
