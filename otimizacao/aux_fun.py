import pandas as pd
import numpy as np
from numpy.linalg import inv

def matriz_x(colunas, dados):
    """Cria matriz de delineamento

    colunas: lista com nomes das colunas.
    dados: data.frame utilizado.
    """
    n_ = dados.shape[0]
    col_1 = np.ones(n_)
    col_var = dados[colunas]

    X_mat = np.c_[col_1, np.array(col_var)]

    return X_mat

def calcula_p(X, B):
    return np.exp(X @ B) / (1 + np.exp(X @ B))
    #return 1/(1+np.exp(X@B))

def beta_inicial(X):
    return np.zeros(X.shape[1])

def beta_update(X, W, y, p):
    return inv(X.T @ W  @  X) @ X.T @ (y-p)

def normaliza(x):
    return (x - np.mean(x)) / np.std(x)