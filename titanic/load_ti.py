'''
Load and clean the Titanic dataset.
'''

__author__ = 'Clark Fitzgerald'

import pandas as pd
import sklearn
from sklearn.ensemble import RandomForestClassifier

path='/Users/clark/data/titanic/'

def GetData():
    '''
    Read in data from CSV
    '''
    train = pd.read_csv(path + 'train.csv')
    test = pd.read_csv(path + 'test.csv')
    test.index = test.PassengerId
    return train, test

def SimpleClean():
    '''
    A simple cleaning scheme for the Titanic data set
    '''
    train, test = GetData()

    # Convert Sex to factor
    train.Sex = pd.factorize(train.Sex)[0]
    test.Sex = pd.factorize(test.Sex)[0]

    # Deal with the one missing Fare in test set
    # Just put the mean in.
    test.Fare = test.Fare.fillna(test.Fare.mean()) 

    # Define features to train on
    features = ['Pclass', 'Sex', 'SibSp', 'Parch', 'Fare']

    return train[features], train.Survived, test[features]
