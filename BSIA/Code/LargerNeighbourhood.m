%% Problem 3 (Consider larger neighbourhood)
% Original(o) = 4 neighbourhoods considered (North, South, East, West)
% Larger Neighbour(ln) = additional 4 neighbourhoods considered (NorthWest,SouthWest,NorthEast,SouthEast)
% Consider a linear change of the rule as the ratio between larger neighbourhood and original is 2
% Then the unhappy_econ and unhappy_psych under larger neighbourhood are 6 and 2 respectively
% The threshold of sad econs and psychs should be doubled
% The Schelling rule is more restricted for both econ and psych
% More ppl are assumed to be sad in larger neighbourhood

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
% Original (unhappy_econ == 3,unhappy_psych == 1)
figure(1)
[o.econ,o.psych,o.numsadecons,o.numsadpsychs,p.o,randworld_i]=...
    Schelling('Original',0.0000000001,50,.5,200,200,100,100,3,1);

% Larger Neighbourhood (unhappy_econ == 5, unhappy_psych == 3)
figure(2)
[ln.econ,ln.psych,ln.numsadecons,ln.numsadpsychs,p.ln]=...
    Schelling('Larger Neighbourhood',0.0000000001,50,.5,200,200,100,50,6,2,randworld_i); 
%% Create a table illustrating all numbers of sadecons & sadpsychs under 2 situations
% t = containing all data except p under each situation
% P = containing all p under each situation
t=[(cell2mat(struct2cell(o)))';(cell2mat(struct2cell(ln)))'];

P=[(cell2mat(struct2cell(p.o)))';(cell2mat(struct2cell(p.ln)))'];

T(:,1:4)=t; T(:,5:12)=round(P,2); % Combine t and p as a matrix(T)
T_problem_3=array2table(T','RowNames',{'No_of_Econs','No_of_Psychs',...
    'No_of_Sad_Econs','No_of_Sad_Psychs','Prop_of_Sad_Econ_in_Econ',...
    'Prop_of_Sad_Psych_in_Psych','Prop_of_Sad_Econ_in_Sad_ppl',...
    'Prop_of_Sad_Psych_in_Sad_ppl','Ratio_of_Sad_econ_to_Sad_Psych',...
    'Percent_of_Sadppl_World','Percent_of_Similar_Neighbours',...
    'Overall_Happiness_Level'},'VariableNames',{'Original','Larger_Neighbourhood'});
disp(T_problem_3)

writetable(T_problem_3,'Table(Problem 3).xls','WriteRowNames',true) % Export the table to xls file
%% Graph showing overall happiness level in 2 different situations
happy_problem_3=table2array(T_problem_3(12,:));
happy_problem_3=happy_problem_3';
Name={'Original','Larger Neighbourhood'};
figure(3)
hold on;
bar(happy_problem_3,'b');
set(gca,'XTick',1:length(Name),'XTicklabel',Name)
xtickangle(45) % Tile the xlabel to 45 degree
title("Overall Happiness Level in 2 situations",'FontSize',24)
ylabel('Proportion of Happy People','Fontsize',16);ylim([0 1]);
plot(xlim,[max(happy_problem_3) max(happy_problem_3)],'g'); % Add a line that shows the one with the highest happiness level
