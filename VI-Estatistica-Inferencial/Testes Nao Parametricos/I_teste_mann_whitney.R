##############################
##### ANOVA DE UMA VIA #######
##############################

if(!require(dplyr)) install.packages("dplyr")
if(!require(rstatix)) install.packages("rstatix")
if(!require(RVAideMemoire)) install.packages('RVAideMemoire',dependencies=TRUE)

library(dplyr)
library(rstatix)
library(RVAideMemoire)

setwd('VI-Estatistica-Inferencial')
getwd()

enem2019_tratado <- read.csv('./enem2019_tratado.csv', sep=',', encoding = "UTF-8")

# Criando o dataframe de interesse
enem_bauru <- enem2019_tratado[which(enem2019_tratado$NO_MUNICIPIO_RESIDENCIA=="Bauru"),]

# Objetivo:
# ANALISAR SE HÁ DIFERENÇA DE NOTA COM RELAÇÃO A RAÇA
