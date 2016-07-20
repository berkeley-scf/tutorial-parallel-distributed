## @knitr doSNOW

library(doSNOW)
machines = c(rep("beren.berkeley.edu", 1),
    rep("gandalf.berkeley.edu", 1),
    rep("arwen.berkeley.edu", 2))

cl = makeCluster(machines, type = "SOCK")
cl

registerDoSNOW(cl)

fun = function(i)
  out = mean(rnorm(n))

nTasks <- 120

print(system.time(out <- foreach(i = 1:nTasks) %dopar% {
	outSub <- fun()
	outSub # this will become part of the out object
}))

stopCluster(cl)  # good practice, but not strictly necessary
