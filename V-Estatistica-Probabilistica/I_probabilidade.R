#########################
##### PROBABILIDADE #####
#########################

if(!require(dplyr)) install.packages("dplyr")
library(dplyr)

getwd()
setwd('V-Estatistica-Probabilistica')

enem2019_tratado <- read.csv('enem_sp_2019.csv', sep=',')
enem2019_tratado <- na.omit(enem2019_tratado)

enem_guarulhos <- enem2019_tratado %>% filter(NO_MUNICIPIO_RESIDENCIA=="Guarulhos")
enem_campinas <- enem2019_tratado %>% filter(NO_MUNICIPIO_RESIDENCIA=="Campinas")

# Criando a função probabilidade
probab <- function(a, e) {
    resultado = (a / e) * 100
    print(resultado, digits = 3) 
}

# Probabilidade de retirar um vestibulando de Guarulhos
probab(nrow(enem_guarulhos), nrow(enem2019_tratado))

# Probabilidade de retirar um vestibulando de Campinas
probab(nrow(enem_campinas), nrow(enem2019_tratado))


# Criando a função probabilidade de NÃO OCORRER O EVENTO
prob_negativa <- function(a, e) {
    resultado = (1 - (a / e)) * 100
    print(resultado, digits = 3) 
}

# Probabilidade de NÃO retirar um vestibulando de Guarulhos
prob_negativa(nrow(enem_guarulhos), nrow(enem2019_tratado))

# Probabilidade de NÃO retirar um vestibulando de Campinas
prob_negativa(nrow(enem_campinas), nrow(enem2019_tratado))


# Criando a função probabilidade de UNIÃO MUTUAMENTE EXCLUSIVA (AuB)
prob_uniao <- function(a, b, e) {
    resultado = (a/e + b/e) * 100
    print(resultado, digits = 3) 
}

# Probabilidade de NÃO retirar um vestibulando de Guarulhos
prob_uniao(nrow(enem_guarulhos), nrow(enem_campinas), nrow(enem2019_tratado))


# Criando a função probabilidade de INTERSECÇÃO DE DOIS EVENTOS
prob_intersec <- function(a, b, e) {
    resultado = (a/e * b/e) * 100
    print(resultado, digits = 3) 
}

# Probabilidade de NÃO retirar um vestibulando de Guarulhos
prob_intersec(nrow(enem_guarulhos), nrow(enem_campinas), nrow(enem2019_tratado))


# Criando a função probabilidade CONDICIONAL
prob_cond <- function(ab, b) {
    resultado = (ab / b) * 100
    print(resultado, digits = 3) 
}

# Probabilidade condicional de retirar uma mulher parda
mulher <- enem2019_tratado %>% filter(TP_SEXO == "F")
mulher_parda <- mulher %>% filter(TP_COR_RACA == 3 )
mulher_parda

prob_cond(nrow(mulher_parda), nrow(enem2019_tratado))
