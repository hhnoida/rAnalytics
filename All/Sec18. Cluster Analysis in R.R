#Cluster Analysis
#Clustering with mtcars
pacman::p_load(dplyr, ggplot2)
head(mtcars)
df = mtcars[,c('mpg', 'wt', 'hp', 'am')]
head(df)

#kmeans------
#building kmeans clutering models with 3 centers
km1 = kmeans(df, centers=3)
km1
cbind(df, km1$cluster)
table(km1$cluster) #help to know the number of observations in each cluster
df[ km1$cluster==1,]
df %>% filter(km1$cluster == 2)
df %>% arrange(km1$cluster)

#based on clusters lets find the mean of variables in our dataset 
df %>% group_by(cluserNo = km1$cluster) %>% summarise_all(mean, na.rm=T)

#plotting the clusters using package factoextra
library(factoextra)
fviz_cluster(km1, data = df)

#how to choose best number of clusters - elbow method
#elbow method contains 2 methods: factoextra and NbClust
#factoextra method
set.seed(123)
?geom_vline
fviz_nbclust(df, kmeans, method = "wss") #With-in-Sum-of-Squares
fviz_nbclust(df, kmeans, method = "wss") + geom_vline(xintercept = 3, linetype = 2) + labs(subtitle = "Elbow method") 
#xintercept: Parameters that control the position of the line
#from above function(elbow method) we get to know, the best no. of clusters is 2, 3 or 4

#Lets verify it with one more method
#NbClust method:
library(NbClust)
?NbClust
set.seed(1234)
nc <- NbClust(df, distance = "euclidean", min.nc=2, max.nc=6, method = "kmeans")
nc
#It help us to clearly understand that the optimal number of cluster for analysis are 3

#If there is data where different variables contains different range of values; we need to scale the data to one 
marks1 = c(65, 60, 70, 75, 67)  #5 students  #2 groups
marks2 = c(95, 80, 52, 55, 57)
project = c(120, 100, 90, 80,110)
(exam3 = data.frame(marks1, marks2, project))
#project marks will be more dominating
exam3scaled = scale(exam3) #function used to scale the data 
exam3scaled #-3 to 3 : Z score scaling
cluster2C  = kmeans(exam3scaled, centers=2)
cluster2C
cluster2C$cluster
cbind(exam3, group=cluster2C$cluster)

#hierarchial clusering------
df = mtcars[,c('mpg', 'wt', 'hp', 'am')]
dfD = dist(df)#distance matrix of the dataset
dfD

#example for distance matrix
#using the data created exam3
exam3
#project marks will be more dominating
exam3scaled = scale(exam3)
exam3scaled
res.dist <- dist(exam3, method = "euclidean") #dist is the function to create distance matrix
res.dist

#euclidean distance: d(p,q) = sqrt[ (q1 - p1)^2 + (q2 - p2)^2)
#

#as.matrix(dfD)
hc = hclust(dfD)
plot(hc)  #which car is closer to the other

#The complete linkage method finds similar clusters. 
#The single linkage method (which is closely related to the minimal spanning tree) adopts a ‘friends of friends’ clustering strategy.

#Cut tree into 4 groups
sub_grp <- cutree(hc, k = 4)

# Number of members in each cluster
table(sub_grp)


#creating models using different methods : average
hc.average = hclust(dfD, method = 'average')
hc.average
plot(hc.average, hang=-1, cex=.8, main='Average Linkage Clustering: Cluster Nos')

#rect.hclust - k & h= scalers to cut the dendogram to get desired clusters
#k cluster cut 
rect.hclust(hc.average, k=4, border = 2:6)
#h height cut
plot(hc.average, hang=-1, cex=.8, main='Average Linkage Clustering')
rect.hclust(hc.average, h=100)

abline(h=100)
