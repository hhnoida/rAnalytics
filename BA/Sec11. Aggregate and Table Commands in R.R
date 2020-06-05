#Aggregate-----
  
?aggregate #to understand the function

head(ChickWeight) #using a inbuilt dataset
?ChickWeight # understanding the dataset

data = ChickWeight #copying the dataset to another variable for ease
dim(data) #checking dimension of the dataset

# Now to use aggregate; the usage as defined by ?aggregate:
#aggregate(x, by, FUN, …)

#aggregating the mean weight depending on diet
aggregate(data$weight, by = list(diet = data$Diet), FUN = 'mean')

#find the mean weight depending on time and diet
aggregate(data$weight, by = list(time= data$Time, diet= data$Diet), FUN = mean)

#to get first 6 and last 6 data, use function head() and tail()
head(aggregate(data$weight, by = list(time= data$Time, diet= data$Diet), FUN = mean))
tail(aggregate(data$weight, by = list(time= data$Time, diet= data$Diet), FUN = mean))

#finding max weight for each diet
aggregate(data$weight, by = list(diet = data$Diet), FUN = max)


#reading data to do another aggregation
#using package xlsx
library(xlsx)

ad = read.xlsx('Aggregation_data.xlsx', sheetName = 1)
ad

#finding mean salary expenditure based on shift 
aggregate(ad$Salary, by= list(shift = ad$Shift), FUN= mean)

#aggregating salary based on Role
aggregate(ad$Salary, by= list(role= ad$Role), FUN= mean)

#aggregating salary based on Role and Shift
aggregate(ad$Salary, by= list(role = ad$Role, shift = ad$Shift), FUN= mean)


#Table Command -----

#table, addmargins, margin.table, prop.table

mtcars
str(mtcars)

#table 
?table # performs categorical tabulation of data with the variable 
table(mtcars$cyl)
table(mtcars$cyl, mtcars$gear)
table(mtcars$cyl, mtcars$gear, dnn=c('cyl', 'gear')) #dnn= dimension names
#store in expression t1
t1 = table(mtcars$cyl, mtcars$gear, dnn=c('cyl', 'gear'))
t1

#margin.table - sums values over margin - total sum of table
margin.table(t1)
margin.table(x=t1, margin=1) #cylinder wise #margin-1 : row 
margin.table(x=t1, margin=2)  #gear wise #margin-2 : Column 
  
#addmargins - extend a table with the marginal totals of the rows and columns 
#add different functions over the margins
addmargins(A=t1, margin=1) #default is sum; sum of each column, shown as row
addmargins(A=t1, margin=2, FUN=mean)  #mean as column of each row
addmargins(A=t1, margin=c(1,2), FUN=sum)  #sum at both row and column
addmargins(A=t1, margin=c(1,2), FUN=c(sum,mean))  #two function on rows/ col margins
#different functions in rows and columns
addmargins(A=t1, margin=c(1,2), FUN=list(list(sum,mean, length), list(sd, sum)))

#prop.table - convert a frequency table into proportions
#proportion of values of the table (out of 100%) = sum will come up to 1
t1
prop.table(t1)

#Cyl4, Gear3 : 1 out of 32 = 3.12%
1/32
8/32
prop.table(t1, margin=1)  #sum of each row=1
t1
#Cyl4, Gear 3 : 1 out of 11 Gear3 cars : 1/11
1/11
8/11
2/7
prop.table(t1, margin=2)  #sum of each col=1
#Cyl4, Gear 3 : 1 out of 15 Gear3 cars : 1/15
1/15
2/15
#creating matrix using prop.table and adding %value 
matrix(paste(prop.table(x=t1)*100 , '%', sep=''), ncol=3)

#quick check
rowSums(prop.table(t1, margin=1))  #correct
#rowSums(prop.table(t1, margin=2))
colSums(prop.table(t1, margin=2))
