#Logistic Regression----
#Data is regarding selection of studentinto graduate school
#Note that R requires forward slashes (/) not back slashes () when specifying a file location even if the file is on your hard drive.
mydata <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
head(mydata) #view the first six rows of the data
str(mydata)
summary(mydata)2
sapply(mydata,sd)
#rank is a categirial values, but is saved in integer datatype; lets convert it to factors
mydata$rank = as.factor(mydata$rank)
mydata$admit = as.factor(mydata$admit)
str(mydata)
dim(mydata)

# wo-way contingency table of categorical outcome and predictors we want
# to make sure there are not 0 cells
#which rank of institute are more successful (in nos/ %) in getting admitted - 2 /1
xtabs(~admit + rank, data = mydata)

#Model 1----
mylogit = glm(admit ~ gre + gpa + rank, data = mydata, family = "binomial")
summary(mylogit)
#gre,gpa, rank are statistically significant, Star in each variable rows
#For every one unit change in gre, the log odds of admission (versus non-admission) increases by 0.002.
#For a one unit increase in gpa, the log odds of being admitted to graduate school increases by 0.804. (keeping others constants)
#The indicator variables for rank have a slightly different interpretation. For example, having attended an undergraduate institution with rank of 2, versus an institution with a rank of 1, changes the log odds of admission by -0.675.
#AIC for the model is 470.52.

#dividing the dataset into training and test for analysis
n = nrow(mydata)
sample = sample(1:n, size = round(0.7*n), replace=FALSE)
train = mydata[sample,] 
test = mydata[-sample,]

#Model 2----
#Building the logistic regression model
?glm
logR1 = glm(admit ~ gre+gpa+rank, train, family = binomial)
logR1
summary(logR1)
#Understanding the outcome of the model 
# to check whether the model is significant or not, elements to check are: pvalues of variables ; AIC value: lower the better;
# now gpa, rank are statistically significant, Star in each variable rows; gre becomes insignificant after splitting the data
#For a one unit increase in gpa, the log odds of being admitted to graduate school increases by 0.849. (keeping others constants)
#The indicator variables for rank have a slightly different interpretation. For example, having attended an undergraduate institution with rank of 2, versus an institution with a rank of 1, changes the log odds of admission by -596; it is not that effective factor for model

#predict on test set 
predicted = (predict(logR1, newdata = test, type='response'))
predictV = factor(ifelse(predicted <0.5,0, 1))
test = cbind(test, predictV)
head(test)
str(test)
#Checing accuracy of the model
library(caret)
confusionMatrix(test$admit, test$predictV)  #better

#Model 3----

n = nrow(mydata)
sample = sample(1:n, size = round(0.7*n), replace=FALSE)
train = mydata[sample,] 
test2 = mydata[-sample,]


logR2 = glm(admit ~ gpa+rank, train, family = binomial) #gre removed
logR2
summary(logR2) 

pred = (predict(logR2, newdata = test2, type='response'))
predict = factor(ifelse(pred <0.5,0, 1))
test2 = cbind(test2, predict)
head(test2)

#checking accuracy using caret package: confusion matric
caret::confusionMatrix(test2$admit, test2$predict)  #better

#confusion matrix using table command
table(test2$admit, pred > 0.5)

#checking accuracy of model using mean command
mean(test2$predict == test2$admit) 

#New data prediction
range(mydata$gpa)
df2 = data.frame(gpa= 3.7 , rank= factor(2))
df2
p = predict(logR2, newdata = df2)
p
p1 = factor(ifelse(p <0.5,0, 1))
p1
test2 = cbind(df2, p1)
head(test2)
