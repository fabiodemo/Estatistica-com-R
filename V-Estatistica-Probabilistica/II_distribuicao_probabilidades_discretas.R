##################################################
##### DISTRIBIÇÃO DE PROBABILIDADES DISCRETA #####
##################################################

if(!require(dplyr)) install.packages("dplyr")
library(dplyr)

getwd()
setwd('V-Estatistica-Probabilistica')

enem2019_tratado <- read.csv('enem_sp_2019.csv', sep=',')
enem2019_tratado <- na.omit(enem2019_tratado)

# Criando a função de probabilidade
probab <- function(a, e) {
    resultado = (a / e)
    print(resultado, digits = 3)
}

mulheres_enem <- enem2019_tratado %>% filter(TP_SEXO == "F")
p <- probab(nrow(mulheres_enem), nrow(enem2019_tratado))


# Distribuição Binominal
# dbinom = valor pontual    e   pbinom = faixa de valores
# Probabilidade de retirar exatamente 4 mulheres num total de 10 amostras
dbinom(4, 10, p) 
#dbinom(valor ou limite, tentativas, probabilidade de sucesso)

# Probabilidade de retiar pelo menos uma mulher num total de 10 amostras
p0 = 1 - dbinom(0, 10, p)
p0

# Probabilidade de retirar mais do que 1 mulher num total de 10 amostras
p1 = 1 - (dbinom(0, 10, p) + dbinom(1, 10, p))
p1

# Probabilidade de retirar mais do que 3 mulheres um total de 10 amostras
p2 = 1 - (dbinom(0, 10, p) + dbinom(1, 10, p) + dbinom(2, 10, p) + dbinom(3, 10, p))
p2
# Usando o pbinom
p3 = 1 - (pbinom(3, 10, p))
p3

# Probabilidade de retirar mais do que 8 mulheres num total de 10 amostras
p4 = dbinom(9, 10, p) + dbinom(10, 10, p)
p4
p5 = pbinom(10, 10, p) - pbinom(8, 10, p)
p5


# Distribuição Geomẽtrica
# Probaiblidade de retirar 4 amostras e nenhuma ser mulher
dgeom(3, p) 
#dgeom(numero de fracassos, probabilidade)


# Distribuição de Poisson
# Num local de prova, 100 vestibulandos, normalmente terminam a prova em 2h (tempo minimo) 
# Probabilidade de exatamente 90 vestibulandos terminarem a prova em 2h.
dpois(90, 100)
#dpois(quantidade de ocrrencias em estudo, taxa de ocorrencia)