# Funcoes utilizadas nos codigos em R

# cria matriz X ----------------------------------------------------------------
matriz_x <- function(colunas, dados) {
    col_1 <- matrix(1, nrow = n_)
    col_var <-  as.matrix(dados[colunas])
    X_mat <- cbind(col_1, col_var)

    return(X_mat)
}