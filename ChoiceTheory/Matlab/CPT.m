% Cumulative Prospect Theory function (CPT v2.0)
%% Introduction
% v1.0 is to tackle 2 outcomes in a prospect only
% v2.0 indicates an advanced version of CPT v1.0
% It is a generalised model for n outcomes in a prospect (so far I have
% tested with 3 outcomes in a prospect from exercise in week 5)
% Includes CPT, v and w function
% Derive the idea from the loop function in PS923 Assignment 3 (RFT)
% Combine probabilities and outcomes of a prospect in terms of VECTOR
%% Function
function sv = CPT2(p,X,alpha,gamma,lambda,beta,delta)
%% Create empty vectors for storing values
vp=zeros(1,size(X,2)); pp=zeros(1,size(X,2));
vn=zeros(1,size(X,2)); pn=zeros(1,size(X,2));
vpf=zeros(1,size(X,2)); vnf=zeros(1,size(X,2));
%% Pre-test checking
% Check if the length of outcomes and probabilites within a prospect are
% the same
% numel(X) = number of array elements in X
    if numel(X) ~= numel(p)
        disp('Outcomes and Probabilities must have the same length!')
    end
    
% Check if the sum of probabilites is equal to 1   
    if sum(p) ~= 1
        disp('Please revise your probability vector!')
    end
    
% Check if the outcomes are in an ascending order (using issorted(X))
    if issorted(X) == 0
        [X,idx]=sort(X);
        p=p(:,idx);
    end
%% For loop
    for m=1
        limit=size(X,2);
        while (m <= limit)
            if X(m) >= 0 
                vp(m) = X(m).^(alpha); % Value obtained when X(m)>=0
                pp(m) = w(sum(p(m:limit)),gamma) - w(sum(p(m+1:limit)),gamma); % Decision weights obtained
                vpf(m) = sum(vp(m).*pp(m)); % subjective value of a positive outcome
            else
                vn(m) = -lambda*(abs(X(m))).^(beta); % Value obtained when X(m)<0
                pn(m) = w(sum(p(1:m)),delta) - w(sum(p(1:m-1)),delta); % Decision weights obtained
                vnf(m)= sum(vn(m).*pn(m)); % subjective value of a negative outcome
            end
            m = m + 1;
            sv = sum(vpf)+sum(vnf); % subjective value after combining values of both positive and negative outcomes
        end
    end
end
%% Weighting function
% two inputs
% p = probabilities of outcomes within a prospect (vector)
% c = free parameter assigning weights according to p
% c = gamma when the outcome is positive
% c = delta when the outcome is negative
% weight = weight of a probability under weighting function
function weight = w(p,c)
weight= (p.^c) / ((p.^c+(1-p).^c)^(1/c));
end
%% Value function
% three inputs
% x = outcome within a prospect (vector)
% exp = parameter assigning a value according to x
% exp = alpha if x >= 0
% exp = beta if x < 0 
% lambda = parameter showing losses loom larger than gain (loss aversion)
function value=v(X,exp,lambda)
if X>=0
    value = X.^exp;
else
    value = -lambda(abs(X)).^exp;
end
end

