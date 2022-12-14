################################################
### Estrutura de Dados - Listas e Dataframes ###
################################################

### DATA FRAME ###
# É uma tabela de dados onde cada linha representa um registro e as colunas representam os atributos ou variáveis.
# Pode ter números e caracteres juntos (essa é a principal diferença com relação a matrizes).

mes_numero <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)

mes_nome <- c("janeiro", "fevereiro", "março", "abril", "maio", "junho", "julho",
              "agosto", "setembro", "outubro", "novembro", "dezembro")

ano <- c(2021, 2022, 2023, 2024, 2025, 2026, 2027, 2028, 2029, 2021, 2021, 2021)

data.frame(mes_numero, mes_nome, ano)

df <- data.frame(mes_numero, mes_nome, ano)
df

# Data Frames pertencentes ao R
df_cars <- mtcars
df_cars

df2 <- airquality
df2

?airquality
?mtcars
?datasets

library(help = "datasets")

df3 <- iris
iris

nrow(df3)
ncol(df3)
dim(df3)
summary(df3)

df3$Sepal.Length

### LISTAS ###
# Podem conter elementos de diferentes tipos (tipo especial de vetor)

nome <- c("Luciano", "Pedro", "Joyce", "Maria")
idade <- c(36, 38, 27, 29)
curso <- c("Estatística", "Linguagem R", "Redes Neurais", "Python")
lista <- list(nome, idade, curso)
lista

lista[1]
lista[2]
lista[3]
View(lista)

lista2 <- list(nome=c("Luciano", "Pedro", "Joyce", "Maria"),
                idade=c(36, 38, 27, 29),
                c("Estatística", "Linguagem R", "Redes Neurais", "Python"))
lista2
lista2[3]
lista2$nome
