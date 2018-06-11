## R for Excel Analysts
5 + 5

### Excel LEN function equivalent
nchar("John")

## Upper Cases
toupper("bhavesh")

## ggplot2 plotting
library(ggplot2)
qplot(x=mpg, y=wt, data =mtcars, colour = cyl)


## R Programming Basics
# Assigning Variables
a =5
b= 6
Total = a+b
Total
## Conditions
 # Equality : ==
 # Not Equal: !=
 # Greater/Less than: > or < 
 # Greater/Less than or equal to : >= or <=

# Does 8 equal 2?
 8 == 2
# Is 10 less than or equal to 15
 10 <= 15
# Does TRUE not equal TRUE?
 TRUE !=TRUE
 
 # General Data Analysis
 # What is the distribution of player's age?
 library(tidyverse)
 players =read_csv("Master.csv")
 glimpse(players)
 Batting = read_csv("Batting.csv")
 # Getting the first 5 rows and 6 columns
 players[1:5,1:6]
 Batting[1:5,1:10]
 