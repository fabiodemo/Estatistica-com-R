#############################
##### CORRELAÇÃO LINEAR #####
#############################

if(!require(dplyr)) install.packages("dplr")
if(!require(corrplot)) install.packages("corrplot")
if(!require(car)) install.packages("car")
if(!require(corrplot)) install.packages("corrplot")
if(!require(ggplot2)) install.packages("ggplot2") # Gráfico com ajuste de reta
if(!require(ggpubr)) install.packages("ggpubr") # Equação da reta no gráfico


library(dplyr)
library(corrplot)
library(car)
library(corrplot)
library(ggplot2)
library(ggpubr)

setwd('VI-Estatistica-Inferencial')

enem2019_tratado <- read.csv('enem_sp_2019_tratado.csv', sep=',', encoding = "UTF-8")
enem2019_tratado <- na.omit(enem2019_tratado)

colegiox <- enem2019_tratado %>% filter(CO_ESCOLA == "35132287")
str(colegiox)
nrow(colegiox)

# Objetivo:

colegiox$NOTA_FINAL <- rowSums(colegiox[c('NOTA_CN', 'NOTA_CH', 'NOTA_LC', 'NOTA_MT', 'NOTA_REDACAO')])/ 5
colegiox$NOTA_FINAL

# ANALISE DA CORRELAÇÃO LINEAR

# DADOS NUMÉRICOS NORMALIZADOS: CORRELAÇÃO DE PEARSON

# 1o) ANÁLISE GRÁFICA DA CORRELAÇÃO
plot(colegiox$NOTA_MT, colegiox$NOTA_FINAL)
plot(colegiox$NOTA_CH, colegiox$NOTA_FINAL)
plot(colegiox$NOTA_CN, colegiox$NOTA_FINAL)
plot(colegiox$NOTA_LC, colegiox$NOTA_FINAL)
plot(colegiox$NOTA_REDACAO, colegiox$NOTA_FINAL)

# 2o) NORMALIDADE
# Ho = distribuição normal: p > 0.05
# Ha = distribuição != normal: p <= 0.05
shapiro.test(colegiox$NOTA_MT)
shapiro.test(colegiox$NOTA_LC)
shapiro.test(colegiox$NOTA_CH)
shapiro.test(colegiox$NOTA_CN)
shapiro.test(colegiox$NOTA_REDACAO) # Nota redação não passou no teste de normalidade
shapiro.test(colegiox$NOTA_FINAL) 

# 3o) ANÁLISE DE OUTLIERS
par(mfrow=c(1,5))
boxplot(colegiox$NOTA_MT, ylab="NOTAS", xlab="NOTA_MT")
boxplot(colegiox$NOTA_LC, ylab="NOTAS", xlab="NOTA_LC")
boxplot(colegiox$NOTA_CH, ylab="NOTAS", xlab="NOTA_CH")
boxplot(colegiox$NOTA_CN, ylab="NOTAS", xlab="NOTA_CN")
boxplot(colegiox$NOTA_FINAL, ylab="NOTAS", xlab="NOTA_FINAL") 

# MODELO DE REGRESSÃO LINEAR:
modelo_regressao_MT <- lm(NOTA_MT ~ NOTA_FINAL, colegiox)
# Análise gráfica:
plot(modelo_regressao_MT)
plot(modelo_regressao_MT, which=c(1,2))

modelo_regressao_LC <- lm(NOTA_LC ~ NOTA_FINAL, colegiox)
plot(modelo_regressao_LC, which=c(1,2)) # Outlier interferindo

modelo_regressao_CH <- lm(NOTA_CH ~ NOTA_FINAL, colegiox)
plot(modelo_regressao_CH, which=c(1,2))

modelo_regressao_CN <- lm(NOTA_CN ~ NOTA_FINAL, colegiox)
plot(modelo_regressao_CN, which=c(1,2))


# Correlação Linear de Pearson:
cor.test(colegiox$NOTA_MT, colegiox$NOTA_FINAL, method="pearson")
cor.test(colegiox$NOTA_LC, colegiox$NOTA_FINAL, method="pearson")
cor.test(colegiox$NOTA_CH, colegiox$NOTA_FINAL, method="pearson")
cor.test(colegiox$NOTA_CN, colegiox$NOTA_FINAL, method="pearson")

# Matrizes de correlação
# Alterando posição da coluna NOTA_FINAL
colegiox <- colegiox %>% relocate(NOTA_FINAL, .after=NOTA_MT)

matriz_corr <- cor(colegiox[15:19], method="pearson")
matriz_corr

corrplot(matriz_corr, method="color", type="full", order="original", addCoef.col="black", tl.srt=45)
