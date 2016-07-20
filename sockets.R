## @knitr sockets

library(parallel)

machines = c(rep("beren.berkeley.edu", 1),
    rep("gandalf.berkeley.edu", 1),
    rep("arwen.berkeley.edu", 2))
cl = makeCluster(machines)
cl

n = 1e7
clusterExport(cl, c('n'))

fun = function(i)
  out = mean(rnorm(n))
  
result <- parSapply(cl, 1:20, fun)

result[1:5]

stopCluster(cl) # not strictly necessary

