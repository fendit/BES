%% Part 2 modified version (PS923 Assignment 3)
clear all; format compact
%% Section 1 - Data input
u=[28 42 46 49 52 55 58 61 64 68 82]; %u=Unimodal
b=[28 31 34 38 42 55 68 72 76 79 82]; %b=Bimodal
ps=[28 29 31 33 36 39 43 48 55 65 82]; %ps=Positive Skew
ns=[28 45 55 62 67 71 74 77 79 81 82]; %ns=Negative Skew
%% Section 2 - Rescale the RFT values derived from RFT function
% Results (RFTP,r,range,freq) are stored inside the struct
[U.RFTP,U.r,U.range,U.freq] = RFTtest(.5,u); % Unimodal
[B.RFTP,B.r,B.range,B.freq] = RFTtest(.5,b); % Bimodal
[PS.RFTP,PS.r,PS.range,PS.freq] = RFTtest(.5,ps); % Positively Skewed
[NS.RFTP,NS.r,NS.range,NS.freq] = RFTtest(.5,ns); % Negatively Skewed

% Create a table called T
T=[u;cell2mat(struct2cell(U));b;cell2mat(struct2cell(B));ps;cell2mat(struct2cell(PS));ns;cell2mat(struct2cell(NS))];
T=array2table(T,...
    'RowNames',{'Unimodal (u)','uRFTP','ur','urange','ufreq','Biomdal (b)',...
    'bRFTP','br','brange','bfreq','Positively Skewed (ps)','psRFTP','psr',...
    'psrange','psfreq','Negatively Skewed (ns)','nsRFTP','nsr','nsrange',...
    'nsfreq'},'VariableNames',{'p1','p2','p3','p4','p5','p6','p7',...
    'p8','p9','p10','p11'});
%% Section 3 - Graph for predicted judged "expensiveness", attractiveness ratings and prices
figure(1)
hold on;
scatter3(u,U.RFTP,U.r,'filled');
scatter3(b,B.RFTP,B.r,'filled');
scatter3(ps,PS.RFTP,PS.r,'filled');
scatter3(ns,NS.RFTP,NS.r,'filled');
plot3(u,U.RFTP,U.r) % Link all dots of u with a line
plot3(b,B.RFTP,B.r) % Link all dots of b with a line
plot3(ps,PS.RFTP,PS.r) % Link all dots of ps with a line
plot3(ns,NS.RFTP,NS.r) % Link all dots of ns with a line
title("Range-Frequency Theory",'fontsize',18);
xlabel("Prices (£)",'fontsize',16);
ylabel("Predicted judged 'expensiveness' of each price",'fontsize',16);
zlabel("Attractiveness Ratings",'fontsize',16);
xlim([28 82]);
legend({'Unimodal', 'Bimodal', 'Positive Skew', 'Negative Skew'})
%% Section 4 - Graphs for varying w in RFT values 
i=[u;b;ps;ns]; % Construct a matrix i with all price distributions
w=0:0.2:1; % It can be any set of values for w; change the number in between (0 and 1)

for row=1:size(i,1) % The for-loop lasts depending on the number of rows in i
        x=i(row,:);
        [RFTP,r,range,freq,w,distribution,name]=RFT(w,x); % function
        figure(2)
        subplot(2,2,row) % 2 and 2 (2x2) depends on the total number of graphs need to be plotted
        plot(x,r'); % Graph for each row (distribution) in a matrix i
        title(sprintf('Varying w: %s Distribution',name),'fontsize',18); 
        xlabel("Prices (£)",'fontsize',16);
        ylabel("Attractiveness Ratings",'fontsize',16);
        xlim([28 82]);
        ylim([1 7]);
        legend(strcat('w=',num2str(w')));
        display(distribution); % Display distribution for reference
end