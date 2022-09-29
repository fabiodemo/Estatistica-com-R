#####################################
### Estrutura de Dados - Matrizes ###
#####################################

# Conjunto de registros com linhas e colunas.
# Contendo somente números ou somente caracteres.

?matrix
?factor

matriz <- matrix(c(1,5,10,30,15,8), nrow=3, ncol=2, byrow=TRUE)
matriz

matriz <- matrix(c(4,8,12,16,20,24), nrow=3, ncol=2, byrow=FALSE)
matriz

matriz <- matrix(c(4,8,12,16,20,24), nrow=2, ncol=3, byrow=TRUE)
matriz

matriz[2,2]

vetorA <- c(2,3,5)
vetorB <- c(3,6,9)
matriz2 <- rbind(vetorA, vetorB)
matriz2

matriz2[2,1]

matriz3 <- matrix(2:9, ncol=2)

# Número de linhas e colunas.

dim(matriz3)
nrow(matriz3)
ncol(matriz3)

# Nomear linhas e colunas.

dimnames(matriz3) <- list(c("Linha1", "Linha2", "Linha3", "Linha4"),c("Coluna1", "Coluna2"))
matriz3

matriz4 <- matrix(2:13, nrow=4, byrow=TRUE, dimnames = list(c("Linha1", "Linha2", "Linha3", "Linha4"),c("Coluna1", "Coluna2", "Coluna3")))
matriz4
