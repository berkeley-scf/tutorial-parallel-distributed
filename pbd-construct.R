## @knitr pbd-construct
library(pbdDMAT, quiet = TRUE)
init.grid()

nprocs <- comm.size()

nrows <- 10000
ncolsPerBlock <- nrows/nprocs

subdata <- matrix(rnorm(nrows * ncolsPerBlock), ncol = ncols)

tmp <- ddmatrix(data = subdata, nrow = nrows, ncol = nrows,
               bldim = c(nrows, ncolsPerBlock), ICTXT = 1)
dx <- redistribute(tmp, bldim = c(100, 100), ICTXT = 0)

print(tmp)
print(dx)

finalize ()
