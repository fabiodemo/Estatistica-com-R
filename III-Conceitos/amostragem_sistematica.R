if(!require(dplyr)) install.packages("dplyr")
if(!require(sampling)) install.packages("dplyr")
if(!require(TeachingSampling)) install.packages("dplyr")

library(dplyr)
library(sampling)
library(TeachingSampling)

setwd("III-Conceitos/dados/")
# setwd("II-Estruturação/dados/")

enem_2019_tratado <- read.csv("enem_rs_2019_tratado.csv")
View(enem_2019_tratado)

set.seed(2)
amostra <- S.SY(1199,100)
amostra
