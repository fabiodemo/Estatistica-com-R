###############################
##### Teste de Wilcoxon #######
###############################

# Duas amostras dependentes não paramétricas (similar ao teste t pareado paramétrico, porém Wilcoxon será não paramétrico)

if(!require(dplyr)) install.packages("dplyr")
if(!require(rstatix)) install.packages("rstatix")

library(dplyr)
library(rstatix)

setwd('VI-Estatistica-Inferencial')
getwd()

# OBJETIVO
# ANALISAR AS DIFERENÇÁS ENTRE AS MEDIANAS DAS NOTAS DOS COMPONENTES DA REDAÇÃO.

enem2019_tratado <- read.csv('./enem2019_tratado.csv', sep=',', encoding = "UTF-8")

colegioy <- enem2019_tratado %>% filter(CO_ESCOLA == "35151506")
str(colegioy)

# NORMALIDADE
# Nível de significância (alfa): 0.05
# Ho = distribuição normal: p > 0.05
# Ha = distribuição != normal: p <= 0.05

colegioy$DiferencaNotas  <- colegioy$NOTA_COMP1 - colegioy$NOTA_COMP2
shapiro.test(colegioy$DiferencaNotas)

colegioy$DiferencaNotas  <- colegioy$NOTA_COMP1 - colegioy$NOTA_COMP3
shapiro.test(colegioy$DiferencaNotas)

colegioy$DiferencaNotas  <- colegioy$NOTA_COMP1 - colegioy$NOTA_COMP4
shapiro.test(colegioy$DiferencaNotas)

colegioy$DiferencaNotas  <- colegioy$NOTA_COMP1 - colegioy$NOTA_COMP5
shapiro.test(colegioy$DiferencaNotas)

colegioy$DiferencaNotas  <- colegioy$NOTA_COMP2 - colegioy$NOTA_COMP3
shapiro.test(colegioy$DiferencaNotas)

colegioy$DiferencaNotas  <- colegioy$NOTA_COMP2 - colegioy$NOTA_COMP4
shapiro.test(colegioy$DiferencaNotas)

colegioy$DiferencaNotas  <- colegioy$NOTA_COMP2 - colegioy$NOTA_COMP5
shapiro.test(colegioy$DiferencaNotas)

colegioy$DiferencaNotas  <- colegioy$NOTA_COMP3 - colegioy$NOTA_COMP4
shapiro.test(colegioy$DiferencaNotas)

colegioy$DiferencaNotas  <- colegioy$NOTA_COMP3 - colegioy$NOTA_COMP5
shapiro.test(colegioy$DiferencaNotas)

colegioy$DiferencaNotas  <- colegioy$NOTA_COMP4 - colegioy$NOTA_COMP5
shapiro.test(colegioy$DiferencaNotas)

# As combinações reprovadas pelo teste de normalidade foram:
# NOTA_COMP1 com NOTA_COMP2;
# NOTA_COMP1 com NOTA_COMP3;
# NOTA_COMP1 com NOTA_COMP4;
# NOTA_COMP1 com NOTA_COMP5;
# NOTA_COMP2 com NOTA_COMP3;
# NOTA_COMP3 com NOTA_COMP4;
# NOTA_COMP4 com NOTA_COMP5.
# Faremos então o teste de Wilcoxon, já que elas serão não paramétricas.

# TESTE DE WILCOXON
# Ho = não há diferença nas medianas: p > 0.05
# Ha = existe diferença entre as medianas: p <= 0.05
wilcox.test(colegioy$NOTA_COMP1, colegioy$NOTA_COMP2, paired=TRUE)
wilcox.test(colegioy$NOTA_COMP1, colegioy$NOTA_COMP3, paired=TRUE)
wilcox.test(colegioy$NOTA_COMP1, colegioy$NOTA_COMP4, paired=TRUE)
wilcox.test(colegioy$NOTA_COMP1, colegioy$NOTA_COMP5, paired=TRUE)
wilcox.test(colegioy$NOTA_COMP2, colegioy$NOTA_COMP3, paired=TRUE)
wilcox.test(colegioy$NOTA_COMP3, colegioy$NOTA_COMP4, paired=TRUE)
wilcox.test(colegioy$NOTA_COMP4, colegioy$NOTA_COMP5, paired=TRUE)
# Todos os casos foram > 0.05, portanto foram aceitos.

# ANÁLISE PELO BOXPLOT
par(mfrow=c(1,5))
boxplot(colegioy$NOTA_COMP1, xlab="COMPONENTE 1")
boxplot(colegioy$NOTA_COMP2, xlab="COMPONENTE 2")
boxplot(colegioy$NOTA_COMP3, xlab="COMPONENTE 3")
boxplot(colegioy$NOTA_COMP4, xlab="COMPONENTE 4")
boxplot(colegioy$NOTA_COMP5, xlab="COMPONENTE 5")

summary(colegioy[c('NOTA_COMP1','NOTA_COMP2','NOTA_COMP3','NOTA_COMP4','NOTA_COMP5')])


# CONCLUSÃO
# Pelo teste de Wilcoxon, não há diferença entre as medidas das notas dos componentes da redação no Colégio Y