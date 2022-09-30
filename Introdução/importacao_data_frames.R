#####################################
###   IMPORTAÇÃO DE DATA FRAMES   ###
#####################################

setwd("Introdução/files")

# Arquivo txt

df1 <- read.table("partks.txt")
df1
View(df1)

# Leitura de csv

df2 <- read.csv("mola.csv")
View(df2)

df3 <- read.csv("questoes.csv")
View(df3)

df3 <- read.csv("questoes.csv", encoding= "latin-1")

df3 <- read.csv("questoes.csv", encoding= "iso-8859-1")

df3 <- read.csv("questoes.csv", encoding= "UTF-8")

# Arquivo Excel

install.packages("readxl")
library(readxl)

df4 <- read_excel("registro.xlsx")
df4
View(df4)