?mtcars
names(mtcars)
View(mtcars)
plot(mpg~hp, data=mtcars)
plot(mpg~wt, data=mtcars)
result<-lm(mpg ~ hp+wt, data=mtcars)
summary(result)

#Value of Adjusted R2 = 0.82, 
#means that "82% of the variance in the measure of mpg can be predicted by hp and wt."

#Checking Multicollinearity:
result<-lm(mpg~hp+wt+disp+cyl+gear, data=mtcars)
summary(result)

#----Example-3
#Create Training and Test data ----
trainingRowIndex <- sample(1:nrow(mtcars), 0.8*nrow(mtcars))  # row indices for training data
trainingData <- mtcars[trainingRowIndex, ]  # model training data
testData  <- mtcars[-trainingRowIndex, ]   # test data

#Build the model on training data----
lmMod <- lm(mpg ~ #cyl 
            #+disp 
            +hp 
            +wt, data=trainingData)  # build the model
# Review diagnostic measures
summary (lmMod)  # model summary

#Accuracy:
#Since R2 is close to 1, i.e., 0.84, hence model is significant.

#Prediction----
#Predicitng values for test dataset
testData$mpgPred <- predict(lmMod, testData)
testData
#Accuracy:----
#Determining Prediction accuracy on test dataset using MAPE

#MAPE(MeanAbsolutePercentageError): 
#Lower its value better is the accuracy of the model.
#MAPE Calculation:
mape <- mean(abs((testData$mpgPred - testData$mpg))/testData$mpg)
mape

#checking assumptions through daignostic plots
plot(lmMod)
lmMod


