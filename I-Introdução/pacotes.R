###################################
### INSTALAÇÃO DE PACOTES COM R ###
###################################

# O R possui pacotes básicos já baixados e carregados.
# Possui os pacotes recomendados, que só necessitam serem carregados.
# Também contribuídos, que podem ser baixados e carregados.

install.packages("argo")

?argo

# Carregar pacotes
library(argo)

# Baixar pacotes, caso eles ainda não tenham sido baixados
if(!require(argo)) install.packages("argo")

# Remover Pacotes
remove.packages("argo")
