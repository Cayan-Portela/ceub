library(dplyr)
library(ggplot2)
# Modelo:
# y = b0 + b1*x + e
# y = 50 + 11*x + e

n = 100
set.seed(1234)
# variavel independente
x <- rgamma(n = n, shape = 100, rate = 300) * 200
# erro
erro <- rnorm(n = n, mean = 0, sd = 25)

b0 = 50; b1 = 11

y <- b0 + b1*x + erro

ggplot() +
    geom_point(x = x, y = y)
