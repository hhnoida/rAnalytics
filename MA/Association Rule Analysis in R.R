#Association Rule Analysis: Market Basket Analysis

pacman::p_load(arules, arulesViz, datasets)
#install and load 
#library(arules)#library(arulesViz)  
#library(datasets)  # no need to install, just load it reqd for Groceries

data('Groceries') #different format - transaction format
Groceries #gives dimensions of dataset. 9835 transactions and 169 items
str(Groceries) 

#Checking Transactions of the dataset
#inspecting few transactions bby specifying the numbers
inspect(Groceries[1:5])
LIST(Groceries[1:5])

#plotting the top 20 items with the higest item frequency 
itemFrequencyPlot(Groceries, topN = 20, type = 'absolute') #gives frequency
itemFrequencyPlot(Groceries, topN = 10, type = 'relative')#gives probability

#find frequent item set : takes parameter only as support (conf not used)
frequentItems <- eclat (Groceries, parameter = list(supp = 0.005, minlen= 2, maxlen = 5)) 
frequentItems
inspect(frequentItems[1:10])
55/9835

#Creating rules and the relationship between items
#parameters are min filter conditions; randomly taking the support and confidence level 
#default min support is 0.1 and min conf is 0.8, minlen is 1 and maxlen is 10. This means that rules with only one item (i.e., an empty antecedent/LHS) like : {} => {beer}

rules = apriori(Groceries, parameter = list(supp = 0.005, conf = 0.5))
rules
inspect(rules)
91/9835

#Sort Rules by lift and see the data
sortrules = sort(rules, by = 'lift', decreasing = T)
sortrules
inspect(sortrules[1:20])

#subset of rules
subset1 = subset(rules, subset=rhs %in% "whole milk")
subset1
inspect(subset1) # rhs has milk

inspect(subset(sortrules, subset=lhs %in% 'bottled beer' ))
subset(sortrules, subset=rhs %in% 'bottled beer' )


#plotting the rules
library(arulesViz)
plot(subset1, measure=c("support", "confidence"), shading="lift")
