library(dplyr)
library(lavaan)
library(skimr)

data <- read.csv("StarWars.csv", sep =',')
head(data)
summary(data)
skim(data)
