%% Problem 1 (Economists, psychologists or both can tolerate two/three different neighbours?)
% Original(o) = reference point
% Econ(e) = Economists can tolerate two neighbours
% Psych(p) = Psychologists can tolerate two neighbours
% Both(b) = Both can tolerate two different neighbours
% psychs as purple , econs as orange
% the number next to b,p,e indicates how many neighbours they can tolerate

% Inputs
% Schelling function
% Schelling(name,second,nside,prop,num_sadecon,num_sadpsych,threshold_sadecons,...
% threshold_sadpsychs,unhappy_econ,unhappy_psych,largen,adjacent,samerandworld,randworld_i)
% randworld_i is needed when after running 'Original' for upcoming figures

% Outputs
% [econ,psych,numsadecons,numsadpsychs,p,randworld_i]
% randworld_i is needed in running 'Original'
% Figure from Schelling function
% Table showing results from 7 situations
% Figure showing overall happiness level from each situation
% Videos showing stimulations under different situations

clf; format compact
%% Calculation
% Original
figure(1)
[o.econ,o.psych,o.numsadecons,o.numsadpsychs,p.o,randworld_i]=...
    Schelling('Original (Econ 1 & Psych 1)',0.0000000001,50,.5,100,100,50,50,3,1);

% Econs can tolerate two psych eighbours (>2 psychs neighbours = sad econ)
figure(2)
[e2.econ,e2.psych,e2.numsadecons,e2.numsadpsychs,p.e2]=...
    Schelling('Econ 2 & Psych 1',0.0000000001,50,.5,100,100,50,50,2,1,randworld_i); 

% Psychs can tolerate two econ neighbours (>2 econs neighbours = sad psych)
figure(3)
[p2.econ,p2.psych,p2.numsadecons,p2.numsadpsychs,p.p2]=...
    Schelling('Econ 1 & Psych 2',0.0000000001,50,.5,100,100,50,50,3,2,randworld_i); 

% Both can tolerate two different neighbours (Sad for both if >2 different neighbours)
figure(4)
[b2.econ,b2.psych,b2.numsadecons,b2.numsadpsychs,p.b2]=...
    Schelling('Both 2',0.0000000001,50,.5,100,100,50,50,2,2,randworld_i); 

% Econs can tolerate three psych neighbours (>3 psychs neighbours = sad econ)
figure(5)
[e3.econ,e3.psych,e3.numsadecons,e3.numsadpsychs,p.e3]=...
    Schelling('Econ 3 & Psych 1',0.0000000001,50,.5,100,100,50,50,1,1,randworld_i);

% Econs can tolerate three neighbours (>3 psychs neighbours = sad econ)
% Psychologists can tolerate two econ neighbours (>2 econ neighbours = sad psych)
figure(6)
[e3_2.econ,e3_2.psych,e3_2.numsadecons,e3_2.numsadpsychs,p.e3_2]=...
    Schelling('Econ 3 & Psych 2',0.0000000001,50,.5,100,100,50,50,1,2,randworld_i);

% Psychs can tolerate three econ neighbours (>3 econs neighbours = sad psych)
figure(7)
[p3.econ,p3.psych,p3.numsadecons,p3.numsadpsychs,p.p3]=...
    Schelling('Psych 3 & Econ 1',0.0000000001,50,.5,100,100,50,50,3,3,randworld_i);

% Psychs can tolerate three econ neighbours (>3 econs neighbours = sad psych)
% Econs can tolerate two psych neighbours (>2 psych neighbours = sad econ)
figure(8)
[p3_2.econ,p3_2.psych,p3_2.numsadecons,p3_2.numsadpsychs,p.p3_2]=...
    Schelling('Psych 3 & Econ 2',0.0000000001,50,.5,100,100,50,50,2,3,randworld_i);

% Both can tolerate three neighbours (Sad for both if >3 different neighbours)
figure(9)
[b3.econ,b3.psych,b3.numsadecons,b3.numsadpsychs,p.b3]=...
    Schelling('Both 3',0.0000000001,50,.5,100,100,50,50,1,3,randworld_i);
%% Create a table illustrating all numbers of sadecons & sadpsychs under 9 situations
% t = containing all data except p under each situation
% P = containing all p under each situation
t=[(cell2mat(struct2cell(o)))';...
    (cell2mat(struct2cell(e2)))';(cell2mat(struct2cell(p2)))';(cell2mat(struct2cell(b2)))';...
    (cell2mat(struct2cell(e3)))';(cell2mat(struct2cell(e3_2)))';...
    (cell2mat(struct2cell(p3)))';(cell2mat(struct2cell(p3_2)))';...
    (cell2mat(struct2cell(b3)))'];

P=[(cell2mat(struct2cell(p.o)))';...
    (cell2mat(struct2cell(p.e2)))';(cell2mat(struct2cell(p.p2)))';(cell2mat(struct2cell(p.b2)))';...
    (cell2mat(struct2cell(p.e3)))';(cell2mat(struct2cell(p.e3_2)))';...
    (cell2mat(struct2cell(p.p3)))';(cell2mat(struct2cell(p.p3_2)))';...
    (cell2mat(struct2cell(p.b3)))'];

T(:,1:4)=t; T(:,5:12)=round(P,4); % Combine t and p as a matrix(T)
T_problem_1=array2table(T','RowNames',{'No_of_Econs','No_of_Psychs',...
    'No_of_Sad_Econs','No_of_Sad_Psychs','Prop_of_Sad_Econ_in_Econ',...
    'Prop_of_Sad_Psych_in_Psych','Prop_of_Sad_Econ_in_Sad_ppl',...
    'Prop_of_Sad_Psych_in_Sad_ppl','Ratio_of_Sad_econ_to_Sad_Psych',...
    'Percent_of_Sadppl_World','Percent_of_Similar_Neighbours',...
    'Overall_Happiness_Level'},'VariableNames',{'Original','Econs_2','Psychs_2','Both_2',...
    'Econs_3andPsych_1','Econs_3andPsychs_2','Psychs_3andEcon_1','Psychs_3andEcons_2','Both_3'}); 
    % Convert array (T) into table (T_problem_1)
disp(T_problem_1)

writetable(T_problem_1,'Table(Problem 1).xls','WriteRowNames',true) % Export the table to xls file
%% Graph showing overall happiness level in 7 different situations
happy_problem_1=table2array(T_problem_1(12,:));
happy_problem_1=happy_problem_1';
Name={'Original','Econs_2','Psychs_2','Both_2',...
    'Econs_3andPsych_1','Econs_3andPsychs_2','Psychs_3andEcon_1','Psychs_3andEcons_2','Both_3'};
figure(10)
hold on;
bar(happy_problem_1,'b');
set(gca,'XTick',1:length(Name),'XTicklabel',Name)
xtickangle(45) % Tile the xlabel to 45 degree
title("Overall Happiness Level in 9 situations",'FontSize',24)
ylabel('Proportion of Happy People','Fontsize',16);ylim([0 1]);
plot(xlim,[max(happy_problem_1) max(happy_problem_1)],'g'); % Add a line that shows the one with the highest happiness level