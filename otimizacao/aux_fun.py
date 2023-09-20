import pandas as pd
import numpy as np


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