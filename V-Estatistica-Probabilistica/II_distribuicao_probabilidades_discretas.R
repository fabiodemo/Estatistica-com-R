##################################################
##### DISTRIBIÇÃO DE PROBABILIDADES DISCRETA #####
##################################################

if(!require(dplyr)) install.packages("dplyr")
library(dplyr)

getwd()
setwd('V-Estatistica-Probabilistica')

enem2019_tratado <- read.csv('enem_sp_2019.csv', sep=',')
enem2019_tratado <- na.omit(enem2019_tratado)
