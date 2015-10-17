## @knitr pbd-apply

# invoke as mpirun -machinefile .hosts -np 4 Rscript pbd-apply.R > pbd-apply.out

library(pbdMPI, quiet = TRUE )
init()

nrows <- 1e6

if(comm.rank()==0) {
    x <- matrix(rnorm(nrows*50), nrow = nrows)
}

sm <- comm.timer(out <- pbdApply(x, 1, mean, pbd.mode = 'mw', rank.source = 0))
if(comm.rank()==0) {
    print(out[1:5])
    print(sm)
}

finalize()
