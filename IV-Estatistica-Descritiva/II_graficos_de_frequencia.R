###################################
##### GRÁFICOS DE FREQUÊNCIAS #####
###################################

if(!require(dplyr)) install.packages("dplyr")
if(!require(sampling)) install.packages("sampling")
if(!require(TeachingSampling)) install.packages("TeachingSampling")

library(dplyr)
library(sampling)
library(TeachingSampling)

getwd()
setwd('IV-Estatistica-Descritiva')
enem2019_tratado <- read.csv('enem_sp_2019.csv', sep=',')

enem_sorocaba <- enem2019_tratado %>% filter(NO_MUNICIPIO_RESIDENCIA=="Sorocaba")
