#Data Management 
#Renaming variables in R----
#using setnames
library(data.table)
#setnames(DF, "oldName", "newName")

tmp= data.table(a = 1, b = 2, d = 3)
tmp
old = c("a", "b", "d")
new = c('c', 'e', 'f')
setnames(tmp, old, new, skip_absent = TRUE)
tmp

# using names
head(mtcars)
i = mtcars
head(i)
names(i)[1] <- "MPG" 
names(i)

names(i)[names(i) == "cyl"] <- "CYL"
names(i)

#Adding/Removing row/column----
#Adding a row
df <- data.frame(A = c(1,2), B = c(3,4))
df
df[nrow(df) + 1, ] <- c(5,6)
df

#Adding a row
new_row = c(7,8)
df = rbind(df, new_row)
df

#Removing a row
dim(women)
test <- women[-c(14),] 
head(test)
tail(test)
dim(test)

#removing multiple rows
test1 <- women[-c(6, 11,13),] 
(test1)

#Adding Column
df
C = c(4,5,6,7)
df= cbind(df, C)
df

#Method 2: Adding column
df
df$k = c(10,11,12,9)
df
df[['m']] =c(14,15,16,17)
df
df[,'h'] = c(19,20,21,22)
df

#Removing Column
df$k = NULL #method 1 
df[['m']] = NULL #method 2
df[,'h'] = NULL #method 3
df

#reshape - melt, cast
#install.packages('reshape2')
library(reshape2)

df = mtcars
head(df)
df$name = abbreviate(rownames(df))
head(df)
#want data like this

#name, category, value
?melt
dfmelt <- melt(df, id.vars = 'name', variable.name = 'category', value.name = 'value')
dim(df)
head(df)
dim(dfmelt)
(dfmelt)
(dfmelt)
dim(dfmelt)
#11 * 32 - values - 352

#reverse : long data to wide data : dcast
?dcast
dfwide <- dcast(formula=name ~ category, data = dfmelt, value.var = 'value')
head(dfwide)
head(mtcars)


#Sorting the Data----
#using order command
head(mtcars)
df = mtcars[order(mtcars$mpg),] #default increasing order
head(df)
df = mtcars[order(-mtcars$mpg),] #decreasing order
head(df)
df = mtcars[order(mtcars$mpg, decreasing = T),]
head(df)

#Transpose t()
?t()

data = matrix(1:8, nrow = 4 )
data
tdata = t(data)
tdata

#merging data----
#Method 1: using merge command
per_data <- data.frame(cust_id   = c("ID1", "ID2", "ID3"), married = c("Yes", "No", "Yes"), Age = c(44, 23, 35))

per_data
inc_data <- data.frame(cust_id   = c("ID2", "ID1", "ID3"), income = c(60000, 80000, 45000))
inc_data
head(per_data)
head(inc_data)

merge= merge(per_data, inc_data, by= "cust_id")
merge

#Method2
#Adding datasets vertically: adding more rows

make= c('Honda', 'BMW')
num_model = c(63,10)
data1 = data.frame(make, num_model)
data2 = data.frame(make = c('Ford','Tesla'), num_model = c(26,4))

data1
data2

models= rbind(data1, data2) #merging the datasets
models

#Adding datasets Horizontally: add more columns 

sales = data.frame(make= c('Honda','BMW','Ford','Tesla'), sales = c(119157, 25908,188328,29975))
sales
(mod_sale= cbind(models, sales)) #It do not result in a tidy output..it merges data side by side. so its better to use merge command to merge the data

#Splitting the data-----
#Method 1 : Split() command
#eg1
ma <- cbind(x = 1:10, y = (-4:5)^2)
ma
split(ma, col(ma))
?split

#eg2
head(airquality)
dim(airquality)
g <- airquality$Month
head(g)

l <- split(airquality, g)
head(l)

#Method2 : sample(x, size, replace = FALSE, prob = NULL)
data(mtcars)
n = nrow(mtcars)
trainIndex = sample(1:n, size = round(0.7*n), replace=FALSE)
train = mtcars[trainIndex ,]
test = mtcars[-trainIndex ,]
dim(mtcars)
dim(train)
dim(test)
?sample
