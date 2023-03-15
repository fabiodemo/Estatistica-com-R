###################################
##### TESTE Z PARA UM AMOSTRA #####
###################################

# CONDIÇÕES: DISTRIBUIÇÃO NORMAL E DESVIO PADRÃO POPULACIONAL CONHECIDO.

if(!require(dplyr)) install.packages("dplyr")
if(!require(nortest)) install.packages("nortest")
if(!require(BSDA)) install.packages("BSDA")
library(dplyr)
library(nortest)
library(BSDA)

getwd()
setwd('V-Estatistica-Probabilistica')

enem2019_tratado <- read.csv('enem_rs_2019_tratado.csv', sep=',')
enem2019_tratado <- na.omit(enem2019_tratado)
View(enem2019_tratado)


colegiox <- enem2019_tratado %>% filter(CO_ESCOLA=='43057004')
nrow(colegiox)

str(colegiox)

# Verificando valores missing
sapply(colegiox, function(x) sum(is.na(x)))
sapply(enem2019_tratado, function(x) sum(is.na(x)))

# TESTE DE NORMALIDADE
# Nível de significância (alfa): 0.05
# Ho = distribuição normal : p > 0.05
# Ha = distribuição != normal : p <= 0.05

# Ciências Naturais
# Shapiro-Wilk
shapiro.test(colegiox$NOTA_CN)
# Anderson-Darling
ad.test(colegiox$NOTA_CN)
# Lilliefors
lillie.test(colegiox$NOTA_CN)
# Cramer-Von Mises
cvm.test(colegiox$NOTA_CN)
# Histograma
hist(colegiox$NOTA_CN, probability=T, col='blue')
lines(density(colegiox$NOTA_CN), col='red')
# QQplot
qqnorm(colegiox$NOTA_CN)
qqline(colegiox$NOTA_CN)

# Média das notas do colégio X, comparada a média do estado de Rio Grande do Sul inteiro
# TESTE-Z
summary(enem2019_tratado$NOTA_CN)
sd(enem2019_tratado$NOTA_CN)
# Ho = Média é igual a do Rio Grande do Sul : p > 0.05
# Ha = Média é diferente a do Rio Grande do Sul : p <= 0.05

# TESTE Z BICAUDAL
z.test(colegiox$NOTA_CN, mu=485.4, sigma.x=72.05991, alternative="two.sided")

# INTERPRETAÇÃO
# Intervalo de confiança de 95%
# Teste estatístico z = -0.79285
# p_valor = 0.4279
# Conclusão: a média do colégio X é igual a média do estado do Rio Grande do Sul com 95% de confiança.

# Observação: média do colégio X
summary(colegiox$NOTA_CN)
summary(enem2019_tratado$NOTA_CN)

z.test(colegiox$NOTA_CN, mu=485.4, sigma.x=72.05991, alternative="less")
z.test(colegiox$NOTA_CN, mu=485.4, sigma.x=72.05991, alternative="greater")
