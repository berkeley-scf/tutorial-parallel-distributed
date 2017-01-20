## @knitr mpi4py

from mpi4py import MPI
import numpy as np

comm = MPI.COMM_WORLD

# simple print out Rank & Size
id = comm.Get_rank()
print("Of ", comm.Get_size() , " workers, I am number " , id, ".")

def f(id, n):
    np.random.seed(id)
    return(np.mean(np.random.normal(0, 1, n)))

n = 1000000
result = f(id, n)


output = comm.gather(result, root = 0)

if id == 0:
    print(output)
