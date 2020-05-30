#Handling packages in R
#What is a Package in R?
#Packages are collections of R functions, data, and compiled code in a well-defined format and developed by the community.

#for installing single package
install.packages('dplyr')

#for intslling multiple packages
install.packages(c('plotly','readr'))

#Function used to load single package is:
library(dplyr)

#Function used to load multiple package is:
#install.packages('pacman')
pacman::p_load(tidyr, lubridate)

require(dplyr)

#to view loaded packages
search()

#to unload a packages
detach("package:dplyr", unload = TRUE)

#remove installed packages
remove.packages("dplyr")

#updating all the existing installed packages
update.packages()

#updating selected packages
update.packages(oldPkgs = c('dplyr','lubridate'))