#Association Rule for financial products
#we will create a dataset; learn how to save it to our directory and read it as transaction class
#how to create rules for the saving plans
library("arules") #loading a rule library

#creating a simulated financial product dataset, converting it to transactions and analysing it
set.seed(101)
transactionID = sample(1:500, 1000, replace=T) #1000 random values to transaction ID
transactionID
str(transactionID)

#creating a vector
finproducts = c('Mutual Funds', 'NPS', 'Savings Account', 'PPF', 'FD', 'Bonds', 'Demat', 'General Insurance', 'NRI Banking', 'Car Insurance', 'Credit Card')
length(finproducts)
item = sample(finproducts,1000, replace=T) #1000 values to finproducts(items)
item

#creating a dataset
orders = data.frame(transactionID, item)
head(orders)

#Saving the created dataset to the repository
write.csv(orders, "./Financial Analytics/fin_transactions.csv")

#Reading the file as a transaction data set in order to generate rules out of it for analysis
ordertrans <- read.transactions('./Financial Analytics/fin_transactions.csv',  format = "single", sep = ",",  cols=c("transactionID","item"),  rm.duplicates = T, header = T )

ordertrans #will return the structure of transaction dataset: number of transactions and items 
inspect(ordertrans[1:10]) #to view the data as transaction: inspect is used

#plotting the item wise frequency plot (barplot); if large number of items are there use topN to get most frequent items only
#Plotting the most 
itemFrequencyPlot(ordertrans,topN = 10, type="absolute") #absolute gives frequency
abline(h=80)# if you want to know which saving plan are bought more than 80 times 
itemFrequencyPlot(ordertrans, topN = 10, type='relative')#type = relative- gives proportions;

#find frequent item set : takes parameter only as support (conf not used)
frequentItems <- eclat(ordertrans, parameter = list(supp = 0.005, minlen= 2, maxlen = 5)) 
frequentItems
inspect(frequentItems[1:10])
3/439*100
26/439*100
#sorting te data as pr count 
sort= sort(frequentItems, by="support", decreasing=TRUE)
inspect(sort[1:10])

#Applying apriori algotrithm
#Creating rules and the relationship between items
#parameters are min filter conditions; randomly taking the support and confidence level 
#default min support is 0.1 and min conf is 0.8, minlen is 1 and maxlen is 10. This means that rules with only one item (i.e., an empty antecedent/LHS) 

rules1 <- apriori(ordertrans, parameter = list(supp = 0.005, conf = 0.5))
rules1
inspect(rules1)
quality(rules1) 
5/439

#sorting the rules 
#sorting it based on lift
sortrules = sort (rules1, by="lift", decreasing=TRUE)
inspect(sortrules)

#sorting it based on count
sortrules1 = sort (rules1, by="count", decreasing=TRUE)
inspect (sortrules1)

subset= subset(rules1, subset= rhs %in% "PPF")
inspect(subset)

#plotting the rules
library(arulesViz)
plot(rules1, measure=c("support", "confidence"), shading="lift")
