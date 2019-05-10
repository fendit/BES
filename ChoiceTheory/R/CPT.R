# Materials (Options A and B)
# outcomes must be shown in decreasing order (vector)
x_A <-c(200, 22, 20) 
p_A <-c(0.9, 0.05, 0.05)
x_B <-c(200, 190, 20)
p_B <-c(0.85, 0.05, 0.1)

#Cumulative Prospect Theory (CPT)
alpha <- 0.88
gamma <- 0.65
lamda <- 2.25
beta <- 0.88
delta <- 0.69

# CPT function
# Weighting and value function
w <- function (p,c) {p^c / ((p^c+(1-p)^c)^(1/c))}
v <- function(x,a,lambda) ifelse(x >= 0,x^a,-lambda*abs(x)^a)

CPT <- function (p,X,alpha,gamma,lambda,beta,delta){
# Pre-test checking
if (length(X) != length(p)){ # Check if X and p have the same number of elements
	print('Outcomes and probabilities should have the same length!')
}
if (is.unsorted(X)) { # Check if the outcomes are sorted in an increasing order
  oo <- order(X)
  X <- X[oo]
  p <- p[oo]
	print('Outcomes are in an increasing order. Proceed to CPT calculation')
}
if (sum(p) != 1){ # Check if the sum of probabilities is added up to 1
	print('Sum of probabilities must be added up to 1!')
}
# Create empty vectors for storing outputs
pp <- {} # pp = positive pi
np <- {} # np = negative pi
vp <- {} # vp = value of an outcome in a positive prospect
vn <- {} # vn = value of an outcome in a negative prospect
vpf <- {} # vpf = value of a positive prospect
vnf <- {} # vnf = value of a negative prospect
sv <- {} # sv = subjective value of a prospect

	for (i in 1: length(X)){
			if (X[i]>=0){
					vp[i] <- v(X[i],alpha,lambda)
					if (i < length(X)){
						pp[i] <- w(sum(p[i:length(p)]),gamma) - w(sum(p[(i+1):length(p)]),gamma)
					}else{
					pp[length(p)] <- w(p[length(p)],gamma)
					}
					vpf[i] <- sum(vp[i]*pp[i])	
			}else {
					vn[i] <- v(X[i],beta,lambda)
					np[i] <- w(sum(p[1:i]),delta) - w(sum(p[0:(i-1)]),delta)
					vnf[i] <- sum(vn[i]*np[i])	
			}		
	}
	vpf <- sum(vpf,na.rm = TRUE)
	vnf <- sum(vnf,na.rm = TRUE)
	sv <- vpf + vnf
	return (sv)
}


# Calculation
CPT_A <- CPT(p_A,x_A,alpha,gamma,lambda,beta,delta)
CPT_B <- CPT(p_B,x_B,alpha,gamma,lambda,beta,delta)

# Decision
if (CPT_A > CPT_B){
	print('Option A is chosen')
}else{
	print('Option B is chosen')
	}
