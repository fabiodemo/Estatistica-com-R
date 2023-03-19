###############################
##### Teste de Kruskal-Wallis #######
###############################

# Teste não paramétrico para mais de duas amostras (similar ao Anova)

if(!require(dplyr)) install.packages("dplyr")
if(!require(rstatix)) install.packages("rstatix")
if(!require(DescTools)) install.packages("DescTools")

library(dplyr)
library(rstatix)
library(DescTools)
library(nortest)

setwd('VI-Estatistica-Inferencial')
getwd()

# OBJETIVO
# ANALISAR SE HÁ DIFERENÇA DE NOTA COM RELAÇÃO À RAÇA.

enem2019_tratado <- read.csv('./enem2019_tratado.csv', sep=',', encoding = "UTF-8")