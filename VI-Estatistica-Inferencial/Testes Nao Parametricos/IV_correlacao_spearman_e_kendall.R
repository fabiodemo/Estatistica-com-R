##############################################
##### Correlação de Spearman e Kendall #######
##############################################

# Teste de correlação não paramétricos

if(!require(dplyr)) install.packages("dplyr")
if(!require(corrplot)) install.packages("corrplot")
if(!require(ggplot2)) install.packages("ggplot2")
if(!require(ggpubr)) install.packages("ggpubr")

library(dplyr)
library(corrplot)
library(ggplot2)
library(ggpubr)

setwd('VI-Estatistica-Inferencial')
getwd()

# OBJETIVO
# ANALISAR SE HÁ DIFERENÇA DE NOTA COM RELAÇÃO À RAÇA.

enem2019_tratado <- read.csv('./enem2019_tratado.csv', sep=',', encoding = "UTF-8")

# OBJETIVO:
# Analisar a correlação linear entre as notas individuais com relação a nota final do Colégio X.

# Criando o dataframe de interesse
colegiox <- enem2019_tratado %>% filter(CO_ESCOLA == "35132287")
str(colegiox)

colegiox$NOTA_FINAL <- (colegiox$NOTA_CN + colegiox$NOTA_CH + colegiox$NOTA_MT + colegiox$NOTA_MT + colegiox$NOTA_REDACAO) / 5
str(colegiox)

# Análise de correlação linear

# 1o) ANÁLISE GRÁFICA DA CORRELAÇÃO
plot(colegiox$NOTA_MT, colegiox$NOTA_FINAL)
plot(colegiox$NOTA_LC, colegiox$NOTA_FINAL)
plot(colegiox$NOTA_CH, colegiox$NOTA_FINAL)
plot(colegiox$NOTA_CN, colegiox$NOTA_FINAL)
plot(colegiox$NOTA_REDACAO, colegiox$NOTA_FINAL)


# 2o) NORMALIDADE
# Ho = distribuição normal: p > 0.05
# Ha = distribuição != normal: p <= 0.05
shapiro.test(colegiox$NOTA_MT) # Usaria correlação de Pearson
shapiro.test(colegiox$NOTA_LC) # Usaria correlação de Pearson
shapiro.test(colegiox$NOTA_CH) # Usaria correlação de Pearson
shapiro.test(colegiox$NOTA_CN) # Usaria correlação de Pearson
shapiro.test(colegiox$NOTA_REDACAO) # única em que podemos usar correlação de Spearman/Kendall, pois é uma distribuição diferente de normal
shapiro.test(colegiox$NOTA_FINAL) # 


# CORRELAÇÃO DE SPEARMN
cor.test(colegiox$NOTA_REDACAO, colegiox$NOTA_FINAL, method="spearman")
# colegiox$NOTA_REDACAO tem muitos empates (valores repetidos), então isso gera um warning impedindo de calcular o p-value exato.
# Por causa disso, podemos usar a correlação de Kendall, já que ele se encaixa na situação:
# Para pequenas amostras (abaixo de 30 amostras) *OU* para quando temos muitos empates (caso atual).

# CORRELAÇÃO DE KENDALL
cor.test(colegiox$NOTA_REDACAO, colegiox$NOTA_FINAL, method="kendall")
#  correlação fraca: tau = 0.4089604 

# MATRIZES DE CORRELAÇÃO
matriz_corr <- cor(colegiox[25:26], method="kendall")
matriz_corr

corrplot(matriz_corr, method="color",
        type="full", order="original",
        addCoef.col="black",
        tl.col="black", tl.srt=45)

# CONCLUSÃO
# A correlação de Spearman, indicou uma correlação moderada.
# A correlação de Kendall indicou uma correlação fraca entre a Nota da Redação e a Nota Final.
# A correlação de Kendall é a mais adequada nesse específico caso.


# REGRESSÃO LINEAR
# Podemos realizar uma regressão linear, mas temos que ter em mente que a correlação é fraca (e por consequência poderá não ter resultados tão bons).

# Modelo de Regressão Linear
modelo_regressao_REDACACO <- lm(NOTA_REDACAO ~ NOTA_FINAL, colegiox)

# Análise do modelo de regressão
summary(modelo_regressao_REDACACO)
# Ho = coeficiente = 0: p > 0.05 (Modelo inválido)
# Ha = coeficiente != 0: p <= 0.05 (Modelo de Regressão válido, pois os coeficientes existem)

ggplot(data=colegiox, mapping=aes(x=NOTA_REDACAO, y=NOTA_FINAL)) +
    geom_point() +
    geom_smooth(method="lm", col="red") +
    stat_regline_equation(aes(label=paste(after_stat(eq.label), after_stat(adj.rr.label), sep = "*plain(\",\")~~")),
                        label.x = 0, label.y = 0) +
  theme_classic()
