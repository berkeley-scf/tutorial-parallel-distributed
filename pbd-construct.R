## @knitr pbd-construct
library(pbdDMAT, quiet = TRUE)
init.grid()

nprocs <- comm.size()

nrows <- 10000
ncolsPerBlock <- nrows/nprocs

# each process has a block of columns as an R matrix
subdata <- matrix(rnorm(nrows * ncolsPerBlock), ncol = ncols)

# now construct the distributed matrix object
tmp <- ddmatrix(data = subdata, nrow = nrows, ncol = nrows,
               bldim = c(nrows, ncolsPerBlock), ICTXT = 1)
# now rearrange the blocks for better linear algebra performance
dx <- redistribute(tmp, bldim = c(100, 100), ICTXT = 0)

finalize ()
