##############################################
##### Correlação de Spearman e Kendall #######
##############################################

# Teste de correlação não paramétricos

if(!require(dplyr)) install.packages("dplyr")
if(!require(corrplot)) install.packages("corrplot")
if(!require(ggplot2)) install.packages("ggplot2")
if(!require(ggpubr)) install.packages("ggpubr")

library(dplyr)
library(corrplot)
library(ggplot2)
library(ggpubr)

setwd('VI-Estatistica-Inferencial')
getwd()

# OBJETIVO
# ANALISAR SE HÁ DIFERENÇA DE NOTA COM RELAÇÃO À RAÇA.

enem2019_tratado <- read.csv('./enem2019_tratado.csv', sep=',', encoding = "UTF-8")
