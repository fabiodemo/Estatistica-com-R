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
enem2019_tratado <- na.omit(enem2019_tratado)
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
enem2019_tratado$nu_nota

# Todas as principais medidas juntas
summary(enem2019_tratado$NU_NOTA_MT)
summary(enem2019_tratado$NU_NOTA_MT[c('NU_NOTA_MT', 'NU_NOTA_CN', 'NU_NOTA_LT', 'NU_NOTA_CH', 'NU_NOTA_REDACAO')]) # indexação

# Comparando uma amostra com a população
nrow(enem2019_tratado)
amostra <- sample(c(0,1), 171286, replace=TRUE, prob=c(0.8,0.2))
summary(as.factor(amostra))
prop.table(table(amostra))

amostra_teste <- enem2019_tratado[amostra==1,]
dim(amostra_teste)

# Mẽdia
mean(enem2019_tratado$NU_NOTA_MT)
mean(amostra_teste$NU_NOTA_MT)

# Mediana
median(enem2019_tratado$NU_NOTA_MT)
median(amostra_teste$NU_NOTA_MT)

# Moda
# Criando uma função para a moda
moda <- function(v) {
    valor_unico <- unique(v) # Busca o valor único para a coluna valor
    valor_unico[which.max(tabulate(match(v,valor_unico)))] # tabular contabiliza quantas vezes o valor unico aparece e busca o maior valor 
}

moda(enem2019_tratado$NU_NOTA_MT)
moda(amostra_teste$NU_NOTA_MT)

# Geral
summary(enem2019_tratado$NU_NOTA_MT)
summary(amostra_teste$NU_NOTA_MT)