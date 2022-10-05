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
