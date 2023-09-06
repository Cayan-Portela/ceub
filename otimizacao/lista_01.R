# pacotes ----------------------------------------------------------------------
library(dplyr)
library(ggplot2)

# lendo dados ------------------------------------------------------------------
dados <- read.csv2(
    'https://raw.githubusercontent.com/Cayan-Portela/ceub/main/dados/insurance_treino.csv'
    )
n_ <- nrow(dados)

head(dados)

mod <- lm(charges ~ age + sex + children + smoker, data=dados)

mod$coefficients

summary(mod)

ggplot(data = dados) +
    geom_histogram(aes(x=charges))


ggplot(data = dados) +
    geom_point(aes(x=age, y=charges, col=region))

###############################

source("otimizacao/funcoes.R")
table(dados$smoker)
dados <- dados %>%
    mutate(
        sex_dummy = ifelse(sex == "male", 1, 0),
        smoker_dummy = ifelse(smoker == "yes", 1, 0) 
    )

# definndo X e Y ---------------------------------------------------------------
X_mat <- matriz_x(colunas = c("age", "sex_dummy", "children", "smoker_dummy"), dados=dados)
X_mat[1:6,]
y <- dados$charges

# definindo X' e X'X -----------------------------------------------------------
Xl <- t(X_mat)
Xlx <- Xl %*% X_mat

# gradient ---------------------------------------------------------------------
grad_ <- function(X, y, beta) {
     t(X) %*% (X %*% beta - y) / length(y)
}

beta_ <- list()
beta_[[1]] <- matrix(c(0, 0, 0, 0, 0), nrow=5)
lr <- 0.001
#i = 1
#
n_iter <- 200000
beta_history <- list(n_iter)
for (i in 1:n_iter){
    
    gradiente = grad_(X = X_mat, y = y, beta = beta_[[i]])
    beta_[[i+1]] <- beta_[[i]] - lr*gradiente

}

# simulacao --------------------------------------------------------------------
k <- 10000
x1 <- runif(k, -5, 5)
y1 <- 3 + x1 + rnorm(k) 

lm(y1 ~ x1)$coefficients

# add a column of 1's for the intercept coefficient
X <- cbind(1, matrix(x1))

n_iter <- 1000

beta_ <- list()
beta_[[1]] <- matrix(c(0, 0), nrow=2)
lr <- 0.01

for (i in 1:n_iter){
    
    gradiente = grad_(X = X, y = y1, beta = beta_[[i]])
    beta_[[i+1]] <- beta_[[i]] - lr*gradiente

}

beta_[[n_iter]]

plot(x1,y1, col=rgb(0.2,0.4,0.6,0.4), main='Linear regression by gradient descent')
for (i in c(1,3,6,10,14,seq(20,num_iters,by=10))) {
  abline(coef=beta_[[i]], col=rgb(0.8,0,0,0.3))
}
abline(coef=beta_[[n_iter]], col='blue')
