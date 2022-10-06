install.packages("dplyr")

# Carregamento da biblioteca
library(dplyr)

# Definir o diretório de trabalho
setwd("II-Estruturação/dados/")
getwd()

# Carregamento dos dados
enem_rs_2019 <- read.csv("enem_rs_2019.csv")
enem_rs_2019

# Visualização dos dados
View(enem_rs_2019)

#Excluir uma coluna
enem_rs_2019$NU_ANO <- NULL


# Vetor para excluir múltiplas colunas
excluir <- c("TP_ESTADO_CIVIL", "SG_UF_RESIDENCIA")
View(excluir)
excluir
# Excluir múltiplas colunas
enem_rs_2019 <- enem_rs_2019[ , !names(enem_rs_2019) %in% excluir]

View(names(enem_rs_2019))

# Renomear uma coluna - remover NU das colunas
enem_rs_2019 <- rename(enem_rs_2019, NOTA_COMP1 = NU_NOTA_COMP1)
# Renomear múltipla colunas
enem_rs_2019 <- rename(enem_rs_2019, NOTA_COMP2 = NU_NOTA_COMP2, NOTA_COMP3 = NU_NOTA_COMP3, NOTA_COMP4 = NU_NOTA_COMP4, NOTA_REDACAO = NU_NOTA_REDACAO, NOTA_CN = NU_NOTA_CN, NOTA_CH = NU_NOTA_CH, NOTA_LC = NU_NOTA_LC, NOTA_MT = NU_NOTA_MT)
View(enem_rs_2019)

# Verificação de tipagem dos atributos (Variáveis)
# 6 Tipos básicos:
# character
# integer
# numeric
# logical
# complex
# factor

str(enem_rs_2019)
#OU
glimpse(enem_rs_2019)

# Transformando a variável Código escola em fator
enem_rs_2019$CO_ESCOLA <- as.factor(enem_rs_2019$CO_ESCOLA)

# Verificando valores ausentes
# NA Not Available
# NaN Not a Number
sapply(enem_rs_2019, function(x) sum(is.na(x)))
sapply(enem_rs_2019, function(x) sum(is.nan(x)))

# Filtrar treineiros -> pessoas que fazem a prova somente para treinar seus conhecimentos
treineiros <- enem_rs_2019 %>% filter(IN_TREINEIRO==1)
length(treineiros)

# Separando somente os vestibulandos em um novo dataframe
vestibulandos <- enem_rs_2019 %>% filter(IN_TREINEIRO==0)
vestibulandos

# Excluir coluna treineiros do dataframe de vestibulandos
vestibulandos$treineiros <- null

# Exportando o arquivo de treineiros
write.table(treineiros, file="treineiros.csv", sep=",")
