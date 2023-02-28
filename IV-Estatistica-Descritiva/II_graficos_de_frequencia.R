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

# Histograma
hist(enem_sorocaba$NU_IDADE, col="red")

# Poligno de Frequência
plot(tabela_classes, type='p')
plot(tabela_classes, type='b')
plot(tabela_classes, type='o')

# Gráfico de Ogiva
# Frequência Acumulada
freq_rel_classes <- prop.table(table(cut(enem_sorocaba$NU_IDADE, breaks=c(intervalo_classes))))
View(freq_rel_classes)
freq_acum <- cumsum(tabela_classes)[seq_along(intervalo_classes)]
View(freq_acum)

# Gráfico de Ogiva com Frequência Acumulada
plot(intervalo_classes, freq_acum, type='o')
