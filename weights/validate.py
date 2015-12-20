import json
import jsonschema
import pandas as pd


with open('schema.json') as f:
    schema = json.load(f)
