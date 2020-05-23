#ggplot- grammer of graphics
#Layers of ggplot-----
#Data
#Aesthetics
#Geometry
#Statistics
#Position
#Facets

#Types of graphs----
#Scatter Plot
#Bar Graph
#Heatmap
#install.packages()
library(ggplot2)
library(dplyr)
head(mtcars)

#SCATTER PLOT-----

#basic scatter plot (wt vs mpg)
plot(mtcars$wt, mtcars$mpg)

#1st layer of ggplot- creating base for plotting
ggplot(data=mtcars, aes(x=wt, y=mpg)) 

#adding geometry to graph 
ggplot(data=mtcars, aes(x=wt, y=mpg)) + geom_point()

#adding aesthetics : color, size and shape of point
ggplot(data=mtcars, aes(x=wt, y=mpg)) + geom_point(color='red', size=3)
ggplot(data=mtcars, aes(x=wt, y=mpg)) + geom_point(color='red', size=3, shape = 20)

head(mtcars)

table(mtcars$cyl)
table(mtcars$gear)
table(mtcars$carb)
table(mtcars$am)

#adding different dimensions to ggplot now: adding col as per no. of cyl
#ggplot(data=mtcars, aes(x=wt, y=mpg)) + geom_point(color = cyl, size= 3, shape=20)
ggplot(data=mtcars, aes(x=wt, y=mpg)) + geom_point(aes(color = cyl), size= 3, shape=20)
ggplot(data=mtcars, aes(x=wt, y=mpg)) + geom_point(aes(color = factor(cyl)), size= 3, shape=20)

#adding different dimensions to ggplot now: adding size as per types of transmission
ggplot(data=mtcars, aes(x=wt, y=mpg)) + geom_point(aes(color = factor(cyl), size=factor(am)), shape = 20)

#adding different dimensions to ggplot now: adding col as per no. of gear
ggplot(data=mtcars, aes(x=wt, y=mpg)) + geom_point(aes(color = factor(cyl), size=factor(am), shape = factor(gear)))

#adding labels to the graph
ggplot(data=mtcars, aes(x=wt, y=mpg)) + geom_point(aes(shape=factor(gear), size=factor(am), color=factor(cyl))) + labs(title='Adding dimensions to graph', subtitle = 'Scatter Plot', x='Weight', y='Mileage')

#adding more dimensions to analyse data from all 
?mtcars

# adding facet layer and  adding mode dimension to graph
ggplot(data=mtcars, aes(x=wt, y=mpg)) + geom_point(aes(color = factor(cyl), size=factor(am), shape = factor(gear))) + labs(title='Adding dimensions to graph', subtitle = 'Scatter Plot', x='Weight', y='Mileage') + facet_grid(vs~carb)

ggplot(data=mtcars, aes(x=wt, y=mpg)) + geom_point(aes(color = factor(cyl), size=factor(am), shape = factor(gear)))  + labs(title='Adding dimensions to graph', subtitle = 'Scatter Plot', x='Weight', y='Mileage') + facet_grid(cyl + vs~carb)

#So, in a graph we can add atleast 7 dimensions, making it interactive and precise to need

#adding text to points, name of the cars
ggplot(data=mtcars, aes(x=wt, y=mpg)) + geom_point(aes(color = factor(cyl), size=factor(am), shape = factor(gear))) + facet_grid(cyl + vs~carb) + labs(title='Adding dimensions to graph', subtitle = 'Scatter Plot', x='Weight', y='Mileage') + geom_text(aes(label=rownames(mtcars)), size=2.5)

#adding text to points, name of the cars using ggrepel package to make graph tidy
ggplot(data=mtcars, aes(x=wt, y=mpg)) + geom_point(aes(color = factor(cyl), size=factor(am), shape = factor(gear))) + facet_grid(vs~carb) + labs(title='Adding dimensions to graph', subtitle = 'Scatter Plot', x='Weight', y='Mileage') + ggrepel::geom_text_repel(aes(label=rownames(mtcars)), size=2.5)

#BAR PLOT----

#converting certain columns to factor data type (categorial variables)
barplot(mtcars$cyl)
barplot(table(mtcars$cyl))

#creating bar plot using no. of cyl to fill color to bars/ if col will be used- borders of bar will be coloured

ggplot(data=mtcars, aes(x=cyl)) + geom_bar()
ggplot(data=mtcars, aes(x=cyl)) + geom_bar(fill='red')
ggplot(data=mtcars, aes(x=cyl)) + geom_bar(col='red')
ggplot(data=mtcars, aes(x=cyl)) + geom_bar(aes(fill= factor(cyl))) + coord_flip()
ggplot(data=mtcars, aes(x=cyl)) + geom_bar(aes(col= factor(cyl))) 

# If you want the heights of the bars to represent values in the data, use stat="identity" and map a value to the y aesthetic.

#summarising and summing the count of cars against no. of cyl ; using stat= identity to get count on top of bars

mtcars %>% group_by(cyl)  %>% summarise(n=n())  %>% ggplot(., aes(x=cyl, y=n)) + geom_bar(stat='identity', aes(fill=factor(cyl))) + geom_text(aes(label=n)) 

#adding facet layer to the graph; the graph is equally divided
mtcars %>% group_by(cyl,gear, am, vs)  %>% summarise(n=n())  %>% ggplot(., aes(x=cyl, y=n)) + geom_bar(stat='identity', aes(fill=factor(cyl))) + geom_text(aes(label=n)) + facet_grid(gear ~ am)

#updating facet layer-scales and space = free-- makes full use of the graph area otherwise the values are very small so the bars will also be short- zooms the graph by auto selectingthe limits

mtcars %>% group_by(cyl,gear, am, vs)  %>% summarise(n=n())  %>% ggplot(., aes(x=cyl, y=n)) + geom_bar(stat='identity', aes(fill=factor(cyl))) + geom_text(aes(label=n)) + facet_grid(gear ~ am, scales='free', space='free')

# HEAT MAP ----
a = mtcars %>% group_by(cyl,gear)  %>% summarise(n=n())  
a
ggplot(a, aes(x=factor(cyl), y=factor(gear), fill=n)) + geom_tile() 

ggplot(a, aes(x=factor(cyl), y=factor(gear), fill=n)) + geom_tile() + geom_text(aes(label=n), size=6) 

ggplot(a, aes(x=factor(cyl), y=factor(gear), fill=n)) + geom_tile() + geom_text(aes(label=n), size=6) + scale_fill_gradient2()

