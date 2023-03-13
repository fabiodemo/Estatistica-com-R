###################################
##### TESTE Z PARA UM AMOSTRA #####
###################################

# CONDIÇÕES: DISTRIBUIÇÃO NORMAL E DESVIO PADRÃO POPULACIONAL CONHECIDO.

if(!require(dplyr)) install.packages("dplyr")
if(!require(nortest)) install.packages("nortest")
if(!require(BSDA)) install.packages("BSDA")
library(dplyr)
library(nortest)
library(BSDA)

getwd()
setwd('V-Estatistica-Probabilistica')

enem2019_tratado <- read.csv('enem_rs_2019_tratado.csv', sep=',')
enem2019_tratado <- na.omit(enem2019_tratado)

