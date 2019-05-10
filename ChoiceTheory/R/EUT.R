# Options A and B (outcomes and probabilities are shown in vector)
x_A <-c(200, 22, 20) 
p_A <-c(0.9, 0.05, 0.05)
x_B <-c(200, 190, 20)
p_B <-c(0.85, 0.05, 0.1)

# Expected Utility Theory (EUT)
# Function
EUT <- function(x,p,a){
	sum((x^a)*p)
}

# Calculation
a <- 0.63
EUT_A <- EUT(x_A,p_A,a)
EUT_B <- EUT(x_B,p_B,a)

# Decision rule
if (EUT_A > EUT_B){
	print('Option A is chosen')
}else{
	print('Option B is chosen')
	}