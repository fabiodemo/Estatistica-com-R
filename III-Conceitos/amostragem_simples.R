if(!require(dplyr)) install.packages("dplyr")
if(!require(sampling)) install.packages("sampling")
if(!require(TeachingSampling)) install.packages("TeachingSampling")

library(dplyr)
library(sampling)
library(TeachingSampling)

setwd("III-Conceitos/dados/")
# setwd("II-Estruturação/dados/")

enem_2019_tratado <- read.csv("enem_rs_2019_tratado.csv")
View(enem_2019_tratado)

# Amostragem aleatório simples
enem_santamaria <- enem_2019_tratado %>% filter(NO_MUNICIPIO_RESIDENCIA=="Santa Maria")

# Criando amostrar aleatórias
set.seed(1) # Comando que permite não alterar a aleatoriedade da seed
amostra <- sample(c(0,1), 1199, replace=TRUE, prob=c(0.8,0.2))
summary(as.factor(amostra))
prop.table(table(amostra))

amostra_sm <- enem_santamaria[amostra==1,]
dim(amostra_sm)
