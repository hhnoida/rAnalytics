#Basic Operators of R

#Assignment operators
#Arithmetic operators
#Relational operators
#Logical operators

#Assignment Operators
# <- , <<-, = -- Leftward Assigment
# ->, ->> -- rightward assignment

#leftward
h <- 10
i <<- 11
j = 12

#rightward
13 -> k 
14 ->> l

h #left
i #left
j #left
k #right
l #right

#Arithmetic Operators
# + addition
# - subtraction
# * multiplication
# / division
# ^ exponent
# %% modulus (gives remainder from division)
# %|% Integer division

x= 5
x
y= 2
y

x + y #addition
x - y #subtraction
x * y #multiplication
x / y #division
x ^ y #exponent 
x %% y #gives the remainder
x %/% y #gives the quotient

#Relational Operator
# < Less than
# > Greater than
# <= less than or equal to
# >= greater than or equal to
# == Equal to
# != not equal to
# It gives result as true and false, coz it is relating the vectors. 

a = 5
b = 9

a < b
a > b
a <= b
a >= b
a == b
a != b

#Logical Operators
#& Logical &
# ! logical NOT
# && Element wise logical and
# | logical OR
# || Element wise Logical OR

f = 14
f

#AND operator 
f > 5 & f < 15
f > 5 & f > 15

#OR operator
f < 5 | f > 15
f > 5 | f > 15

#NOT operator
!(f < 5)
f < 5

is.numeric(5)
!is.numeric(5)

# try on vector

c(TRUE, TRUE, FALSE) & c(TRUE, FALSE, FALSE) # Compares all the elements
c(TRUE, TRUE, FALSE) | c(TRUE, FALSE, FALSE)  # Compares all the elements
!c(TRUE, FALSE, FALSE) # opposite of the vector elements

# Element wise comparing operatos
c(TRUE, TRUE, FALSE ) && c(TRUE, FALSE, FALSE ) # Compares on first elements of each vetor
c(TRUE, TRUE, FALSE ) || c(TRUE, FALSE, FALSE ) # Compares on first elements of each vetor
c(TRUE, TRUE, FALSE ) || c(FALSE, FALSE, FALSE ) # Compares on first elements of each vetor
