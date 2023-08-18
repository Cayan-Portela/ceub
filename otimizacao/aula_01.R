# pacotes ----------------------------------------------------------------------
library(dplyr)
#library(ggplot2)

# lendo dados ------------------------------------------------------------------
dados <- read.csv(
    'https://raw.githubusercontent.com/Cayan-Portela/ceub/main/dados/mtcars.csv'
    )
n_ <- nrow(dados)


# usando funcao lm() -----------------------------------------------------------
mod <- lm(mpg ~ wt, data=dados)
mod$coefficients

# cria matriz X ----------------------------------------------------------------
matriz_x <- function(colunas, dados) {
    col_1 <- matrix(1, nrow = n_)
    col_var <-  as.matrix(dados[colunas])
    X_mat <- cbind(col_1, col_var)

    return(X_mat)
}

# definndo X e Y ---------------------------------------------------------------
X_mat <- matriz_x(colunas = c("wt"), dados=dados)
y <- dados$mpg

# definindo X' e X'X -----------------------------------------------------------
Xl <- t(X_mat)
Xlx <- Xl %*% X_mat

# betas estimados --------------------------------------------------------------
betas_mat <- solve(Xlx) %*% Xl %*% y
betas_mat

# ------------------
# Decomposicao QR
# ------------------
QR <- qr(X_mat)
Q <- qr.Q(QR)
R <- qr.R(QR)
betas_qr <- backsolve(R, crossprod(Q, y))

# comparando betas -------------------------------------------------------------
mod$coefficients
betas_mat
betas_qr

