##############################
##### ANOVA DE UMA VIA #######
##############################

if(!require(dplyr)) install.packages("dplyr")
if(!require(rstatix)) install.packages("rstatix")

library(dplyr)
library(rstatix)

setwd('VI-Estatistica-Inferencial')
getwd()

enem2019_tratado <- read.csv('./enem2019_tratado.csv', sep=',', encoding = "UTF-8")

