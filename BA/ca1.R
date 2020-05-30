#clustering1  : kmeans & heirachical 

pacman::p_load(dplyr, ggplot2)
#kmeans - number of clusters to be provided before. Numeric data

#marks of one subject : group them
marks1 = c(65, 60, 70, 75, 67)  #5 students  #2 groups
(exam1 = data.frame(marks1))
cluster2  = kmeans(exam1, centers=2)
cluster2
cluster2$cluster
cbind(exam1, group=cluster2$cluster)

#how does it happen
#for every point distance with other points are calculated
#eclidean :  sqrt((x1-x2)^2)

marks1 = c(65, 60, 70, 75, 67)  #5 students  #2 groups
marks2 = c(95, 80, 52, 55, 57)
(exam2 = data.frame(marks1, marks2))
cluster2B  = kmeans(exam2, centers=2)
cluster2B
cluster2B$cluster
cbind(exam2, group=cluster2B$cluster)
cluster2B$centers
#eclidean :  sqrt[ (x1-x2)^2 + (y1-y2)^2 ] 
#https://www.youtube.com/watch?v=5I3Ei69I40s

marks1 = c(65, 60, 70, 75, 67)  #5 students  #2 groups
marks2 = c(95, 80, 52, 55, 57)
project = c(120, 100, 90, 80,110)
(exam3 = data.frame(marks1, marks2, project))
#project marks will be more dominating
exam3scaled = scale(exam3)
exam3scaled #-3 to 3 : Z score scaling
cluster2C  = kmeans(exam3scaled, centers=2)
cluster2C
cluster2C$cluster
cbind(exam3, group=cluster2C$cluster)
cluster2C$centers
exam3 %>% group_by(group=cluster2C$cluster) %>% summarise(mean1 = mean(marks1), mean2= mean(marks2), P= mean(project))

#-----
#numeric, cluster Nos, scaling
df = mtcars
sapply(df, class)  #all are numeric

km1 = kmeans(df, centers=2)
km1  #attributes of this model
kml1$size #how many cars in each cluster
km1$cluster  #which rownumber of car goes into which cluster
km1$centers  #average values of data of each cluster
km1$withinss
km1$totss
km1$tot.withinss

df %>% dplyr::group_by(cluster=km1$cluster) %>% summarise(meanMPG =mean(mpg), meanWt = mean(wt, na.rm=T)) #average mpg & wt in each cluster

plot(x=df$mpg, y=df$wt, col=kml1$cluster) #mpg vs wt with color as per cluster No

#how to choose no of cluster mathematically (business reqmt can be seperate)
#cohesion within the cluster, separation with cluster
pacman::p_load(NbClust, factoextra)
factoextra::fviz_cluster(km1, data = df)

#how to choose best cluster
#factoextra method
set.seed(123)
factoextra::fviz_nbclust(df, kmeans, method = "wss") + geom_vline(xintercept = 3, linetype = 2)+
  labs(subtitle = "Elbow method")
#With-in-Sum-of-Squares
factoextra::fviz_nbclust(df, kmeans, method = "silhouette") +  # it determines how well each object lies within its cluster

fviz_nbclust(df, FUN = hcut, method = "silhouette")
  
  #NbClust method----
set.seed(1234)
nc <- NbClust(df, distance = "euclidean", min.nc=2, max.nc=6, method = "kmeans")
nc
nc$All.index
nc$Best.nc
nc$Best.partition

table(nc$Best.partition)
df %>% group_by(cluster = nc$Best.partition) %>% summarise(meanMPG= mean(mpg), meanWt = mean(wt, na.rm=T))


#can be used for market segmentation
#values have to be numeric 
#scaling ---------------------
#when values of different column have different ranges, we scale the values.
#most common scale is z scores, which scales values of column between -3 to 0 to 3

#good cohesions inside a group; good seperation between the groups.. that is the aim

#heirachical clustering
head(df)
dfScaled = scale(df)
dfScaled
data = dist(dfScaled)
head(data)
as.matrix(data)
?hclust
fit.average = hclust(data, method = 'average')
fit.average
fit.complete = hclust(data, method = 'complete')
fit.complete
fit.single = hclust(data, method = 'single')
fit.single
#The complete linkage method finds similar clusters. 
#The single linkage method (which is closely related to the minimal spanning tree) adopts a ‘friends of friends’ clustering strategy.
plot(fit.average, hang=-1, cex=.8, main='Average Linkage Clustering: Cluster Nos')
plot(fit.complete, hang=-1, cex=.8, main='Complete Linkage Clustering: Cluster Nos')
plot(fit.single, hang=-1, cex=.8, main='Single Linkage Clustering: Cluster Nos')

#rect.hclust - k & h= scalers to cut the dendogram to get desired clusters
#k scaler cut
?rect.hclust
rect.hclust(fit.average, k=4)
#h scaler cut
plot(fit.average, hang=-1, cex=.8, main='Average Linkage Clustering')
rect.hclust(fit.average, h=4)

#factoextra method
set.seed(123)
?fviz_nbclust
library(factoextra)
library(cluster)
?clusGap
clusGap(data, hcut, K.max = 10)

marks1 = c(65, 60, 70, 75, 67)  #5 students  #2 groups
marks2 = c(95, 80, 52, 55, 57)
project = c(120, 100, 90, 80,110)
(exam3 = data.frame(marks1, marks2, project))
#project marks will be more dominating
exam3scaled = scale(exam3)
res.dist <- dist(exam3, method = "euclidean")
res.dist
