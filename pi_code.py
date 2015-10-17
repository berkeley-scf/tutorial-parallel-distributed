import numpy.random

def sample(p, nSamples):
    numpy.random.seed(p)
    x, y = numpy.random.random(nSamples), numpy.random.random(nSamples)
    return numpy.sum(x*x + y*y < 1)
