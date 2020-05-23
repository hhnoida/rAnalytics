#Simple Linear Model

#Seleting the data set and building a model accordingly
#We are using women dataset for our analysis
#Mathematical equation for women data set weight = a + b*(height)
weight = -87.52 + 3.45(height)
#viewing the data set and its structure and dimension

?women
women
str(women)
dim(women)

#Check linearity of the data set first by plotting it
plot(women$height,women$weight)

#building a model for women data set
lmmodel = lm(weight ~ height, data = women)
lmmodel

#checking summary of the model
summary(lmmodel)

#Plotting a regression line on graph to shown the realtionship
abline(lm(weight ~ height, data= women), col='red', lwd = 1)

#Predicting the value of y (weight) with a new data of x (height)
head(women)
range(women$weight)
range(women$height)
newdata= data.frame(height=c(50, 75, 80, 85))
newdata
pred_weight = predict(lmmodel, newdata)
pred_weight

#Checking Assumptions of the model by daignostic plotting
plot(lmmodel)

