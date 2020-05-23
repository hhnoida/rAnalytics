#decision Tree
#library(rpart.plot)
#library(rpart)
pacman::p_load(rpart, rpart.plot, dplyr)

#classification tree
#created for categorial variable and results in qualitative response
str(mtcars)

head(mtcars)
df = mtcars
df$am = factor(df$am)
str(df)

dt1 <- rpart(am ~ mpg, data = df, method='class')
dt1
?rpart.plot
rpart.plot(dt1)
rpart.plot(dt1, type=1, nn=T)
rpart.plot(dt1, type=2, extra=104, nn=T)

df %>% select(mpg,am) %>% arrange(mpg)

#extra- Display extra information at the nodes: 106-class Mdl with binary response,104- class Mdl with more than 2 levels, 100- other models
#?rpart.plot

#
#if the mpg < 19, then 53% chance that car is auto

#and 12% of cars of auto
df %>% group_by(am)  %>% summarise(n=n())
19/32
df %>% select(mpg, am) %>% arrange(mpg)
#node=1; split=root, n=32, 13=loss, yval=0, yprob=(.59, .4)
#node=2; (mpg< 19) : split= , n=17, 2=loss, yval=0, yprob=(.88, .117)
#node=1; split=root, n=32, 13=loss, yval=0, yprob=(.59, .4)

rpart.rules(dt1, nn=T)
rpart.rules(dt1, cover=T, nn=T)

(sample1 <- dplyr::sample_n(df,3))
rpart.predict(dt1, newdata=sample1, rules=TRUE)
rpart.predict(dt1, newdata=sample1)

#titanics-----
data(ptitanic)
head(ptitanic)

#predict survive or NOT
str(ptitanic)
names(ptitanic)
dim(ptitanic)
dt2 <- rpart(survived ~ . , data = ptitanic)
dt2
rpart.plot(dt2)
rpart.plot(dt2, cex=0.8)

#lets partition data into 2 parts---
library(caret)
trgIndex = createDataPartition(ptitanic$survived, p = .8, list = FALSE, times = 1)
?createDataPartition
trgSet = ptitanic[trgIndex, ]
testSet = ptitanic[-trgIndex, ]
dim(trgSet); dim(testSet) #total matching
dt3 = rpart(survived ~ ., data=trgSet)
dt3
rpart.plot(dt3)
rpart.plot(dt3, type=1, extra=104, nn=T, cex=.9)
rpart.plot(dt3, type=2, extra=104, nn=T, cex=.9)

#prune tree basis of complexity parameter
#cp values reduces errors in prediction
printcp(dt3)

#select cp such that cross validation error(xerror) is least : cp=.01 for xerror=.515
#it may vary in some cases due randomness
dt3b <- prune(dt3, cp=.01)
dt3b
rpart.plot(dt3b, type=2, extra=104, nn=T, cex=.9)

##however we will select another value to show effect of cp
#taking cp randomly
dt3c <- prune(dt3, cp=.018)
dt3c
rpart.plot(dt3c, type=2, extra=104, nn=T, cex=.8)
#simple, less splits

#use this model to predict survival for testSet
head(testSet)
pred1 = predict(dt3b, newdata=testSet, type='class') #qualitative response
head(pred1)
pred2 = predict(dt3b, newdata=testSet, type='prob') #response is in probability of death and survival
head(pred2)

#confusion matrix to find accuracy---
caret:: confusionMatrix(testSet$survived, pred1)
#78% accuracy

#there are other classification techniques to improve accuracy, but rpart is the simplest to understand and learn

#regression
#it is created for continuous variable and response is quantitative 

head(ptitanic)
#predict age based on other variables 
#you can do this by splitting the data intp 2 parts and then predicting
#however, here will do without partition here

dt4 = rpart(age ~ ., data=ptitanic, method ="anova") #annova is used for regression tree
dt4
dim(ptitanic)
rpart.plot(dt4, nn=T, cex=.8)
rpart.rules(dt4, cover=T, nn=T)

#using dplyr package


sample2 = sample_frac(ptitanic, size=.1)
head(sample2)
dim(sample2)
predAge <- predict(dt4, newdata = sample2, type='vector')
head(predAge)
predict(dt4, newdata = sample2)

sample2 = cbind(sample2, predAge)
head(sample2)

caret::RMSE(sample2$age, predAge, na.rm=T)
#lesser the better

#Decision tree helps in classification 
#classification = class by default 
#numerical values= vector
#regression = annova
