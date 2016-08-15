# Reproducible example for Spark JIRA
library("SparkR")

n = 3
df = data.frame(key = 1:n)
df$value = lapply(letters[1:n], serialize, connection = NULL)

sc <- sparkR.init()
sqlContext <- sparkRSQL.init(sc)
spark_df = createDataFrame(sqlContext, df)

# Fails
dapplyCollect(spark_df, function(x) x)

df2 = data.frame(key = 1:3)
df2$value =lapply(df2$key, function(x) 1:x)
