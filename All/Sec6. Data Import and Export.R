#Importing and Exporting data in R
##importing files
#Functions to read files in tabular format
#Function      Description
#read.table()  main function to read file in table format
#read.csv()    reads csv files separated by a comma ","

#importing a CSV format file
#csv files- used to store tabular data
#CSV stands for "comma-separated values"
x=read.csv("test.csv")
x
str(x)
j=read.csv("test.csv", header = T) #if marked true, first line is will be read as labels, otherwise as a plain text
j

# abc radio stations data URL
abc = "http://www.abc.net.au/local/data/public/stations/abc-local-radio.csv"

# read data from URL
radio = read.table(abc, header = TRUE, sep = ",", stringsAsFactors = FALSE)
str(radio)
View(radio)

#df = ("https://s3.amazonaws.com/assets.datacamp.com/blog_assets/scores_timed.csv", header = TRUE, quote="\"", stringsAsFactors= TRUE, strip.white = TRUE)

#importing a text file
y=read.table('test.txt')
y
z=read.table("test.txt", header = T) #if marked true, first line is 
z

#importing an excel file
#install.packages('xlsx')
library(xlsx)
excel= read.xlsx('test1.xlsx', sheetIndex= 1)
excel


efile= read.xlsx('test1.xlsx',sheetIndex= 1, sheetName = 'data_t')
efile1= read.xlsx('data_e.xlsx', 2)

#install.packages('gsheet')
library(gsheet)
url="https://docs.google.com/spreadsheets/d/1REqXqeHkc1pjkrldRu4LzcjCehSo0UbQnw826JLjc0o/edit#gid=0"
abc=as.data.frame(gsheet2tbl(url))
abc

#exporting the file to other formats
data()
?write.csv

#already created a data with file name abc through gsheet; now exporting the file
write.csv(abc, file= "y")
abc

#write.csv(x=mtcars, file='data/mtcars1.csv')
#write.csv(x=mtcars, file='data/mtcars2.csv', row.names = F)
#save it data folder all csv files
