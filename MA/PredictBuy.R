#logistic regression

pacman::p_load(googlesheets4, dplyr, caTools)
ssID = '1n60luLar3ntCrY7-tQk7EhHag3ZwXKH0fTUukLICuOA'

#sheet - boughtData
sheetID = 'boughtData'
head(read_sheet(ss=ssID, sheet = sheetID))
?read_sheet
data = read_sheet(ss=ssID, sheet = sheetID, col_types = 'ciic')
head(data)
data[,c('bought', 'campaign_response')] <- lapply(data[,c('bought', 'campaign_response')], factor)
str(data)

#properties
dim(data)
summary(data)
nrow(data)
plot(data$age, data$bought)


#dividing dataset into train and test
?sample.split()
names(data)
split = caTools::sample.split(Y=data$bought, SplitRatio = 0.8)
split
train = subset(data, split == T)
test = subset(data, split == F)
dim(train) ; dim(test)
head(train)
head(test)


#develop model
names(data)
str(data)
modelA = glm(bought ~ campaign_response + income + age, data=train, family = binomial)
summary(modelA)
#only age seems to be significant
modelB = glm(bought ~ age, data=train, family = binomial)
summary(modelB)
AIC(modelA, modelB)  #modelA has lower AIC, however modelB is very close with lesser variables
#still we check with Model A

predA1 = (predict(modelA, newdata = test, type='response'))
predA1
cbind(test, predA1)
predA2 = factor(ifelse(predA1 < 0.5,0, 1))  #classify into 0 or 1
cbind(test, predA1, predA2)  #see them together

#confusion matrix using table command
table(test$bought, predA1, dnn=list('actual','predicted'))
caret::confusionMatrix(test$bought, predA2)

#checking accuracy of model using mean command
levels(predA2); levels(test$bought)
predA2; test$bought
cbind(actual = test$bought, predicted=predA2)
predA1 == test$bought

