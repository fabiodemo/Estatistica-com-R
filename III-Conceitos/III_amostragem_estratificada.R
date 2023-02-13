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

#### AMOSTRAGEM ESTRATIFICADA ####
# Quando dividimos uma população em grupos e depois pegamos uma amostra de cada um desses grupos.

# Amostragem em Porto Alegre
enem_poa <- enem_2019_tratado %>% filter(NO_MUNICIPIO_RESIDENCIA=="Porto Alegre")
enem_poa

# Amostragem Estratificada por Raça em Porto Alegre 
summary(as.factor(enem_poa$TP_COR_RACA))
# Função da proporção da tabela
prop.table(table(enem_poa$TP_COR_RACA))

enem_poa$TP_COR_RACA[enem_poa$TP_COR_RACA==0] <- "Não definido"
enem_poa$TP_COR_RACA[enem_poa$TP_COR_RACA==1] <- "Branca"
enem_poa$TP_COR_RACA[enem_poa$TP_COR_RACA==2] <- "Preta"
enem_poa$TP_COR_RACA[enem_poa$TP_COR_RACA==3] <- "Parda"
enem_poa$TP_COR_RACA[enem_poa$TP_COR_RACA==4] <- "Amarela"
enem_poa$TP_COR_RACA[enem_poa$TP_COR_RACA==5] <- "Indígena"

summary(as.factor(enem_poa$TP_COR_RACA))
prop.table(table(enem_poa$TP_COR_RACA))

# Utilizando aproximadamente 10% de cada raça (estrato)
# CUIDADO COM A ORDEM! FAZER A ANÁLISE USANDO O COMANDO ABAIXO ANTES
ordem_amostras <- strata(data=enem_poa, stratanames=c("TP_COR_RACA"), size=c(1, 2, 3, 4, 5, 6), method="srswor")

summary(as.factor(ordem_amostras$TP_COR_RACA))
summary(as.factor(enem_poa$TP_COR_RACA))

amostra_poa_2 <- strata(data=enem_poa, stratanames=c("TP_COR_RACA"), size=c(110, 3, 594, 114, 16, 1), method="srswor")
View(amostra_poa_2)

# Sumário da quantia de valores em cada uma das raças que foram usadas na Amostragem Estratificada
summary(as.factor(amostra_poa_2$TP_COR_RACA))