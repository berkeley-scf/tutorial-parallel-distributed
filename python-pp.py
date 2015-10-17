## @knitr python-pp

import numpy.random
import pp
import time
import pi_code # provided in pi_code.py

samples_per_slice = 10000000
num_slices = 24*20

# remember to start ppserver on worker nodes

# assume 'hosts' contains the names of the nodes on which you 
# started ppserver
nprocsPerNode = 2
hosts = ['smeagol', 'radagast', 'beren', 'arwen']
ppservers = hosts * nprocsPerNode

print ppservers
# put ncpus=0 here or it will start workers locally too
job_server = pp.Server(ncpus = 0, ppservers = tuple(ppservers), secret = 'mysecretphrase')

inputs = [(i, samples_per_slice) for i in xrange(num_slices)]

t0 = time.time()
jobs = [job_server.submit(pi_code.sample, invalue, modules = ('numpy.random',)) for invalue in inputs]
results = [job() for job in jobs]
t1 = time.time()

print "Pi is roughly %f" % (4.0 * sum(results) / (num_slices*samples_per_slice))
print "Time elapsed: ", t1 - t0

