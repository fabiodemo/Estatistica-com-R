###################################
##### TESTE t PARA DUAS AMOSTRAS INDEPENDENTES #####
###################################

if(!require(dplyr)) install.packages("dplyr")
deps <- c("ade4", "car", "cramer", "dunn.test", "FactoMineR", 
       "lme4", "mixOmics", "multcompView", "pls", "pspearman",
       "statmod", "vegan")
install.packages(deps)
if(!require(RVAideMemoire)) install.packages("RVAideMemoire", dependencies=TRUE)
if(!require(car)) install.packages("car")
library(dplyr)
library(RVAideMemoire) # Teste Shapiro por grupo
library(car) # Teste de homogeneidade (Levene)

getwd()
setwd('V-Estatistica-Probabilistica')

enem2019_tratado <- read.csv('enem_sp_2019_tratado.csv', sep=',', encoding = "UTF-8")
enem2019_tratado <- na.omit(enem2019_tratado)

# Objetivo:
# Analisar a diferença entre as notas de homens e mulheres de um colégio

# Criando o dataframe de interesse
colegioy <- enem2019_tratado %>% filter(CO_ESCOLA == "35151506")
str(colegioy)

# NORMALIDADE
# Nível de significância (alfa): 0.05
# Ho = distribuição normal: p > 0.05
# Ha = distribuição != normal: p <= 0.05

byf.shapiro(NOTA_CN ~ TP_SEXO, colegioy)
byf.shapiro(NOTA_CH ~ TP_SEXO, colegioy)
byf.shapiro(NOTA_LC ~ TP_SEXO, colegioy)
byf.shapiro(NOTA_MT ~ TP_SEXO, colegioy)
byf.shapiro(NOTA_REDACAO ~ TP_SEXO, colegioy)
# A nota de linguagens e códigos (LC) nào passou no teste de normalidade, então ela deveria passar por testes não paramétricos.

# HOMOGENEIDADE DAS VARIÂNCIAS (HOMOCEDASTICIDADE)
# Variabilidade dos erros constante.
# Ho = variâncias homogêneas: p > 0.05
# Ha = variâncias não homogêneas: p <= 0.05
leveneTest(NOTA_CN ~ TP_SEXO, colegioy, center=mean)
leveneTest(NOTA_CH ~ TP_SEXO, colegioy, center=mean)
leveneTest(NOTA_MT ~ TP_SEXO, colegioy, center=mean)
leveneTest(NOTA_REDACAO ~ TP_SEXO, colegioy, center=mean)

# TESTE t PARA AMOSTRAS INDEPENDENTES
# Ho = NÃO HÁ DIFERENÇA ENTRE AS NOTAS: p > 0.05
# Ho = HÁ DIFERENÇA ENTRE AS NOTAS: p <= 0.05
# Default é bicaudal
# Para teste sunicaudal deve colocar: alternative="greater" ou alternative="less"

t.test(NOTA_CN ~ TP_SEXO, colegioy, var.equal=TRUE) # Variâncias são homogêneas, então usamos (var.equal=True)
t.test(NOTA_CH ~ TP_SEXO, colegioy, var.equal=TRUE)
t.test(NOTA_MT ~ TP_SEXO, colegioy, var.equal=TRUE)
t.test(NOTA_REDACAO ~ TP_SEXO, colegioy, var.equal=TRUE)

# Pelo teste t, num intervalo de confiança de 95%, há diferença entre as notas de Ciências Naturais, Ciências Humanas e Matemática entre homens e mulheres. Já na redação, não se pode afirmar que há diferençá entre as notas de homens e mulheres.

par(mfrow=c(1,4)) # Gráficos na mesma linha
boxplot(NOTA_CN ~ TP_SEXO, colegioy, ylab="nota de Ciências Naturais", xlab="Gênero")
boxplot(NOTA_CH ~ TP_SEXO, colegioy, ylab="nota de Ciências Naturais", xlab="Gênero")
boxplot(NOTA_MT ~ TP_SEXO, colegioy, ylab="nota de Ciências Naturais", xlab="Gênero")
boxplot(NOTA_REDACAO ~ TP_SEXO, colegioy, ylab="nota de Ciências Naturais", xlab="Gênero")
