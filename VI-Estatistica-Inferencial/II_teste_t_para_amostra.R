###################################
##### TESTE t PARA UM AMOSTRA #####
###################################

# CONDIÇÕES: DISTRIBUIÇÃO NORMAL E NUMERO DE AMOSTRAS MENOR QUE 30.

if(!require(dplyr)) install.packages("dplyr")
if(!require(nortest)) install.packages("nortest")
if(!require(BSDA)) install.packages("BSDA")
library(dplyr)
library(nortest)
library(BSDA)

getwd()
setwd('V-Estatistica-Probabilistica')

enem2019_tratado <- read.csv('enem_sp_2019_tratado.csv', sep=',', encoding = "UTF-8")
enem2019_tratado <- na.omit(enem2019_tratado)
View(enem2019_tratado)
enem2019_tratado$NO_MUNICIPIO_RESIDENCIA

colegioy <- enem2019_tratado %>% filter(CO_ESCOLA == "35151506")
nrow(colegioy)

# NORMALIDADE
# Nível de significância (alfa): 0.05
# Ho = distribuição normal: p > 0.05
# Ha = distribuição != normal: p <= 0.05

# Ciências Humanas
# Shapiro-Wilk
shapiro.test(colegioy$NOTA_CH)
# Anderson-Darling
ad.test(colegioy$NOTA_CH)
# Lilliefors
lillie.test(colegioy$NOTA_CH)
# Cramer-Von Mises
cvm.test(colegioy$NOTA_CH)
# Histograma
hist(colegioy$NOTA_CH, probability=T, col='blue')
lines(density(colegioy$NOTA_CH), col='red')
# QQplot
qqnorm(colegioy$NOTA_CH)
qqline(colegioy$NOTA_CH)

# Teste-T
# Média das notas do colégio y, comaprada a médoa do estado de São Paulo
# Ho = média é igual a de São Paulo: p > 0.05
# Ha = média é diferente da de São Paulo: p <= 0.05
?t.test
summary(enem2019_tratado$NOTA_CH)

t.test(colegioy$NOTA_CH, mu=529.6, alternative="t")

# INTERPRETAÇÃO
# Intervalo de confiança de 95%
# Teste estatístico t(29) = 7.1821
# p_valor = 6.616e-08
# Conclusão: a média do colégio Y é diferente da média do estado de São Paulo com 95% de confiança.

# Observação média do colégio Y
summary(colegioy$NOTA_CH)

# Gráfico boxplot
# par(mfrow=c(2,1)) # 2 linhas 1 coluna
par(mfrow=c(1,2)) # 1 linha duas colunas
boxplot(colegioy$NOTA_CH, ylab="Nota de Ciências Humanas")
boxplot(enem2019_tratado$NOTA_CH, ylab="Nota de Ciências Humanas")
