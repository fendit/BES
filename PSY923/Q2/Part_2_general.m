%% Part 2 general approach
% Generalise the answer for n distributions (using for loop)
% No table is created automatically
% First for-loop: Show all distributions in terms of prices, r and RFTP
% Second for-loop: Show  all distributions when varying w
%% Data Input
u=[28 42 46 49 52 55 58 61 64 68 82]; % u=Unimodal
b=[28 31 34 38 42 55 68 72 76 79 82]; % b=Bimodal
ps=[28 29 31 33 36 39 43 48 55 65 82]; % ps=Positive Skew
ns=[28 45 55 62 67 71 74 77 79 81 82]; % ns=Negative Skew
distributions=[u;b;ps;ns]; % distributions = matrix of distributions (row)
names={'Unimodal';'Bimodal';'Positive Skew';'Negative Skew'}; % names = matrix of each distribution's name (col)

% Check if both matrices have the same length
if size(distributions,1)~=size(names,1)
    disp('Both matrices must have the same length!')
end
%% A general approach
% Input distributions in terms of matrix(distributions)
% Generate a 3D graph showing how RFTP and r vary over the distribution
% A table showing all results
% RFTP,r,range,freq of each distribution will be stored in terms of struct (name(:,row))

matrix=cell(size(distributions,1),4); % The matrix is for checking
for row=1:size(distributions,1)
    w=0.5; % Default w
    [r,RFTP,range,freq]=RFTG(distributions(row,:),w);
    matrix{row,1}=r; % 1st col = r
    matrix{row,2}=RFTP; % 2nd col = RFTP
    matrix{row,3}=range; % 3rd col = range
    matrix{row,4}=freq; % 4th col =  freq
    
    figure(1);
    hold on; grid on
    plot3(distributions(row,:),r,RFTP,'-o'); % Plot the graph with dots and line
    title("Range-Frequency Theory",'fontsize',18);
    xlabel("Prices (£)",'fontsize',16);
    ylabel("Predicted judged 'expensiveness' of each price",'fontsize',16);
    zlabel("Attractiveness Ratings",'fontsize',16);
    xlim([28 82]);
    legend(names)
    
    w=0:0.2:1; % Interval between 0 and 1 is a variable
    r=RFTG(distributions(row,:),w); % function       
    figure(2);
    hold on
    subplot(2,2,row) % 2 and 2 (2x2) depends on the total number of graphs need to be plotted
    plot(distributions(row,:),r'); % Graph for each row (distribution) in a matrix i
    title(char(names(row,:)),'fontsize',18); 
    xlabel("Prices (£)",'fontsize',16);
    ylabel("Attractiveness Ratings",'fontsize',16);
    xlim([28 82]);
    ylim([1 7]);
    legend(strcat('w=',num2str(w')));
end

% The table (array2table)
% No. of col names can vary according to the number of prices in the vector (char)
% It is a generalised table since the number of col names is not fixed
