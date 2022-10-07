###########################
##  ABERTURA DO ARQUIVO  ##
###########################


# Instalação dos pacotes
# Se não estiver instalado
#--------------------
if(!require(data.table)){install.packages('data.table')}
if(!require(dplyr)) install.packages("dplyr")
if(!require(dplyr)) install.packages("tidyverse")

# Carregamento do pacote
library (data.table)
library(dplyr)
library(tidyverse)


# Alocação de memória
#---------------
memory.limit(24576)
#------------------

# FORNECENDO DIRETÓRIO DO ARQUIVO
# setwd("C:/Users/Luciano/Desktop/Curso_estatistica_R")
setwd("II-Estruturação/dados")
getwd()

# Carga dos microdados

ENEM_2019 <- data.table::fread(input='MICRODADOS_ENEM_2019.csv',
                               integer64='character',
                               skip=0,  #Ler do inicio
                               nrow=-1, #Ler todos os registros
                               na.strings = " ", 
                               showProgress = TRUE)
str(ENEM_2019)
# Filtrando apenas os dados do Rio Grande do Sul
enem_2019 <- ENEM_2019 %>% filter(SG_UF_RESIDENCIA =="MT" | SG_UF_RESIDENCIA =="SP" | SG_UF_RESIDENCIA =="MG" )

# Selecionando as colunas de interesse
enem_2019 <- select(enem_2019, NU_INSCRICAO, NU_ANO, NO_MUNICIPIO_RESIDENCIA,
                       SG_UF_RESIDENCIA, NU_IDADE, TP_SEXO, TP_ESTADO_CIVIL, TP_COR_RACA,
                       TP_NACIONALIDADE, TP_ESCOLA, TP_ENSINO, IN_TREINEIRO, CO_ESCOLA,
                       TP_PRESENCA_CN, TP_PRESENCA_CH, TP_PRESENCA_LC, TP_PRESENCA_MT,
                       NU_NOTA_CN, NU_NOTA_CH, NU_NOTA_LC, NU_NOTA_MT, TP_LINGUA,
                       TP_STATUS_REDACAO, NU_NOTA_COMP1, NU_NOTA_COMP2, NU_NOTA_COMP3,
                       NU_NOTA_COMP4, NU_NOTA_COMP5, NU_NOTA_REDACAO)
View(enem_2019)

#EXPORTAR ARQUIVO
write.table(enem_2019, file ="enem_2019_multiplos_estados.csv", sep = ",")

# Carregamento dos dados
enem_2019 <- read.csv("enem_2019_multiplos_estados.csv")
enem_2019

# Visualização dos dados
View(enem_2019)

#Excluir uma coluna
enem_2019$NU_ANO <- NULL


# Vetor para excluir múltiplas colunas
excluir <- c("TP_ESTADO_CIVIL", "SG_UF_RESIDENCIA")
View(excluir)
excluir
# Excluir múltiplas colunas
enem_2019 <- enem_2019[ , !names(enem_2019) %in% excluir]

View(names(enem_2019))

# Renomear uma coluna - remover NU das colunas
enem_2019 <- rename(enem_2019, NOTA_COMP1 = NU_NOTA_COMP1)
# Renomear múltipla colunas
enem_2019 <- rename(enem_2019, NOTA_COMP2 = NU_NOTA_COMP2, NOTA_COMP3 = NU_NOTA_COMP3, NOTA_COMP4 = NU_NOTA_COMP4, NOTA_REDACAO = NU_NOTA_REDACAO, NOTA_CN = NU_NOTA_CN, NOTA_CH = NU_NOTA_CH, NOTA_LC = NU_NOTA_LC, NOTA_MT = NU_NOTA_MT)
View(enem_2019)

str(enem_2019)

# Transformando a variável Código escola em fator
enem_2019$CO_ESCOLA <- as.factor(enem_2019$CO_ESCOLA)

# Verificando valores ausentes
# NA Not Available
# NaN Not a Number
sapply(enem_2019, function(x) sum(is.na(x)))
sapply(enem_2019, function(x) sum(is.nan(x)))

# Filtrar treineiros -> pessoas que fazem a prova somente para treinar seus conhecimentos
treineiros <- enem_2019 %>% filter(IN_TREINEIRO==1)
length(treineiros)

# Separando somente os vestibulandos em um novo dataframe
vestibulandos <- enem_2019 %>% filter(IN_TREINEIRO==0)
vestibulandos

# Excluir coluna treineiros do dataframe de vestibulandos
vestibulandos$treineiros <- null

# Exportando o arquivo de treineiros
write.table(treineiros, file="treineiros.csv", sep=",")

# Criando uma coluna para classificar as presenças
vestibulandos["presenca"] <- vestibulandos$TP_PRESENCA_CN + vestibulandos$TP_PRESENCA_LC + vestibulandos$TP_PRESENCA_CH + vestibulandos$TP_PRESENCA_MT
vestibulandos

falta_2dias <- vestibulandos %>% filter(presenca==0) # Faltou em dois dias
falta_1dias <- vestibulandos %>% filter(presenca==2) # Faltou em um dia
desclas <- vestibulandos %>% filter(presenca==6) # Desclassificado em um dos dias
desclas_2vezes <- vestibulandos %>% filter(presenca==8) # Desclassificado em doidias

# Selecionando apenas os que compareceram nos dois dias
vestibulandos_presentes <- vestibulandos %>% filter(presenca==4)

# Verificando valores NA
sapply(vestibulandos_presentes, function(x) sum(is.na(x)))

# Excluindo valores NA
vestibulandos_presentes <- drop_na(vestibulandos_presentes, NOTA_MT)

sapply(vestibulandos_presentes, function(x) sum(is.na(x)))

# Verificando notas zeros
nota_zero <- vestibulandos_presentes %>% filter(NOTA_REDACAO==0)
nota_zero <- vestibulandos_presentes %>% filter(NOTA_COMP1==0)
nota_zero <- vestibulandos_presentes %>% filter(NOTA_COMP2==0)
nota_zero <- vestibulandos_presentes %>% filter(NOTA_COMP3==0)
nota_zero <- vestibulandos_presentes %>% filter(NOTA_COMP4==0)
nota_zero <- vestibulandos_presentes %>% filter(NU_NOTA_COMP5==0)

nota_zero <- vestibulandos_presentes %>% filter(NOTA_MT==0)
nota_zero <- vestibulandos_presentes %>% filter(NOTA_CH==0)
nota_zero <- vestibulandos_presentes %>% filter(NOTA_LC==0)
nota_zero <- vestibulandos_presentes %>% filter(NOTA_CN==0)


redacao_sem_prob <- vestibulandos_presentes %>% filter(TP_STATUS_REDACAO==1)

# Excluir arquivo tratado
vestibulandos_presentes$presenca <- NULL

# Exportar o arquivo tratado
write.table(vestibulandos_presentes, file="enem_2019_multiplos_estados_tratado.csv", sep=",")
