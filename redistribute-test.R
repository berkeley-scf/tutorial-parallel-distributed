library(pbdDMAT, quiet = TRUE)
init.grid()

data = matrix(2*comm.rank()+1, nrow = 10, ncol = 2)  
data[,2] <- 2*comm.rank()+2
data[10,2] <- rnorm(1)

dx <- ddmatrix ( data = data, nrow = 10, ncol = 10, bldim = c(10, 2), ICTXT = 1)
dx2 <- redistribute(dx, bldim = c(2, 2), ICTXT = 0)

# matrix should have all 1s in first column, all 2s in second, all 3s in third, etc, but with the last row for the 2nd, 4th, 6th, 8th, 10th columns having random normals

print(dx)
x <- as.matrix(dx)
comm.print(x)
print(dx2)
x2 <- as.matrix(dx2)
comm.print(x2)

finalize()
