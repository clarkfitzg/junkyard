# Testing. See if my change will save. -Clark

#train has missing values in Age

#test has missing values in Age and Fare

#The user will see which columns have missing values. Thus, they will specify by column 
#number which columns need adjusting

#For now, 4 options to fill in values. "median", "uniform", "c.distribution", "d.distribution"
#median will be analagous to our simple Age problem from Titanic
#uniform will calculate the total range of values in the column, and then assign uniformly at random this set of range values to the missing values
#c.distribution will be similar to uniform, except take it a step further and allow them to assign intervals within the set certain probabilities. Another way to think of it is allowing the user to define a quasi-continuous distribution

#for example, the user will define a sequence of bin values for age:
# c(0,15,41,66,max(Ages))
#and also define a prob distribution c(0.15, 0.45, 0.35, 0.5)
#this would imply P(0 <= age < 15) = 0.15
#P(15 <= age < 41) = 0.45
#etc. 
#The algorithm would work such that first assign a person to a bin by that distribution, and then uniformly at random assign them a value within that bin. 

#d.distribution is a simple discrete distribution. The user defines a set of values the Age can take on, and for each value there is an assigned probability


cleanNAValues <- function(data, column.id, type, extra) {
	
	#isolate column
	data.column <- data[,column.id]
	
	if (type == "median") {
		
		med <- median(data.column, na.rm = TRUE)
		data.column[is.na(data.column)] <- med
		
	} else if (type == "uniform") {
		
		num.NA <- sum(is.na(data.column))
		rnge <- range(data.column, na.rm = TRUE)
		runif.values <- round(runif(num.NA, min = rnge[1], max = rnge[2]))
		data.column[is.na(data.column)] <- runif.values
		
	} else if (type == "c.distribution") {
		
		num.NA <- sum(is.na(data.column))
		bin.values <- extra[[1]] #take away min bin value cut
		probs <- extra[[2]]
		dist.values <- sample(bin.values[-1], num.NA, replace = TRUE, prob = probs)
		
		for (i in 2:length(bin.values)) {
			
			if (any(dist.values == bin.values[i])) {
				
				dist.equals.bin <- which(dist.values == bin.values[i])
				l <- length(dist.equals.bin)
				dist.values[dist.equals.bin] <- round(runif(l, bin.values[i-1], bin.values[i] - 1))
			
			}
		}
		data.column[is.na(data.column)] <- dist.values
		
	} else if (type == "d.distribution") {
		
		num.NA <- sum(is.na(data.column))
		point.values <- extra[[1]]
		probs <- extra[[2]]
		dist.values <- sample(point.values, num.NA, replace = TRUE, prob = probs)
		data.column[is.na(data.column)] <- dist.values
	}
	
	return(data.column)
	
}



#Some example uses in line with reading in the file, then cleaning it

train <- read.csv("/Users/hunteralzate/Downloads/train.csv")

test <- read.csv("/Users/hunteralzate/Downloads/test.csv")

if (any(is.na(train$Age))) {
	
	train$Age <- cleanNAValues(train, 6, "c.distribution", extra = list(c(0,15,46,66,90), c(0.15, 0.45, 0.35, 0.5)))
}

if (any(is.na(test$Age))) {
	
	test$Age <- cleanNAValues(test, 6,"c.distribution", extra = list(c(0,15,46,66,90), c(0.15, 0.45, 0.35, 0.5)))
}

#and I wrote it with being able to change other things besides Age. For example, the test set is missing a single Fare value

#I'll assume that the person fell into the central 50 percentile, i.e. fall between Q1-Q2 with prob 50%, between Q2-Q3 with prob 50%
if (any(is.na(test$Fare))) {
	
	test$Fare <- cleanNAValues(test, 9, "c.distribution", extra = list(c(7,15,31), c(.50, .50)))
}
