%% Options A and B (outcomes and probabilities are shown in vector)
x_A=[200 22 20];
p_A=[.9 .05 .05];
x_B=[200 190 20];
p_B=[.85 .05 .1];

%% Expected Value Theory
% Calculation
EV_A = EVT(x_A, p_A);
EV_B = EVT(x_B, p_B);

% Decision rule
if EV_A > EV_B
    disp('EVT: Option A')
else
    disp('EVT: Option B')
end

% Function
function EV = EVT(x, p)
EV = sum(x(:).*p(:));
end