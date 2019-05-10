%% Problem 4 (Only allowing adjacent neighbours to switch)
% Original(o) = agents are allowed to switch with another agent randomly
% Adjacent(adj) = agents are allowed to switch with adjacent agents only
% Example: A sadecon can switch with a sad psych that is his neighbour and vice versa
% Changes in threshold values of both academics might be needed 

% Inputs
% Schelling function
% Schelling(name,second,nside,prop,num_sadecon,num_sadpsych,threshold_sadecons,...
% threshold_sadpsychs,unhappy_econ,unhappy_psych,largen,adjacent,samerandworld,randworld_i)
% randworld_i is needed when after running 'Original' for upcoming figures

% Outputs
% [econ,psych,numsadecons,numsadpsychs,p,randworld_i]
% randworld_i is needed in running 'Original'
% Figure from Schelling function
% Table showing results from 2 situations
% Figure showing overall happiness level from each situation
% Videos showing stimulations under different situations

clf; format compact
%% Calculation
% Original
figure(1)
[o.econ,o.psych,o.numsadecons,o.numsadpsychs,p.o,randworld_i]=...
    Schelling('Original',0.0000000001,50,.5,1000,1000,500,500,3,1);

% Adjacent
figure(2)
[adj.econ,adj.psych,adj.numsadecons,adj.numsadpsychs,p.adj]=...
    Schelling('Adjacent Neighbour',0.0000000001,50,.5,1000,1000,500,500,3,1,randworld_i);
%% Create a table illustrating all numbers of sadecons & sadpsychs under 2 situations
% t = containing all data except p under each situation
% P = containing all p under each situation
t=[(cell2mat(struct2cell(o)))';(cell2mat(struct2cell(adj)))'];

P=[(cell2mat(struct2cell(p.o)))';(cell2mat(struct2cell(p.adj)))'];

T(:,1:4)=t; T(:,5:12)=round(P,4); % Combine t and p as a matrix(T)
T_problem_4=array2table(T','RowNames',{'No_of_Econs','No_of_Psychs',...
    'No_of_Sad_Econs','No_of_Sad_Psychs','Prop_of_Sad_Econ_in_Econ',...
    'Prop_of_Sad_Psych_in_Psych','Prop_of_Sad_Econ_in_Sad_ppl',...
    'Prop_of_Sad_Psych_in_Sad_ppl','Ratio_of_Sad_econ_to_Sad_Psych',...
    'Percent_of_Sadppl_World','Percent_of_Similar_Neighbours',...
    'Overall_Happiness_Level'},'VariableNames',{'Original','Adjacent_Neighbours'});
disp(T_problem_4)

writetable(T_problem_4,'Table(Problem 4).xls','WriteRowNames',true) % Export the table to xls file
%% Graph showing overall happiness level in 2 different situations
happy_problem_4=table2array(T_problem_4(12,:));
happy_problem_4=happy_problem_4';
Name={'Original','Adjacent Neighbourhood'};
figure(3)
hold on;
bar(happy_problem_4,'b');
set(gca,'XTick',1:length(Name),'XTicklabel',Name)
xtickangle(45) % Tile the xlabel to 45 degree
title("Overall Happiness Level in 2 situations",'FontSize',24)
ylabel('Proportion of Happy People','Fontsize',16);ylim([0 1]);
plot(xlim,[max(happy_problem_4) max(happy_problem_4)],'g'); % Add a line that shows the one with the highest happiness level
