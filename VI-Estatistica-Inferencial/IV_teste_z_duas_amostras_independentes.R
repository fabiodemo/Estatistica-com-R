###################################
##### TESTE Z PARA DUAS AMOSTRAS INDEPENDENTES #####
###################################

# Só é possível instalar, na versão atual do R, o pacote RVAideMemoire, caso sejam instaladas as seguintes dependências
deps <- c("ade4", "car", "cramer", "dunn.test", "FactoMineR", 
       "lme4", "mixOmics", "multcompView", "pls", "pspearman",
       "statmod", "vegan")
install.packages(deps)
install.packages("BiocManager") # https://www.bioconductor.org/packages/release/bioc/html/mixOmics.html
BiocManager::install("mixOmics", force=TRUE) # Dependência principal para o RVAideMemoire, só possível instalar pelo BiocManager


if(!require(RVAideMemoire)) install.packages("RVAideMemoire") 
if(!require(car)) install.packages("car")
if(!require(dplyr)) install.packages("dplyr")
library(dplyr)
library(RVAideMemoire) # Teste Shapiro por grupo
library(car) # Teste de homogeneidade (Levene)
library(BSDA)

getwd()
setwd('V-Estatistica-Probabilistica')

enem2019_tratado <- read.csv('enem_sp_2019_tratado.csv', sep=',', encoding = "UTF-8")
enem2019_tratado <- na.omit(enem2019_tratado)

# Objetivo:
# Analisar a diferença entre as notas de homens e mulheres de um colégio

# Criando o dataframe de interesse
colegiox <- enem2019_tratado %>% filter(CO_ESCOLA == "35132287")
str(colegiox)

# NORMALIDADE
# Nível de significância (alfa): 0.05
# Ho = distribuição normal: p > 0.05
# Ha = distribuição != normal: p <= 0.05

byf.shapiro(NOTA_CN ~ TP_SEXO, colegiox)
byf.shapiro(NOTA_CH ~ TP_SEXO, colegiox)
byf.shapiro(NOTA_LC ~ TP_SEXO, colegiox)
byf.shapiro(NOTA_MT ~ TP_SEXO, colegiox)
byf.shapiro(NOTA_REDACAO ~ TP_SEXO, colegiox)
# A nota de Redação não passou no teste de normalidade, então ela deveria passar por testes não paramétricos.

colegiox_mulher <- colegiox %>% filter(TP_SEXO=="F")
colegiox_homem <- colegiox %>% filter(TP_SEXO=="M")

# TESTE Z PARA AMOSTRAS INDEPENDENTES
# Ho = NÃO HÁ DIFERENÇA ENTRE AS NOTAS: p > 0.05
# Ho = HÁ DIFERENÇA ENTRE AS NOTAS: p <= 0.05

# Teste Z Ciências Naturais
sd(colegiox_mulher$NOTA_CN) # Desvio padrão mulher
sd(colegiox_homem$NOTA_CN) # Desvio padrão homen

# Teste Z bicaudal
z.test(colegiox_mulher$NOTA_CN, sigma.x = 59.09334, colegiox_homem$NOTA_CN, sigma.y = 57.74716, alternative="t")

# Teste Z Ciências Humanas
sd(colegiox_mulher$NOTA_CH) # Desvio padrão mulher
sd(colegiox_homem$NOTA_CH) # Desvio padrão homen

z.test(colegiox_mulher$NOTA_CH, sigma.x=sd(colegiox_mulher$NOTA_CH), colegiox_homem$NOTA_CH, sigma.y=sd(colegiox_homem$NOTA_CH))

# Teste Z Linguagens e Códigos
sd(colegiox_mulher$NOTA_LC) # Desvio padrão mulher
sd(colegiox_homem$NOTA_LC) # Desvio padrão homen

z.test(colegiox_mulher$NOTA_LC, sigma.x =sd(colegiox_mulher$NOTA_LC), colegiox_homem$NOTA_LC, sigma.y=sd(colegiox_homem$NOTA_LC))

# Teste Z Matemática
sd(colegiox_mulher$NOTA_MT) # Desvio padrão mulher
sd(colegiox_homem$NOTA_MT) # Desvio padrão homen

z.test(colegiox_mulher$NOTA_MT, sigma.x =sd(colegiox_mulher$NOTA_MT), colegiox_homem$NOTA_LC, sigma.y=sd(colegiox_homem$NOTA_MT))

# Pelo teste Z, num intervalo de confiança de 95%, não podemos afirmar que as notas de ciências humanas são diferentes entre homens e mulheres. Já matemática, ciências naturais e linguagens e códigos, apontam que há diferençá entre as notas de homens e mulheres.

par(mfrow=c(1,4)) # Gráficos na mesma linha
boxplot(NOTA_CN ~ TP_SEXO, colegiox, ylab="nota de Ciências Naturais", xlab="Gênero")
boxplot(NOTA_CH ~ TP_SEXO, colegiox, ylab="nota de Ciências Humanas", xlab="Gênero")
boxplot(NOTA_MT ~ TP_SEXO, colegiox, ylab="nota de Matemática", xlab="Gênero")
boxplot(NOTA_LC ~ TP_SEXO, colegiox, ylab="nota de Linguagens e Códigos", xlab="Gênero")
