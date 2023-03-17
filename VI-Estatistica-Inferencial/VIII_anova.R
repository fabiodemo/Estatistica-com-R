##############################
##### ANOVA DE UMA VIA #######
##############################

if(!require(dplyr)) install.packages("dplyr")
if(!require(rstatix)) install.packages("rstatix")
install.packages('DescTools',dependencies=TRUE, repos='https://cran.r-project.org/')

library(dplyr)
library(rstatix)
library(DescTool)


setwd('VI-Estatistica-Inferencial')

enem2019_tratado <- read.csv('enem_sp_2019_tratado.csv', sep=',', encoding = "UTF-8")

# Objetivo:
# ANALISAR SE HÁ DIFERENÇA DE NOTA COM RELAÇÃO A RAÇA

colegiox <- enem2019_tratado %>% filter (CO_ESCOLA=="35132287")
str(colegiox)

colegiox$NOTA_FINAL <- (colegiox$NOTA_CN + colegiox$NOTA_CH +
                          colegiox$NOTA_LC + colegiox$NOTA_MT +
                          colegiox$NOTA_REDACAO) / 5
str(colegiox)

# Alterando número de identificação pela raça
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==0] <- "Não definido"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==1] <- "Branca"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==2] <- "Preta"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==3] <- "Parda"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==4] <- "Amarela"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==5] <- "Indígena"
str(colegiox)

# Quantidades
branca = colegiox %>% filter(TP_COR_RACA=="Branca")
amarela = colegiox %>% filter(TP_COR_RACA=="Amarela")
preta = colegiox %>% filter(TP_COR_RACA=="Preta")
parda = colegiox %>% filter(TP_COR_RACA=="Parda")
indigena = colegiox %>% filter(TP_COR_RACA=="Indígena")
nd = colegiox %>% filter(TP_COR_RACA=="Não definido")

# VERIFICAÇÃO DOS PRESUPOSTOS 
teste_anova <- aov(NOTA_FINAL ~ TP_COR_RACA, colegiox)

# Teste de normalidade para os resíduos
shapiro.test(teste_anova$residuals)

# Verificação da presença de outliers enttre os resíduos
boxplot(teste_anova$residuals)

# TESTE ANOVA
# Ho = Média dos grupos são iguais: p > 0.05
# Ha = Há diferença entre pelo menos um dos grupos: p <= 0.05
teste_anova <- aov(NOTA_FINAL ~ TP_COR_RACA, colegiox)
summary(teste_anova)

# Análise post-hoc: verifica quais grupos são diferentes, se houver diferença
# Há mais de um tipo de teste, mais utilizados:

# post-hoc Duncan (mais flexível)
PostHocTest(teste_anova, method="duncan", conf.level=0.95)
# post-hoc TukeyHSD (regular)
PostHocTest(teste_anova, method="duncan", conf.level=0.95)
# post-hoc Bonferroni (mais conservador)
PostHocTest(teste_anova, method="duncan", conf.level=0.95)

# Conclusão:
# Nãoo há diferença entre as médias conforme a Cor/Raça, segundo teste anova 1 via.
# F(3) = 1.261 e p_valor = 0.291

##############################
##### ANOVA DE DUAS VIAS #####
##############################
if(!require(dplyr)) install.packages("dplyr")
if(!require(car)) install.packages("car")
if(!require(rstatix)) install.packages("rstatix")
install.packages('DescTools',dependencies=TRUE, repos='https://cran.r-project.org/')
if(!require(ggplot2)) install.packages("ggplot2")
if(!require(emmeans)) install.packages("emmeans")


library(dplyr)
library(car)
library(rstatix)
library(DescTool)
library(nortest)
library(ggplot2)

etwd('VI-Estatistica-Inferencial')

enem2019_tratado <- read.csv('enem_sp_2019_tratado.csv', sep=',', encoding = "UTF-8")

# Objetivo:
# ANALISAR DIFERENÇA ENTRE MÉDIAS POR GÊNERO E RAÇA

colegiox <- enem2019_tratado[which(enem2019_tratado$CO_ESCOLA=="35132287"),]

colegiox$NOTA_FINAL <- (colegiox$NOTA_CN + colegiox$NOTA_CH +
                          colegiox$NOTA_LC + colegiox$NOTA_MT +
                          colegiox$NOTA_REDACAO) / 5

colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==0] <- "NÃo definido"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==1] <- "Branca"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==2] <- "Preta"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==3] <- "Parda"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==4] <- "Amarela"
colegiox$TP_COR_RACA[colegiox$TP_COR_RACA==5] <- "Indígena"

boxplot(colegiox$NOTA_FINAL ~ colegiox$TP_SEXO:colegiox$TP_COR_RACA)

# Construção do modelo para obter os resíduos
teste_anova <- aov(NOTA_FINAL ~ TP_SEXO*TP_COR_RACA, colegiox)

# Teste de normalidade para os resíduos:
shapiro.test(teste_anova$residuals)

# Verificação da presença de outliers entre os resíduos
boxplot(teste_anova$residuals)

# Verificação da homogeneidade de variâncias - teste de Levene
colegiox$Residuos <- teste_anova$residuals
leveneTest(Residuos ~ TP_SEXO*TP_COR_RACA, colegiox, center = mean)

# TESTE ANOVA DUAS VIAS
# Ho = média dos grupos são iguais: p > 0.05
# Ha = Há diferença entre pelo menos um dos grupos: p <= 0.05
teste_anova <- aov(NOTA_FINAL ~ TP_SEXO*TP_COR_RACA, colegiox)
Anova(teste_anova, type = 'III') #tipo III soma dos quadrados não considera a ordem das variáveis

# Análise gráfica da relação entre as variáveis.
ggplot(colegiox, aes(x = TP_COR_RACA, y = NOTA_FINAL, group = TP_SEXO, color = TP_SEXO)) +
  geom_line(stat = "summary", fun.data = "mean_se", size = 0.6) +
  geom_point(stat = "summary", fun.y = "mean") +
  geom_errorbar(stat = "summary", fun.data = "mean_se", width = 0.2)

# Análise entre as variáveis (médias marginais)
colegiox %>% group_by(TP_COR_RACA) %>% 
  emmeans_test(NOTA_FINAL ~ TP_SEXO, p.adjust.method = "bonferroni")

# Post-hoc para Análise detalhada entre as variáveis
# TukeyHSD
PostHocTest(teste_anova, method = "hsd")

# CONCLUSÃO:
# Teste de anova duas vias não apontou diferença das médias das notas, com intervalo de confiançaa de 95%, com relação ao gênero e a raça.
# TP_SEXO: F(1) = 0.3250 e p = 0.56965    
# TP_COR_RACA: F(3) = 0.2205 e p = 0.882    
# TP_SEXO:TP_COR_RACA: F(3) = 2.4290 e p = 0.06858

