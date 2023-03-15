###########################
##### TESTE t pareado #####
###########################


library(dplyr)


getwd()
setwd('VI-Estatistica-Inferencial')

enem2019_tratado <- read.csv('enem_sp_2019_tratado.csv', sep=',', encoding = "UTF-8")
enem2019_tratado <- na.omit(enem2019_tratado)

# Objetivo:
# Analisar a diferença entre as médias das notas dos componentes da redação

# Criando o dataframe de interesse
colegioy <- enem2019_tratado %>% filter(CO_ESCOLA == "35151506")
str(colegioy)
nrow(colegioy)

# NORMALIDADE
# Usar a diferença entre as variáveis, que deverá ser normal
# Nível de significância (alfa): 0.05
# Ho = distribuição normal: p > 0.05
# Ha = distribuição != normal: p <= 0.05

colegioy$DiferencaNotas <- colegioy$NOTA_COMP1 - colegioy$NOTA_COMP2
shapiro.test(colegioy$DiferencaNotas)
colegioy$DiferencaNotas <- colegioy$NOTA_COMP1 - colegioy$NOTA_COMP3
shapiro.test(colegioy$DiferencaNotas)
colegioy$DiferencaNotas <- colegioy$NOTA_COMP1 - colegioy$NOTA_COMP4
shapiro.test(colegioy$DiferencaNotas)
colegioy$DiferencaNotas <- colegioy$NOTA_COMP1 - colegioy$NU_NOTA_COMP5

colegioy$DiferencaNotas <- colegioy$NOTA_COMP2 - colegioy$NOTA_COMP3
shapiro.test(colegioy$DiferencaNotas)
colegioy$DiferencaNotas <- colegioy$NOTA_COMP2 - colegioy$NOTA_COMP4
shapiro.test(colegioy$DiferencaNotas) # Normalidade detectada
colegioy$DiferencaNotas <- colegioy$NOTA_COMP2 - colegioy$NU_NOTA_COMP5
shapiro.test(colegioy$DiferencaNotas) # Normalidade detectada
colegioy$DiferencaNotas <- colegioy$NOTA_COMP3 - colegioy$NOTA_COMP4
shapiro.test(colegioy$DiferencaNotas)
colegioy$DiferencaNotas <- colegioy$NOTA_COMP3 - colegioy$NU_NOTA_COMP5
shapiro.test(colegioy$DiferencaNotas) # Normalidade detectada
colegioy$DiferencaNotas <- colegioy$NOTA_COMP4 - colegioy$NU_NOTA_COMP5
shapiro.test(colegioy$DiferencaNotas)

# AS COMBINAÇÕES QUE DERAM NORMALIDADE FORAM
# NOTA_COMP2 com NOTA_COMP4;
# NOTA_COMP2 com NU_NOTA_COMP5;
# NOTA_COMP3 com NU_NOTA_COMP5;

# TESTE T PAREADO
# Ho = NÃO HÁ DIFERENÇA ENTRE AS NOTAS: p > 0.05
# Ha = HÁ DIFERENÇA ENTRE AS NOTAS: p <= 0.05

t.test(colegioy$NOTA_COMP2, colegioy$NOTA_COMP4, paired=TRUE)
# Ho foi aceita, não há diferença entre as médias sendo o intervalo de confiança de 95%
# t (29) = -0.72351
# p-value = 0.4752
# Média de diferenças = -3.333333

t.test(colegioy$NOTA_COMP2, colegioy$NU_NOTA_COMP5, paired=TRUE)
# Ho foi aceita, não há diferença entre as médias sendo o intervalo de confiança de 95%
# t (29) = 0.8274
# p-value = 0.8274
# Média de diferenças = -1.333333

t.test(colegioy$NOTA_COMP3, colegioy$NU_NOTA_COMP5, paired=TRUE)
# Ho foi aceita, não há diferença entre as médias sendo o intervalo de confiança de 95%
# t (29) = -0.47186
# p-value = 0.6406
# Média de diferenças = -2.666667

# Análise pelo boxplot

par(mfrow=c(1,2))
boxplot(colegioy$NOTA_COMP2, ylab="NOTAS", xlab="COMPONENTE 2")
boxplot(colegioy$NOTA_COMP4, ylab="NOTAS", xlab="COMPONENTE 4")

par(mfrow=c(1,2))
boxplot(colegioy$NOTA_COMP2, ylab="NOTAS", xlab="COMPONENTE 2")
boxplot(colegioy$NU_NOTA_COMP5, ylab="NOTAS", xlab="COMPONENTE 5")

par(mfrow=c(1,2))
boxplot(colegioy$NOTA_COMP3, ylab="NOTAS", xlab="COMPONENTE 3")
boxplot(colegioy$NU_NOTA_COMP5, ylab="NOTAS", xlab="COMPONENTE 5")

# Medidas de centralidade e de posição
summary(colegioy[c('NOTA_COMP1', 'NOTA_COMP2', 'NOTA_COMP3', 'NOTA_COMP4', 'NU_NOTA_COMP5')])
