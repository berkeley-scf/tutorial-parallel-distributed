## @knitr Rmpi

# example syntax of standard MPI functions

library(Rmpi)
# by default will start one fewer workers than processes
# saving one for the master
mpi.spawn.Rslaves()

n = 5
mpi.bcast.Robj2slave(n)
mpi.bcast.cmd(id <- mpi.comm.rank())
mpi.bcast.cmd(x <- rnorm(id))

mpi.remote.exec(ls(.GlobalEnv))

mpi.bcast.cmd(y <- 2 * x)
mpi.remote.exec(print(y))

objs <- as.list(c('x', 'n'))
# next command sends value of objs on _master_ as argument to rm
mpi.remote.exec(do.call, rm, objs)

# verify that 'n' is gone:
mpi.remote.exec(print(n))

# collect results back via send/recv
mpi.remote.exec(mpi.send.Robj(y, dest = 0, tag = 1))
results = list()
for(i in 1:(mpi.comm.size()-1)){
  results[[i]] = mpi.recv.Robj(source = i, tag = 1)
}
  
print(results)

mpi.close.Rslaves()
mpi.quit()
