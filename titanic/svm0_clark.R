# Load in the Titanic data set.

train <- read.csv("~/data/titanic/train.csv")
test <- read.csv("~/data/titanic/test.csv")

# Let's try a Support Vector Machine.

library(e1071)
library(plyr)

# We'll just use the data that we can easily use
# Here is the formula defined:

fm1 <- formula(Survived ~ Pclass + Sex + Age + Parch + Fare)

# Wrong type of dependent variable?
class(train$Survived) <- "logical"

# Average out the ages to remove NA values
CleanAge <- function(string){
  y <- get(string, envir = .GlobalEnv)
  m <- mean(y$Age, na.rm = TRUE)
  y$Age[is.na(y$Age)] <- m
  assign(string, y, envir = .GlobalEnv)
}

l_ply(c("test", "train"), CleanAge)

test$Fare[is.na(test$Fare)] <- mean(test$Fare, na.rm = TRUE)

tune.mod1 <- tune(svm, fm1, data = train
                  , ranges = list(gamma = 2^(-1:1), cost = 2^(2:4))
                  , tunecontrol = tune.control(sampling = "cross", cross = 5)
                  , type = "C")

output <- predict(tune.mod1$best.model, test)
output <- as.integer((as.logical(output)))
output <- cbind(test$PassengerId, output)
colnames(output) <- c("PassengerId", "Survived")

write.csv(output, "~/data/titanic/svm0.csv",row.names = FALSE, col.names = TRUE)

sum(daply(test, is.na))
