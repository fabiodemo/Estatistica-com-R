##############################
##### TESTE QUI QUADRADO #####
##############################

if(!require(dplyr)) install.packages("dplyr")

library(dplyr)

setwd('VI-Estatistica-Inferencial')

enem2019_tratado <- read.csv('enem_sp_2019_tratado.csv', sep=',', encoding = "UTF-8")
enem2019_tratado <- na.omit(enem2019_tratado)

# Objetivo:
# ANALISAR SE HÁ RELAÇÃO DO GÊNERO COM A ESCOLHA DO IDIOMA

proporcao <- as.data.frame(table(enem2019_tratado$TP_SEXO))
labels.prop<-c(round(((proporcao[,2])/sum(proporcao[,2]))*100,2))
labels.porcentagem <- paste(labels.prop, "%", sep=" ")
pie(x=c(proporcao[1,2],proporcao[2,2]), labels=labels.porcentagem, col=c("red", "blue"), main="Relaçãoo entre homens e mulheres")
legend("topright", pch=15, col=c("red","blue"), legend=c("Mulheres", "Homens"))

# Criação de uma tabela de contingência
tab <- table(enem2019_tratado$TP_SEXO, enem2019_tratado$TP_LINGUA)
tab

# Alternando as variáveis 0 por Inglês e 1 por Espanhol
enem2019_tratado$TP_LINGUA[enem2019_tratado$TP_LINGUA==0] <- "Inglês"
enem2019_tratado$TP_LINGUA[enem2019_tratado$TP_LINGUA==1] <- "Espanhol"

tab <- table(enem2019_tratado$TP_SEXO, enem2019_tratado$TP_LINGUA)
tab


# TESTE QUI-QUADRADO
# Ho = NÃO há associação entre o gênero e a escolha do idioma: p > 0.05
# Ha = HÁ associação entre o gênero e a escolha do idioma: p <= 0.05
teste_qui <- chisq.test(tab)
teste_qui


# Análise das frequências esperadas
teste_qui$expected # esperado
tab # o que ocorreu

# CONCLUSÃO:
# Há uma dependência entre a escolha do idioma com o gênero.
# Pelo teste qui-quadrado:
# p_valor < 2.2e-16
# X-squared(1) = 2041