if(!require(dplyr)) install.packages("dplyr", dependencies=True)
if(!require(sampling)) install.packages("sampling",  dependencies=True)
if(!require(TeachingSampling)) install.packages("TeachingSampling", dependencies=True)

library(dplyr)
library(sampling)
library(magrittr)
library(TeachingSampling)

setwd("III-Conceitos/dados/")
# setwd("II-Estruturação/dados/")

enem_2019_tratado <- read.csv("enem_rs_2019_tratado.csv")
View(enem_2019_tratado)


enem_poa <- enem_2019_tratado %>% filter (NO_MUNICIPIO_RESIDENCIA=="Porto Alegre")
enem_poa

set.seed(2)
amostra <- S.SY(35841, 100)
amostra
