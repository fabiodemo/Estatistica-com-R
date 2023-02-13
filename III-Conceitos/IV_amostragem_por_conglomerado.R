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

#### AMOSTRAGEM POR CONGLOMERADO (AGRUPAMENTO) ####
# A diferença é que no agrupamento, criamos os grupos e selecionamos alguns desses grupos para estudá-los, usando todos elementos selecionados.

# Amostragem em Porto Alegre
enem_poa <- enem_2019_tratado %>% filter(NO_MUNICIPIO_RESIDENCIA=="Porto Alegre")
# Filtrar por escola pública, identificada pelo código 2
escolas_publicas <- enem_poa %>% filter(TP_ESCOLA==2)
escolas_publicas
nrow(escolas_publicas)

# Size nesse caso, DEVERIA SER igual a 10% da quantia de escolas públicas, porém o R não deixou usar 10% e optou-se por utilizar 5.02%
set.seed(3)
amostra_poa <- cluster(escolas_publicas, clustername=c("CO_ESCOLA"), size=113, method="srswor")
amostra_poa
summary(as.factor(amostra_poa$CO_ESCOLA))

# Testando os resultados
teste <- enem_poa %>% filter(CO_ESCOLA==43105238)
View(teste)

teste2 <- enem_poa %>% filter(CO_ESCOLA==43105335)
View(teste2)
