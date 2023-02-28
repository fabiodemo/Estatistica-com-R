#######################################
##### DISTRIBUIÇÃO DE FREQUÊNCIAS #####
#######################################

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

# Tabela de Frequências Absolutas
freq_abs <- table(enem_sorocaba$NU_IDADE)
View(freq_abs)
freq_abs

# Tabela de Frequências Relativas
freq_rel <- prop.table(freq_abs)
View(freq_abs)

# Porcentagem de Frequência Relativas
p_freq_rel <- 100 * prop.table(freq_abs)
View(p_freq_rel)

# Criar uma linha com o total
freq_abs <- c(freq_abs, sum(freq_abs))
View(freq_abs)
names(freq_abs)[80] <- "Total"
View(freq_abs)

# Juntando a Frequência Relativa e a Frequência Percentual com suas respectivas somas
freq_rel <- c(freq_rel, sum(freq_rel))
p_freq_rel <- c(p_freq_rel, sum(p_freq_rel))

# Tabela final com todos os valores
tabela_final <- cbind(freq_abs, freq_rel=round(freq_rel, digits=5), p_freq_rel=round(p_freq_rel, digits=2))
View(tabela_final)

# Construindo classes de Frequências
intervalo_classes <- seq(10, 75, 5)
View(intervalo_classes)
tabela_classes <- table(cut(enem_sorocaba$NU_IDADE, breaks=intervalo_classes, right=FALSE))
View(tabela_classes)
