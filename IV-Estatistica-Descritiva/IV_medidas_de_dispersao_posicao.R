########################################
##### MEDIDAS DE TENDÊNCIA CENTRAL #####
########################################

if(!require(dplyr)) install.packages("dplyr")
if(!require(sampling)) install.packages("sampling")
if(!require(TeachingSampling)) install.packages("TeachingSampling")

library(dplyr)
library(sampling)
library(TeachingSampling)

getwd()
setwd('IV-Estatistica-Descritiva')
enem2019_tratado <- na.omit(read.csv('enem_sp_2019.csv', sep=','))
enem2019_tratado

# Variância
var(enem2019_tratado)
var(enem2019_tratado$NU_NOTA_MT)

# Desvio Padrão
sd(enem2019_tratado$NU_NOTA_MT)

# Medidas de Posição
quantile(enem2019_tratado$NU_NOTA_MT)
IQR(enem2019_tratado$NU_NOTA_MT)
quantile(enem2019_tratado$NU_NOTA_MT, probs=c(0.05, 0.95))
quantile(enem2019_tratado$NU_NOTA_MT, seq(from=0, to=1, by=0.20))
diff(range(enem2019_tratado$NU_NOTA_MT)) # Amplitude

# Todas as principais medidas juntas