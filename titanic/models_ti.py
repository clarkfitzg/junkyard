'''
Train and summarize models
'''

__author__ = 'Clark Fitzgerald'

import numpy as np
import pandas as pd
import sklearn
import sklearn.linear_model
import sklearn.naive_bayes
from sklearn.ensemble import RandomForestClassifier
from load_ti import SimpleClean

path='/Users/clark/data/titanic/'

X, y, test = SimpleClean()

# Add interaction term for wealthy families
#X['Pclass*Parch'] = X.Pclass * X.Parch

# Define a dictionary of models
classifiers = {
    'Random Forest' : RandomForestClassifier(n_estimators=50),
    'Logistic Regression' : sklearn.linear_model.LogisticRegression(),
    'Support Vector Machine' : sklearn.svm.SVC(),
    'Naive Bayes' : sklearn.naive_bayes.GaussianNB()
    }

print '''For the Titanic data set, untuned models achieved the following 
mean accuracy rates in 5 fold cross validation:
'''
for i in classifiers:
    scores = sklearn.cross_validation.cross_val_score(classifiers[i], X, y, cv=5)
    print i, ':  ', np.mean(scores)
