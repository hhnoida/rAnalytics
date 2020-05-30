#Subsetting the data-----
#square bracket notation----
df = matrix(1:12, nrow=4, byrow = F)
df
# Return row 1
df[1, ]

# Return column 3
df[,3]

# value of Rows 1:3 in column 2
df[1:3, 2]

#subset a vector
x <- c(2.1, 4.2, 3.3, 5.4)
x
#extracting 3rd and 1st elements
x[c(3, 1)]
#omit elements at the specified positions:
x[-c(3, 1)]
#Logical vectors select elements where the corresponding logical value is TRUE
x[c(TRUE, TRUE, FALSE, FALSE)]
x[x > 3]
#Nothing returns the original vector.
x[]

#If the vector is named
(y <- setNames(x, letters[1:4]))
#extraction with column names
y[c("d", "c", "a")]

#example 2
a <- matrix(1:9, nrow = 3)
colnames(a) <- c("A", "B", "C")
a
#extracting 1st and 2nd rows from matrix
a[1:2,]
#Extracting element at position of 3rd row 3rd column
a[3,3]

#excluding 2nd column; 2nd row
a[-2,-2] 

#subsetting data frame
df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
df

df[df$x == 2, ]

#Subsetting a data frame----
#Subset function----
set.seed(1234)
x <- round(matrix(rnorm(30, 1), ncol = 5), 2)
y <- c(1, seq(5))
#combining x and y into one matrix
x <- cbind(x, y)
x
#converting x into a data frame called x.df
x.df <- data.frame(x)
x.df
?rnorm

#Subsetting rows using the subset function
subset(x.df, y > 2)

#Subsetting rows using multiple conditional statements
subset(x.df, y > 2 & V1 > 0.2)

#Subsetting both rows and columns
?subset
subset(x.df, y > 2 & V2 > 0.4, select = c(V1, V4))


#Subsetting using Which() statement and conditional statements
#Which function----
#Returns the position of “Z” and “S” in the letters object
?which

letters
which(letters=="z")
which(letters=="s")

#using data frame WOMEN
women
which(women$height==66)
which(women$height>=70)

#Which for subsetting vector and using conditions
#Example1
j = c(2,3,4,5,6,7,8,9,23,24,22,1,10)
j>6
which(j>6)
a = j[which(j > 6)]
a

letters
LETTERS
which(LETTERS == "K")  #11th alphabet

#Example2
marks = c(10,30,40, 60)
which(marks > 30)  #position
marks[which(marks > 30)]  #which of thos valuees

#Example3 - using grep command
names = c('jack','jill', 'tom','jerry','buggs', 'bunny')
#which names have bu
grep('[bu]', names, ignore.case=T)
names[grep('[bu]', names, ignore.case=T)]

?grep

#Example4
mtcars
which(mtcars$mpg > 25)
mtcars[which(mtcars$mpg > 25),]
