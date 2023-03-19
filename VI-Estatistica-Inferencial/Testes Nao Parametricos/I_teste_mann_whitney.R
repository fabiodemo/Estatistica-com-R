###################################
##### Teste de Mann-Whitney #######
###################################

if(!require(dplyr)) install.packages("dplyr")
if(!require(rstatix)) install.packages("rstatix")
if(!require(RVAideMemoire)) install.packages('RVAideMemoire',dependencies=TRUE)

library(dplyr)
library(rstatix)
library(RVAideMemoire) # Teste Shapiro por grupo

setwd('VI-Estatistica-Inferencial')
getwd()

enem2019_tratado <- read.csv('./enem2019_tratado.csv', sep=',', encoding = "UTF-8")

# Criando o dataframe de interesse
enem_bauru <- enem2019_tratado[which(enem2019_tratado$NO_MUNICIPIO_RESIDENCIA=="Bauru"),]

# NORMALIDADE
# Ho = distribuição normal: p > 0.05
# Ha = distribuição != normal: p <= 0.05
byf.shapiro(NOTA_CN ~ TP_SEXO, enem_bauru)
byf.shapiro(NOTA_CH ~ TP_SEXO, enem_bauru)
byf.shapiro(NOTA_LC ~ TP_SEXO, enem_bauru)
byf.shapiro(NOTA_MT ~ TP_SEXO, enem_bauru)
byf.shapiro(NOTA_REDACAO ~ TP_SEXO, enem_bauru)
# Todos o p-values mostraram um valor <= 0.05, ou seja, todos os valores são diferentes da distribuição normal e portante o mais correto seria realizar testes não paramétricos

# TESTE DE MANN-WHITNEY (SOMA DE POSTOS WILCOXON)
# Ho = mediana entre homens e mulheres são iguais: p > 0.05
# Ha = mediana entre homens e mulheres são diferentes: p <= 0.05
wilcox.test(NOTA_CN ~ TP_SEXO, enem_bauru)
wilcox.test(NOTA_CH ~ TP_SEXO, enem_bauru)
wilcox.test(NOTA_LC ~ TP_SEXO, enem_bauru)
wilcox.test(NOTA_MT ~ TP_SEXO, enem_bauru)
wilcox.test(NOTA_REDACAO ~ TP_SEXO, enem_bauru)
# Nota de linguagens e Códigos foi > 0.05, ou seja, a mediana entre homens e mulheres são iguais

# ANÁLISE DESCRITIVA
enem_bauru %>% group_by(TP_SEXO) %>%
  get_summary_stats(NOTA_CN, NOTA_CH, NOTA_LC, NOTA_MT, NOTA_REDACAO, type="median_iqr")

par(mfrow=c(1,5))
boxplot(NOTA_CN ~ TP_SEXO, enem_bauru, ylab="Notas Ciências Naturais", xlab="Gênero")
boxplot(NOTA_CH ~ TP_SEXO, enem_bauru, ylab="Notas Ciências Humanas", xlab="Gênero")
boxplot(NOTA_LC ~ TP_SEXO, enem_bauru, ylab="Notas Linguanges e códigos", xlab="Gênero")
boxplot(NOTA_MT ~ TP_SEXO, enem_bauru, ylab="Notas Matemática", xlab="Gênero")
boxplot(NOTA_REDACAO ~ TP_SEXO, enem_bauru, ylab="Notas Redação", xlab="Gênero")

# CONCLUSÃO
# Pelo teste Mann-Whitney, somente as medianas/distribuições das notas de Linguagens e Códigos entre homens e mulheres são estatísticamente iguais, com w = 2079299 e p-value = 0.3169.