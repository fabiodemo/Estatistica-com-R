##################################################
##### DISTRIBIÇÃO DE PROBABILIDADES CONTÍNUA #####
##################################################

# TESTES DE NORMALIDADE - Se a distribuição é normal ou não
# Existem 4 principais testes de normalidade (numericos) e dois testes gráficos, sendo eles: 
    # Shapiro-Wilk (limite de 5000 amostras)
    # Anderson-Darling
    # Kolmogorov-Smirnov
    # Cramer-Von Mises
    # Histograma
    # QQplot

# Nível de significância de 0.05 a 5% (mais utilizado) quando p > 0.005 (distribuição normal)

if(!require(dplyr)) install.packages("dplyr")
if(!require(nortest)) install.packages("nortest")
library(dplyr)
library(nortest)

getwd()
setwd('V-Estatistica-Probabilistica')

enem2019_tratado <- read.csv('enem_sp_2019.csv', sep=',')
enem2019_tratado <- na.omit(enem2019_tratado)


# Utilizando Ciências Naturais para o teste
# Histograma
hist(enem2019_tratado$NU_NOTA_CN, probability=T, col="blue")
lines(density(enem2019_tratado$NU_NOTA_CN), col="red")

# QQplot (gráfico de distribuição normal)
qqnorm(enem2019_tratado$NU_NOTA_CN)
qqline(enem2019_tratado$NU_NOTA_CN)

# Shapiro-Wilk
shapiro.test(enem2019_tratado$NU_NOTA_CN) # Erro pelo tamanho do nosso dataset

# Anderson-Darling
ad.test(enem2019_tratado$NU_NOTA_CN)

# Kolmogorov-Smirnov
ks.test(enem2019_tratado$NU_NOTA_CN, pnorm)
lillie.test(enem2019_tratado$NU_NOTA_CN) # Utilizado no lugar do KS

# Cramer-Von Mises
cvm.test(enem2019_tratado$NU_NOTA_CN) # Não é uma dist. normal entao não calculará com essa forma


# Análise na cidade de Franca
enem_franca <- enem2019_tratado %>% filter(NO_MUNICIPIO_RESIDENCIA=="Franca")
nrow(enem_franca)
# Histograma
hist(enem_franca$NU_NOTA_CN, probability=T, col="blue")
lines(density(enem_franca$NU_NOTA_CN), col="red")

# QQplot (gráfico de distribuição normal)
qqnorm(enem_franca$NU_NOTA_CN)
qqline(enem_franca$NU_NOTA_CN)

# Shapiro-Wilk
shapiro.test(enem_franca$NU_NOTA_CN) # Erro pelo tamanho do nosso dataset

# Anderson-Darling
ad.test(enem_franca$NU_NOTA_CN)

# Kolmogorov-Smirnov
lillie.test(enem_franca$NU_NOTA_CN) # Utilizado no lugar do KS

# Cramer-Von Mises
cvm.test(enem_franca$NU_NOTA_CN) # Não é uma dist. normal entao não calculará com essa forma
