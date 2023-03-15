###################################
##### TESTE t PARA DUAS AMOSTRAS INDEPENDENTES #####
###################################

if(!require(dplyr)) install.packages("dplyr")
if(!require(nortest)) install.packages("nortest")
if(!require(BSDA)) install.packages("BSDA")
library(dplyr)
library(nortest)
library(BSDA)

getwd()
setwd('V-Estatistica-Probabilistica')

enem2019_tratado <- read.csv('enem_sp_2019_tratado.csv', sep=',', encoding = "UTF-8")
enem2019_tratado <- na.omit(enem2019_tratado)
View(enem2019_tratado)
enem2019_tratado$NO_MUNICIPIO_RESIDENCIA