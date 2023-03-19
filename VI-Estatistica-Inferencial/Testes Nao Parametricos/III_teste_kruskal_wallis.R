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

enem2019_tratado$NOTA_FINAL <- (enem2019_tratado$NOTA_CN + enem2019_tratado$NOTA_CH +
                          enem2019_tratado$NOTA_LC + enem2019_tratado$NOTA_MT +
                          enem2019_tratado$NOTA_REDACAO) / 5
str(enem2019_tratado)
View(enem2019_tratado)

# Alterando número de identificação pela raça
enem2019_tratado$TP_COR_RACA[enem2019_tratado$TP_COR_RACA == 0] <- "Não definido"
enem2019_tratado$TP_COR_RACA[enem2019_tratado$TP_COR_RACA == 1] <- "Branca"
enem2019_tratado$TP_COR_RACA[enem2019_tratado$TP_COR_RACA == 2] <- "Preta"
enem2019_tratado$TP_COR_RACA[enem2019_tratado$TP_COR_RACA == 3] <- "Parda"
enem2019_tratado$TP_COR_RACA[enem2019_tratado$TP_COR_RACA == 4] <- "Amarela"
enem2019_tratado$TP_COR_RACA[enem2019_tratado$TP_COR_RACA == 5] <- "Indígena"
str(enem2019_tratado)

# Quantidades
branca = enem2019_tratado %>% filter(TP_COR_RACA == "Branca")
amarela = enem2019_tratado %>% filter(TP_COR_RACA == "Amarela")
preta = enem2019_tratado %>% filter(TP_COR_RACA == "Preta")
parda = enem2019_tratado %>% filter(TP_COR_RACA == "Parda")
indigena = enem2019_tratado %>% filter(TP_COR_RACA == "Indígena")
nd = enem2019_tratado %>% filter(TP_COR_RACA == "Não definido")

# VERIFICAÇÃO DOS PRESUPOSTOS
# Normalidade
# Ho = distribuição normal: p > 0.05
# Ha = distribuição != normal: p <= 0.05
# Construção do modelo para obter os resíduos:
teste_anova <- aov(NOTA_FINAL ~ TP_COR_RACA, enem2019_tratado)

# Teste de normalidade para os resíduos:
# Lilliefors (Kolmogorov-Smirnov)
lillie.test(teste_anova$residuals)

# Reprovado no teste de normalidade, terá que ser realizado um teste não paramétrico.
# Como são mais de duas variáveis independentes, então o teste usado será o Kruskal-Wallis

# TESTE de KRUSKAL-WALLIS
# Ho = mediana dos grupos são iguais: p > 0.05
# Ha = há diferença das medianas pelo menos em um dos grupos: p <= 0.05
kruskal.test(NOTA_FINAL ~ TP_COR_RACA, data = enem2019_tratado) # caiu na Ha com  p-value < 2.2e-16

# Teste de Pos-Hoc para verificar quais são as diferenças
# Teste de Dunn é o teste recomendado
dunn_test(NOTA_FINAL ~ TP_COR_RACA, data = enem2019_tratado, p.adjust.method="bonferroni")

# Análise descritiva
enem2019_tratado %>% group_by(TP_COR_RACA) %>% get_summary_stats(NOTA_FINAL, type="median_iqr")

# CONCLUSÃO:
# Pelo teste de Kruskkal-Wallis, as notas finais do Enem, estatisticamente: não são iguais por raça