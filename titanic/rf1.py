'''
A complete, working random forest model
'''

__author__ = 'Clark Fitzgerald'

import pandas as pd
import sklearn
from sklearn.ensemble import RandomForestClassifier

# Read in data
path = '/Users/clark/data/titanic/'
train = pd.read_csv(path + 'train.csv')
test = pd.read_csv(path + 'test.csv')

# At this point I just want to get a model working.

# Convert Sex to factor
train.Sex = pd.factorize(train.Sex)[0]
test.Sex = pd.factorize(test.Sex)[0]

# Deal with the one missing Fare in test set
# Just put the mean in.
test.Fare = test.Fare.fillna(test.Fare.mean()) 

# Define features to train on
features = ['Pclass', 'Sex', 'SibSp', 'Parch', 'Fare']

# Define and fit model
rf = RandomForestClassifier(n_estimators=50, oob_score=True)
rf.fit(train[features], train.Survived)

print 'Out of bag score on training set: %s' % rf.oob_score_ 

# Check cross validation
cv = sklearn.cross_validation.cross_val_score(
        rf, train[features], train.Survived, cv = 5)

print 'Average 5 fold cross validation score: %s' % cv.mean()
print 'raw cv scores: %s' % cv

# Generate predictions
predictions = rf.predict(test[features])

# Format result
result = pd.DataFrame({'Survived': predictions}, index=test.PassengerId)
result.to_csv(path + 'rf1.csv') 
