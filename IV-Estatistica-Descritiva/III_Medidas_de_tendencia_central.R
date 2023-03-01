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
enem2019_tratado <- read.csv('enem_sp_2019.csv', sep=',')

# Média
mean(na.omit(enem2019_tratado$NU_NOTA_MT))

# Mediana
median(na.omit(enem2019_tratado$NU_NOTA_MT))

# Moda
# Criando uma função para a moda
moda <- function(v) {
    valor_unico <- unique(v) # Busca o valor único para a coluna valor
    valor_unico[which.max(tabulate(match(v,valor_unico)))] # tabular contabiliza quantas vezes o valor unico aparece e busca o maior valor 
}

# Obtendo a moda
resultado <- moda(na.omit(enem2019_tratado$NU_NOTA_MT))
print(resultado)

resultado <- moda(na.omit(enem2019_tratado$NU_NOTA_REDACAO))
print(resultado)


# Histograma
# Análise matemática
hist(na.omit(enem2019_tratado$NU_NOTA_MT), probability=T, col="blue")
lines(density(na.omit(enem2019_tratado$NU_NOTA_MT)), col="red")

hist(na.omit(enem2019_tratado$NU_NOTA_REDACAO), probability=T, col="blue")
lines(density(na.omit(enem2019_tratado$NU_NOTA_REDACAO)), col="red")

mean(na.omit(enem2019_tratado$NU_NOTA_REDACAO))
median(na.omit(enem2019_tratado$NU_NOTA_REDACAO))
moda(na.omit(enem2019_tratado$NU_NOTA_REDACAO))

