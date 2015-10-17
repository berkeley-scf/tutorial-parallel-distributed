## @knitr sockets

library(parallel)

machines = c(rep("smeagol.berkeley.edu", 1),
    rep("gandalf.berkeley.edu", 1),
    rep("arwen.berkeley.edu", 2))
cl = makeCluster(machines)

n = 1e7
clusterExport(cl, c('n'))
fun = function(i)
  out = mean(rnorm(n))
  
result <- parSapply(cl, 1:20, fun)

stopCluster(cl) # not strictly necessary
