source("Envir.R")
require.i("rjags")

r <- read.csv("chu.csv", header = F)
data <- list(ns = 59, r = r, n = rowSums(r))

## Define initial values
## A list of lists, with each list representing a set of initial values
inits <- list(list(rho = -0.1, prec=c(1,1,1),
                   mu = c(0.5,0.5,0.5)),
              list(rho = -0.1, prec=c(0.5,0.5,0.5),
                   mu = c(1,1,1)))

## Compile model
model <- jags.model("chu_prev_random.txt", data=data, inits=inits, n.chains=2)

## Burn-in
set.seed(1234)
update(model, n.iter=50000, thin=10)

## Iteration
## variable.names specifies the parameters whose values are to be saved
samp.base <- coda.samples(model, variable.names=c("sens1","spec1","sens2","spec2","prev"), thin = 10, n.iter=100000)