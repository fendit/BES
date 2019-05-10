% Transfer of Attention Exchange Model
% x = outcomes (vector, decreasing order)
% beta(b) = utility (value) funcyion of monetary outcomes
% p = probabilities (vector)
% gamma(g) = psychological function for probability
% delta(d) = configural transfer of weight (which affects risk aversion/seeking)

function sv=TAX(x,b,p,g,d)
transfer=p.^g; % Assign weight according to probabilities
utility=x.^b; % Assign utilities according to outcomes
n=size(transfer,2);
weight=zeros(1,size(transfer,2)); % Weight shifting
for k=1:n % Weight shift is determined by the number of branches n
    weight(k)=(d*transfer(k))/(n+1);
end

if d>0 % Risk averse; the lowest branch will be weighted more
    transfer(1)=transfer(1)-(n-1)*weight(1);
    for i = 2:size(weight,2)
        transfer(i)=transfer(i)+sum(weight(1:i-1))-(n-i)*weight(i);
    end
else % Risk seeking; the highest branch will be weighted more
    transfer(size(transfer,2))=transfer(size(transfer,2))-(n-1)*weight(size(transfer,2));
    for k = 1:size(transfer,2)-1
        transfer(k)=transfer(k)+sum(weight(1:k))-(n-k)*weight(k);
    end
end

norm_transfer=zeros(1,size(transfer,2)); % Matrix containing normalised weights
for j = 1:size(transfer,2)
    norm_transfer(j)=transfer(j)/sum(transfer); % Normalise weights
end

sv=sum(utility(:).*norm_transfer(:)); % Calculate TAX value (sum of products)
end