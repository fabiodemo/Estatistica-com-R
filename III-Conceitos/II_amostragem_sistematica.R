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

# Filtragem do dataframe
enem_poa <- enem_2019_tratado %>% filter (NO_MUNICIPIO_RESIDENCIA=="Porto Alegre")
enem_poa

# Amostragem Sistemática
set.seed(2)
amostra <- S.SY(35841, 200)
amostra
dim(amostra)

# Relacionando com o dataframe
amostra_poa_2 <- enem_poa[amostra, ]
View(amostra_poa_2)
