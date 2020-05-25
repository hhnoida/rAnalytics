#Descriptive Statistics in R
#Mean: mean()
#Standard deviation: sd()
#Variance: var()
#Minimum: min()
#Maximum: maximum()
#Median: median()
#Range of values (minimum and maximum): range()
#Sample quantiles: quantile()
#Generic function: summary()
#Row and Column sum: rowSums() and colSums()
#Row and Column means: rowMeans() and colMeans()

# Compute the mean value
mean(mtcars$mpg)

# Compute the median value
median(mtcars$mpg)

# Compute the variance 
var(mtcars$mpg)
?var

# Compute the standard deviation
sd(mtcars$mpg)

# Compute the minimum value
min(mtcars$mpg)

# Compute the maximum value
max(mtcars$mpg)

# Range
range(mtcars$mpg)

# Generic Function
summary(mtcars$mpg)

#interquartile range 
quantile(mtcars$mpg, probs = seq(0, 1, 0.25))

#Column and Row sum, Column and Row means
df = data.frame(a=c(1,2,3,4,5,6,7), b= c(7,6,5,4,3,2,4))
df
# Column Sum
colSums(df)

# Row Sum
rowSums(df)

# Column Means
colMeans(df)

# Row Means
rowMeans(df)
