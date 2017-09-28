## @knitr pbd-apply

## you should have invoked R as:
## mpirun -machinefile .hosts -np 4 R CMD BATCH --no-save pbd-apply.R pbd-apply.out
## unless running within a SLURM job, in which case you should do:
## mpirun R CMD BATCH --no-save pbd-apply.R pbd-apply.out

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
