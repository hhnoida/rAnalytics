#Data Structures
# Vectors                   
# Matrices
# Arrays
# List
# Data Frames
#Factor

#Vector--------
#Numeric
x = c(2,3,4)
class(x)
length(x)

#Character
y= c('a', 'b', 'c')

#Logical
z= c(TRUE, TRUE, FALSE, FALSE)

#Integers
a = c(1L, 2L, 3L)

#Adding element to vector
y = c(y, 'd')

#Vectors from a Sequence of Numbers
series= 1:10
seq(10)
seq(1,10,1.5)
?seq

#Missing Values
#is.na
#anyNA
#anyNA

#When data types are mixed
#as.numeric()
#as.character()

#Matrices-----

#Creating a matrix
m= matrix(nrow = 2, ncol = 2)

#Checking dimension
dim(m)

#Matrix filled row wise with giving names to rows and columns
(mymatrix= matrix(1:6,nrow=3,byrow=TRUE, dimnames= list(c("d", "e","f"), c("a", "b")) ))

#Matrix filled column wise
(mymatrix= matrix(1:6,nrow=3,byrow=FALSE))

#Other ways to construct matrix
m      <- 1:10
dim(m) = c(5,2)
m

#Adding Column to a matrix  ( cbind )
c= c(7,8,9)
mymatrix1= cbind(mymatrix, c)

#Adding Row to a matrix  ( rbind )
g= c(10,11,12)
mymatrix2= rbind(mymatrix1, g)
mymatrix

#Lists -----
(v1 = 1:5)
(v2 = month.abb[4:10])
(v3 = c(T,F, TRUE, FALSE))
(combinedV = c(v1, v2, v3))  
#all converted to character by default


list1 = list(v1, v2, v3)
List1 #each vector stays in there original data types

#Data Frames -----
#Shows structure of similar to excel data

#simplest way
df1 = data.frame(name = c('S1','S2','S3'), age=c(22, 23, 24))
df1

#create using vectors
(rollno  = 1:10)
(name = paste('S', 1:10, sep=''))
(age = round(rnorm(10, mean=25, sd=2),1))
(gender = sample(c('M','F'), size=10, replace=T))
df2 = data.frame(rollno, name, age, gender)

