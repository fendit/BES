%% Problem 2 (There are initially more psychologists than economists)
% Original(o) = >.5
% More psychologists(mp) = mp75, mp90
% mp75 = 75% of the population are psychologists
% mp90 = 90% of the population are psychologists
% More economists(me) = me75,me90
% me75 = 25% of the population are psychologists
% me90 = 10% of the population are psychologists

% Inputs
% Schelling function
% Schelling(name,second,nside,prop,num_sadecon,num_sadpsych,threshold_sadecons,...
% threshold_sadpsychs,unhappy_econ,unhappy_psych,largen,adjacent,samerandworld,randworld_i)
% randworld_i is needed when after running 'Original' for upcoming figures

% Outputs
% [econ,psych,numsadecons,numsadpsychs,p,randworld_i]
% randworld_i is needed in running 'Original'
% Figure from Schelling function
% Table showing results from 5 situations
% Figure showing overall happiness level from each situation
% Videos showing stimulations under different situations

clf; format compact
%% Calculation
% Original (0.5 = original level)
figure(1)
[o.econ,o.psych,o.numsadecons,o.numsadpsychs,p.o,randworld_i]=...
    Schelling('Original',0.0000000001,50,.5,100,100,50,50,3,1);

% More psychologists than economists (0.75 = 75% of the population are psychologists)
figure(2)
[mp75.econ,mp75.psych,mp75.numsadecons,mp75.numsadpsychs,p.mp75]=...
    Schelling('Psychologists = 75%',0.0000000001,50,.75,100,100,50,50,3,1,randworld_i);

% More economists than psychologists (0.25 = 75% of the population are economists)
figure(3)
[me75.econ,me75.psych,me75.numsadecons,me75.numsadpsychs,p.me75]=...
    Schelling('Psychologists = 25%',0.0000000001,50,.25,100,100,50,50,3,1,randworld_i); 

% More psychologists than economists (0.9 = 90% of the population are psychologists)
figure(4)
[mp90.econ,mp90.psych,mp90.numsadecons,mp90.numsadpsychs,p.mp90]=...
    Schelling('Psychologists = 90%',0.0000000001,50,.9,100,100,50,50,3,1,randworld_i); 

% More economists than psychologists (0.1 = 90% of the population are economists)
figure(5)
[me90.econ,me90.psych,me90.numsadecons,me90.numsadpsychs,p.me90]=...
    Schelling('Psychologists = 10%',0.0000000001,50,.1,100,100,50,50,3,1,randworld_i);
%% Create a table illustrating all numbers of sadecons & sadpsychs under 3 situations
% t = containing all data except p under each situation
% P = containing all p under each situation
t=[(cell2mat(struct2cell(o)))';...
    (cell2mat(struct2cell(mp75)))';(cell2mat(struct2cell(me75)))';...
    (cell2mat(struct2cell(mp90)))';(cell2mat(struct2cell(me90)))'];

P=[(cell2mat(struct2cell(p.o)))';...
    (cell2mat(struct2cell(p.mp75)))';(cell2mat(struct2cell(p.me75)))';...
    (cell2mat(struct2cell(p.mp90)))';(cell2mat(struct2cell(p.me90)))'];

T(:,1:4)=t; T(:,5:12)=round(P,4); % Combine t and p as a matrix(T)
T_problem_2=array2table(T','RowNames',{'No_of_Econs','No_of_Psychs',...
    'No_of_Sad_Econs','No_of_Sad_Psychs','Prop_of_Sad_Econ_in_Econ',...
    'Prop_of_Sad_Psych_in_Psych','Prop_of_Sad_Econ_in_Sad_ppl',...
    'Prop_of_Sad_Psych_in_Sad_ppl','Ratio_of_Sad_econ_to_Sad_Psych',...
    'Percent_of_Sadppl_World','Percent_of_Similar_Neighbours',...
    'Overall_Happiness_Level'},'VariableNames',...
    {'Original','Psychs_75','Econs_75','Psychs_90','Econs_90'});
disp(T_problem_2)

writetable(T_problem_2,'Table(Problem 2).xls','WriteRowNames',true) % Export the table to xls file
%% Graph showing overall happiness level in 5 different situations
happy_problem_2=table2array(T_problem_2(12,:));
happy_problem_2=happy_problem_2';
Name={'Original','Psychs_75','Econs_75','Psychs_90','Econs_90'};
figure(6)
hold on;
bar(happy_problem_2,'b');
set(gca,'XTick',1:length(Name),'XTicklabel',Name)
xtickangle(45) % Tile the xlabel to 45 degree
title("Overall Happiness Level in 5 situations",'FontSize',24)
ylabel('Proportion of Happy People','Fontsize',16);ylim([0 1]);
plot(xlim,[max(happy_problem_2) max(happy_problem_2)],'g'); % Add a line that shows the one with the highest happiness level