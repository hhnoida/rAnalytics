#Apply Family-----
#Functions form the basis of more complex combinations 
#Helps to perform operations with very few lines of code.
#More specifically, the family is made up of the apply(), lapply(), sapply(), vapply(), mapply(), rapply(), nd tapply() functions.

#apply()----
?apply
#apply(X, MARGIN, FUN, ...)
#data frame creation
df <- data.frame(first = c(1:10), second = c(11:20))
df

#2 (margin) is for columns
#
apply(df, 2, mean)

#1 (margin) is for rows
apply(df, 1, mean)

#sorting the data
x <- cbind(x1 = 3, x2 = c(4:1, 2:5))
?cbind
x
dimnames(x)[[1]] <- letters[1:8]
x
apply(x, MARGIN = 2, FUN= mean)
col.sums <- apply(x, 2, sum)
col.sums
row.sums <- apply(x, 1, sum)
row.sums

apply(x, 2, sort)

#lapply-----

#Eg1:
# Create a list of matrices
(A = matrix(1:9,nrow=3,byrow=F))
(B = matrix(4:15,nrow=4,byrow=F))
(C =  data.frame(x=c(8,9,10),y=c(8,9,10))) 
MyList <- list(A,B,C)
MyList

# Extract the 2nd column from `MyList` with the selection operator `[` with `lapply()`
lapply(MyList,"[",, 2)

#you start by specifying the object of interest, the list Mylist. You use the standard R selection operator [ and then omit the first parameter (which therefore translates into “any”, that’s why you see the two commas). the second parameter, which is 2: our margin is ‘column’. So you extract the second column from all the matrices within the list.

# Extract the 1st row from `MyList`
lapply(MyList,"[", 1, )

# Extract a single element for each matrice from `MyList`
lapply(MyList,"[", 1, 2 )
MyList

#Eg2:
movies <- c("SPYDERMAN","BATMAN","VERTIGO","CHINATOWN")
movies_lower <-lapply(movies, tolower)
movies_lower

#Sapply()----
A= lapply(MyList,"[", 1, 1)
A
Z= sapply(MyList,"[", 1, 1)
Z

#tapply----

#Mean MPG of each AM type in mtcars... df = mtcars %>% select(-am)
?mtcars
names(mtcars)
AM1=mtcars[,'am']
AMCYL1 = mtcars[, c('cyl','am')]
MPG1=mtcars[, c('mpg')]
tapply(MPG1, AM1, mean)
tapply(MPG1, AMCYL1 , mean)
?tapply
head(mtcars)


#rep()-----
Z= sapply(MyList,"[", 1, 1)
Z

a= rep(Z,c(3,1,2))
a

#mapply----
#‘multivariate’ apply.
?mapply
Q= matrix(c(rep(1, 4), rep(2, 4), rep(3, 4), rep(4, 4)),4,4)
Q
P= mapply(rep,1:4,4)
P

mapply(sum, 1:4, 1:4, 1:4)
#mapply sums up all the first elements(1+1+1) ,sums up all the second elements(2+2+2) and so on so the result will be




