# Options A and B (outcomes and probabilities are shown in vector)
x_A <-c(200, 22, 20) 
p_A <-c(0.9, 0.05, 0.05)
x_B <-c(200, 190, 20)
p_B <-c(0.85, 0.05, 0.1)

# Expected Value Theory (EVT)
# Function
EVT <- function (x,p){
	sum(x*p)
}

# Calculation
EVT_A <- EVT(x_A,p_A)
EVT_B <- EVT(x_B,p_B)

# Decision rule
if (EVT_A > EVT_B){
	print('Option A is chosen')
}else{
	print('Option B is chosen')
	}