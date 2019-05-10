%% Options A and B (outcomes and probabilities are shown in vector)
x_A=[200 22 20];
p_A=[.9 .05 .05];
x_B=[200 190 20];
p_B=[.85 .05 .1];

%% Expected Utility Theory (EUT)
% Calculation
a = 0.63;
EU_A = EUT(x_A, p_A,a);
EU_B = EUT(x_B, p_B,a);

% Decision rule
if EU_A > EU_B
    disp('EUT: Option A')
else
    disp('EUT: Option B')
end

% Function
function EU = EUT(x, p, a)
X=x.^a;
EU = sum(X(:).*p(:));
end