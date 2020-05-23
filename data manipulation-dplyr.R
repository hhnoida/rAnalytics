#Data Manipulation----

# select() and rename() picks variables based on their names.
# filter() picks cases based on their values.
# summarise() reduces multiple values down to a single summary.
# mutate() adds new variables that are functions of existing variables
# arrange() changes the ordering of the rows.

vignette("dplyr")
library(dplyr)

#select function----
#select and rename function of dplyr
?select
#select() keeps only the variables you mention; 
#rename() keeps all variables.
#starts_with(), ends_with(), contains()

df = mtcars
# convert relevant cols to factor (can be ordered also)
factorcols = c('cyl','vs', 'am', 'gear', 'carb')

df[factorcols] = lapply(df[factorcols] ,factor, ordered=T)
sapply(df, class) #check the class these cols belong to
str(df)
abbreviate(rownames(df)) #abbreviate the carnames
names(df)
table(df$cyl)  #cylinder wise summary
table(df$am) #transmission wise

#combine it in single command 
sapply(df[factorcols],table)

select(df,mpg)
a = df %>% select(mpg)
a
b = mtcars %>% select(mpg, cyl, am)
head(b)

#rename : change column name and save it in same variable in order to update it in your records

#rename(newname = oldname)
b = b %>% rename(MPG = mpg)
head(b)
b = b %>% rename(CYL= cyl, AM = am)
head(b)

#summarise function ----- 
?summarise
df %>% summarise(Mmpg = mean(mpg))
df %>% summarise(disp = mean(disp),hp = mean(hp))
df %>% group_by(cyl) %>% summarise(meands = mean(disp), n = n()) #n() is the couont- here no. of cars
df %>% group_by(am) %>% summarise(meanmpg = mean(mpg), n = n())

#filter function -----
?filter
filter(df, cyl == 6) 
df %>% filter(carb>4)
df %>% filter(mpg > mean(mpg))
df %>% filter(cyl == 4, disp>90)
head(airquality)
airquality %>% filter(Temp > 70 & Month >5)
str(airquality)
range(mtcars$disp)

# mutate function ----
#Mutate is used to add new variables to the data.
?mutate
?airquality
head(airquality)
median(airquality$Temp) #temp is in degrees fahrenheit 
head(mutate(airquality, TempInC = (Temp - 32) * 5 / 9)) #adding column for temp in celsius
# formula to convert into celsius  = (32°F − 32) × 5/9 = 0°C

# arrange() ----- 
#changes the ordering of the rows.
#arrange(data, sorting command, group_by=,...)
?arrange

mtcars
df %>% arrange(desc(cyl))
df %>% group_by(cyl) %>% arrange((desc(mpg)))
arrange(df, cyl, desc(disp))#arrange the rows in the descending order of disp, and then in the ascending order of cyl
df %>% arrange(desc(wt))
arrange(airquality, desc(Month), Day) #arrange the rows in the descending order of Month, and then in the ascending order of Day.
