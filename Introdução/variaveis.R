###############################
###   OBJETOS (VARIÁVEIS)   ###
###############################

m <- 4 * 7
# ou
m = 4 * 7

print(m)
m

# NÃO usar palavras reservadas:
# break, else, for, function, IF, in, next, repeat, while, FALSE, Inf, 
# NA, NaN, NULL,TRUE ...
# NÃO colocar acentuações.


in <- 3 + 4

p <- 15 / 3
p

diferenca <- m - p
diferenca

a <- 2
b <- 4
c <- a * b
c <- a**b
c

### TIPO BÁSICO DO OBJETO (MODO)

# numeric: numérico
# integer: inteiro
# complex: número complexo
# character (string): caractere
# logical (boolean): lóicos (True e False)
# factor: categorias bem definidas. ex: gênero (masculino e feminino)
#                                       estado civil(casado, solteiro, vi�vo...)
#                                       ano (2019, 2020, 2021...)
y = 2
mode(y)
class(y)

y <- as.integer(y)
y
class(y)
mode(y)

x = 7.5
class(x)
x <- as.integer(x)
class(x)
x

complexo <- 2i
complexo

mode(complexo)
class(complexo)

caractere <- "palavra"
class(caractere)
mode(caractere)

logica <- "TRUE"
class(logica)

logica <- TRUE
class(logica)

genero <- c("masculino","feminino")
genero
class(genero)

genero <- as.factor(genero)
genero
class(genero)

### TIPO B�SICO DO OBJETO (Comprimento)
 
length(genero)

p <- 43
length(p)

q <- "bom dia" 
length(p)

