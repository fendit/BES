## Transfer of Attention Exchange Model
# parameters
# gamma(g) = psychological function for probability
# beta(b) = utility (value) funcyion of monetary outcomes
# delta(d) = configural transfer of weight (which affects risk aversion/seeking )

## Functions
# Assign weight according to probabilities
t <- function (p,g) {p^g}
# Assign utilities according to outcomes
u <- function (x, b) {x^b}
# Weight shifting
# Weight shift is determined by the number of branches n
# probabilities will be a set of vectors (generalised)
w <- function(d,transfer,n) {
weight <- matrix(0,nrow=length(transfer),ncol=1)
	for (k in 1: n){
		weight[k] <- (d*transfer[k])/(n+1)
	}
	return(weight) # Must be included in order to save the calculated values
}
# TAX function
TAX <- function (utility,transfer,weight,n){
  if (d > 0){ 
    transfer[1] <- transfer[1] - (n-1)*weight[1]
    for (i in 2: length(weight)){
      transfer[i] <- transfer[i] + sum(weight[1:i-1]) - (n-i)*weight[i]
    }	
  }else{
    transfer[length(transfer)] <- transfer[length(transfer)] - (n-1)*weight[length(transfer)]
    for (k in 1: length(weight)-1){
      transfer[k] <- transfer[k] + sum(weight[1:k]) - (n-k)*weight[k]
    }
  }
  norm.transfer <- matrix(0,nrow=length(transfer),ncol=1) # matrix containing normalised weights
  for (j in 1: length(transfer)){ # Normalise weights
    norm.transfer[j] <- transfer[j]/sum(transfer)
  }
  sv <- sum(utility*norm.transfer) # sum of products
  return(sv) # Calculate TAX value
}

# General input
transfer <- t(p,g) # transfer (vector)
utility <- u(x,b) # utility (vector)
weight <- w(d,transfer,length(transfer)) # transfer the weight
TAX(utility,transfer,weight,length(transfer)) # TAX value (sv)

# Test 
x_A <- c(200,22,20) # Assume they are in decreasing order
p_A <- c(.9,.05,.05)
g <- 0.7
d <- 1
b <- 1
transfer.A <- t(p_A,g) # transfer (vector)
utility.A <- u(x_A,b) # utility (vector)
weight.A <- w(d,transfer.A,length(transfer.A)) # transfer the weight
TAX.A <- TAX(utility.A,transfer.A,weight.A,length(transfer.A)) # TAX value (sv)
# 91.72963

x_B <- c(200,190,20) # Assume they are in decreasing order
p_B <- c(.85,.05,.1)
g <- 0.7
d <- 1
b <- 1
transfer.B <- t(p_B,g) # transfer (vector)
utility.B <- u(x_B,b) # utility (vector)
weight.B <- w(d,transfer.B,length(transfer.B)) # transfer the weight
TAX.B <- TAX(utility.B,transfer.B,weight.B,length(transfer.B)) # TAX value (sv)
# 130.23219

