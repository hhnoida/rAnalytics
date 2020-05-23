#Summarising the data graphically

# Scatter Plot
# Box Plot
# Histogram
# Bar Graph / BarPlot
# Line Graph
# Pie Chart

# Simple Scatterplot----
#plot(x, y, main, xlab, ylab, xlim, ylim, pch, cex)
#we can add 5 dimensions to a scatter plot of 2dim
?plot

X1 = 1:10
Y1 = X1^2
X1
Y1
plot(x=X1 , y= Y1)

# adding linetype
?plot
plot(x=X1, y=Y1, type='p') #lty = linetype = points
plot(x=X1, y=Y1, type='l') #lty = linetype =lines
plot(x=X1, y=Y1, type='b') #lty = linetype = both

#adding line width, color and cex(size of point)
plot(x=X1, y=Y1, type='b', lwd= 1, col = 'red', cex=1)
plot(x=X1, y=Y1, type='b', lwd= 2, col = 'blue', cex=1.5)
plot(x=X1, y=Y1, type='b', lwd= 3, col = 'purple', cex=2)

#change the limits of x and y xaxis
plot(x=X1, y=Y1, xlim=c(0,10), ylim=c(0,100), type = 'b', cex=1, col='blue') 

#using mtcars dataset: plotting mpg and weight
plot(mtcars$wt, mtcars$mpg, col = 'blue', pch = 20, cex=1.5)
plot(mtcars$wt, mtcars$mpg, col= 'blue', pch=20, cex=1, xlab= 'weight', ylab= 'Mileage', main= 'Weight vs MPG' )

table(mtcars$gear)
table(mtcars$cyl)
plot(x= wt, y= mpg, col= cyl, pch= gear, cex= 1, xlab='Weight', ylab='Mileage', main='Weight vs Mileage')

# Add fit lines
abline(lm(mpg~wt), col="red") # regression line (y~x)

#plotting wt to mpg graph and adding legends to it 
#X-Weight, Y-Mileage, Color-Cylinder, Shape-Gear, Size-AM : Points
lapply(mtcars[,c('cyl','gear','am')], table)  #count of each category cols

#you should know this to plan how many colors, shapes, size to choose
plot(x= mtcars$wt, y= mtcars$mpg, col=c(1,2,3), pch=c(20,21,22), cex=c(1,2), xlab='Weight', ylab='Mileage', main='Weight vs Mileage')

?legend
legend("topright",legend=c("Cyl-4", "Cyl-6", "Cyl-8"),pch=10, col=1:3, title="Cylinder")

legend("bottomleft", inset=.02, legend=c("Gear-3", "Gear-4", "Gear-5"), pch=20:23, title="Gear")

legend("top", legend=c('Auto','Manual'), pch=c(20,21), pt.cex=c(1,1.5), title='Tx Type')


#Pair plot : for comparing multiple variables dataset in one graphs
#A matrix of scatterplots/ set of multiple scatterplots
my_cols <- c("#00AFBB", "#E7B800", "#FC4E07")  
pairs(mtcars, pch = 19,  cex = 0.5,
      col = my_cols[mtcars$carb],
      lower.panel=NULL)

#Box Plot ----
#boxplot(x, main, xlab, ylab, pch, col, border, horizontal)
#Method for graphically depicting groups of numerical data through their quartiles and finding the outliers, Data based on a five number summary (“minimum”, first quartile (Q1), median, third quartile (Q3), and “maximum”)

?boxplot

#showing mean of mpg
boxplot(x=mtcars$mpg, col = 'green') #col= colour for plotting
abline(h=mean(mtcars$mpg))

abline(h=quantile(mtcars$mpg))

boxplot(x=mtcars$mpg, col = 'green', horizontal = T) #horizontal= direction of boxplot  

## boxplot on a formula:
?InsectSprays
head(InsectSprays)
boxplot(count ~ spray, data = InsectSprays, col = "lightgray")
# *add* notches (somewhat funny here <--> warning "notches .. outside hinges"):
boxplot(count ~ spray, data = InsectSprays,
        notch = TRUE, col = "blue") # Notch is used to compare groups.In the notched boxplot, if two boxes' notches do not overlap this is ‘strong evidence’ their medians differ. allows you to evaluate confidence intervals (by default 95% confidence interval) for the medians of each boxplot.
#If the distance between median and the 2nd quartile and the distance between median and the 3rd quartile are extremely different (like the one at the right) and/or the sample size is low, the notch will be wider. If it's wide enough that the notch boundary is more extreme than the 2nd and 3rd percentiles (aka, the box), then the notched box plot will display this "inside out" shape.

#using formula for mtcars
boxplot(mpg ~ cyl, data = mtcars,
        xlab = "Number of Cylinders",
        ylab = "Miles Per Gallon",
        notch = F,
        main = "Mileage Data",
        col = c("green","yellow","purple"),
        names = c("High","Medium","Low")) 

#Bar Plot----
#example
#Bar and column charts are used to compare different items
#Bar charts are often used when comparing categories of data
cars <- c(1, 3, 6, 4, 9)
trucks <- c(2, 5, 4, 5, 12)
suvs = c(4,4,6,6,16)
autos_data = data.frame(cars,trucks,suvs)
autos_data
barplot(autos_data$cars, main="Auto Data", xlab="Days",  
        ylab="Total", names.arg=c("Mon","Tue","Wed","Thu","Fri"), 
        border="blue", density=c(10,20,30,40,50))

# Graph autos with adjacent bars using rainbow colors
barplot(as.matrix(autos_data), main="Autos", ylab= "Total",
        beside=TRUE, col=rainbow(5))

barplot(as.matrix(autos_data), main="Autos", ylab= "Total",
        beside=TRUE, col=rainbow(5), horiz = T)

# Place the legend at the top-left corner with no frame  
# using rainbow colors
legend("topleft", c("Mon","Tue","Wed","Thu","Fri"), cex=1, 
       bty="n", fill=rainbow(5)) #bty = type of box to be drawn around the legend

# Graph autos (transposing the matrix) using heat colors,  
# put 10% of the space between each bar, and make labels  
# smaller with horizontal y-axis labels
autos_data
t(autos_data)
barplot(t(autos_data), main="Autos", ylab="Total", 
        col=heat.colors(3), space=0.1, cex.axis=1, las=1,
        names.arg=c("Mon","Tue","Wed","Thu","Fri"), cex=1) 

legend("topleft", c("Cars","Trucks","SUVs"), cex=1, 
       bty="n", fill=heat.colors(3))
legend("top", c("Cars","Trucks","SUVs"), cex=1, 
       bty="n", fill=heat.colors(3))

#Histogram
#Shows frequency distribution (shape) of a set of continuous data

?hist

# histogram for a normally distributed data
hist(rnorm(1000))
hist(rnorm(1000), probability = T)

#histogram for a skewed data
hist(islands) #gives result in frequencies
hist(islands,probability=TRUE) # proportions (or probabilities)
islands
hist(islands, breaks=5, main="islands histogram", xlab="Area range", border="red", col="grey")

#Craeating histogram for temprature values in dataset- airquality
head(airquality)
hist(airquality$Temp)

#adding label names and title
hist(airquality$Temp,
     main = "Temperature Histogram",
     xlab = "Temperature",
     ylab = "Temperature Frequency",
     las = 1
)

#adding color to bars
hist(airquality$Temp,
     main = "Temperature Histogram",
     xlab = "Temperature",
     ylab = "Temperature Frequency",
     las = 1,
     col = c("skyblue", "chocolate2")
)

#removing all the annotations and axis lim and name to give our own
hist(airquality$Temp,
     axes = FALSE,
     ann = FALSE,
     labels = TRUE,
     ylim = c(0, 35),
     col = c("skyblue", "chocolate2")
)

#specifying own annotations
hist(airquality$Temp,
     main = "Temperature Histogram",
     xlab = "Temperature",
     ylab = "Temperature Frequency",
     las = 1,
     col = c("skyblue", "chocolate2"),
     xlim = c(55, 100),
     ylim = c(0, 40), 
     density = 80
)

#giving number of breaks and adding numbers to the bars
hist(airquality$Temp,
     breaks = 20,
     main = "Temperature Histogram",
     xlab = "Temperature",
     ylab = "Temperature Frequency",
     las = 1,
     col = c("skyblue", "chocolate2"),
     labels = TRUE,
     ylim = c(0, 25)
)

#changing frequency on y axis to density/probabilitiy values; removing labels also asthey are in freq value only and adding density line
hist(airquality$Temp,
     breaks = 20,
     freq = F,
     main = "Temperature Histogram",
     xlab = "Temperature",
     ylab = "Temperature Frequency",
     las = 1,
     col = c("skyblue", "chocolate2"),
     labels=T)

lines(density(airquality$Temp), lwd = 4, col = "red")


hist(airquality$Temp,
     breaks = 20,
     main = "Temperature Histogram",
     xlab = "Temperature",
     ylab = "Temperature Frequency",
     las = 1,
     col = c("skyblue", "chocolate2"),
     labels = TRUE,
     ylim = c(0, 25)
)

# Pie Chart
#Pie charts are used to show parts of a whole.
#Represents numbers in percentages, and the total sum of all the divided segments equals 100 percent.

# Create a pie chart for cars
cars <- c(1, 3, 6, 4, 9)
pie(cars)

# custom colors and labels
pie(cars, main="Cars", col=rainbow(length(cars)),
    labels=c("Mon","Tue","Wed","Thu","Fri"))

# Define some colors ideal for black & white print
colors <- c("white","grey70","grey90","grey50","black")

# Calculate the percentage for each day, rounded to one 
# decimal place
car_labels <- round(cars/sum(cars) * 100, 1)
car_labels
# Concatenate a '%' char after each value
car_labels <- paste(car_labels, "%", sep=" ")
car_labels

# and labels
pie(cars, main="Cars", col=colors, labels=car_labels,
    cex=0.8)

# Create a legend at the right   
legend('topright', c("Mon","Tue","Wed","Thu","Fri"), cex=0.8, 
       fill=colors)


# 3D Exploded Pie Chart
library(plotrix)
slices <- c(10, 12, 4, 16, 8)
lbls <- c("US", "UK", "Australia", "Germany", "France")
pie3D(slices,labels=lbls,explode=0.1,
      main="Pie Chart of Countries ")

