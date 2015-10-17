## @knitr mpi.parSapply

library(Rmpi)
mpi.spawn.Rslaves()

myfun <- function(i) {
      set.seed(i)
      mean(rnorm(1e7))
}

x <- seq_len(25)
system.time(out <- mpi.parSapply(x, myfun, job.num = length(x)))
system.time(out <- mpi.applyLB(x, myfun))

nrows <- 10000
x <- matrix(rnorm(nrows*50), nrow = nrows)
out <- mpi.parApply(x, 1, mean)

mpi.close.Rslaves()
mpi.quit()
