%% Part 3 (PS923 Assignment 3)
clear all; format compact
%% Section 1 - Data input
original=(10:-1:1); %original td
tg=[12:-1:8 6 4:-1:1]; %td adding temporal gap
shortll=(5:-1:1); %short list length
longll=(20:-1:1); %long list length
retint=(0:5:20); %retention interval
c=[5 2.5 7.5 10]; %parameter c
%% Section 2 - Original Serial Position Curve
discrim=dc(original,retint(1),c(1)); %Using original as td
figure(1); %Plotting the original serial position curve
title('Original Serial Position Curve','fontsize',18);
%% Section 3 - Adding a retention interval
for m=1:size(retint,2)
        figure(2); %Plotting a new figure
        subplot(1,size(retint,2),m) %Column of the subplot depends on the number of elements in retint
        title(strcat('retint=',num2str(retint(m)))); %Title coded according to retint(m)
        hold on; %Title can be 'saved' during the loop process
        discrim=dc(original,retint(:,m),c(1)); %Calculate discrim with various retint values
end
suptitle('Changes in Retention interval')
%% Section 4 - Adding a temporal gap
figure(3); %Plotting a new figure
        subplot(1,2,1) %The last digit indicates that this figure is on the left of figure 3
        title('Original','fontsize',16);
        hold on; %Title is 'saved' 
        discrim=dc(original,retint(1),c(1)); %Using original as td

        subplot(1,2,2) %The last digit indicates that this figure is on the right of figure 3
        title('Temporal Gap added','fontsize',16);
        hold on; %Title is 'saved' 
        discrim=dc(tg,retint(1),c(1)); %Using tg as td
suptitle('Original Serial Position Curve')
%% Section 5 - Change in list length
figure(4); %Plotting a new figure
subplot(1,3,1) %The last digit indicates that this figure is on the left of figure 3
title('Original','fontsize',16);
hold on; %Title is 'saved' 
discrim=dc(original,retint(1),c(1)); %Using original as td

subplot(1,3,2) %The last digit indicates that this figure is in the middle of figure 3
title('Short list length','fontsize',16);
hold on; %Title is 'saved' 
discrim=dc(shortll,retint(1),c(1)); %Using shortll as td

subplot(1,3,3) %The last digit indicates that this figure is on the right of figure 3
title('Long list length','fontsize',16);
hold on; %Title is 'saved' 
discrim=dc(longll,retint(1),c(1)); %Using longll as td
suptitle('Original Serial Position Curve')
%% Section 6 - Change in c parameter
for n=1:size(c,2)
        figure(5); %Plotting a new figure
        subplot(1,size(c,2),n) %Column of the subplot depends on the number of elements in c
        title(strcat('c=',num2str(c(n)))); %Title coded according to c(n)
        hold on; %Title can be 'saved' during the loop process
        discrim=dc(original,retint(1),c(:,n)); %Calculate discrim with various c values
end
suptitle('Change in c parameter')
%% Section 7 - Change in list length and c parameter
for f=1:size(c,2)
        figure(6); %Plotting a new figure
        subplot(3,size(c,2),f) %Column of the subplot depends on the number of elements in c
        title(strcat('c=',num2str(c(f)))); %Title coded according to c(f)
        hold on; %Title can be 'saved' during the loop process
        discrim=dc(shortll,retint(1),c(:,f)); %Using Short list length as td

        subplot(3,size(c,2),f+4) %Column of the subplot depends on the number of elements in c
        title(strcat('c=',num2str(c(f)))); %Title coded according to c(f)
        hold on; %Title can be 'saved' during the loop process
        discrim=dc(original,retint(1),c(:,f)); %Using Short list length as td
        
        subplot(3,size(c,2),f+8) %Column of the subplot depends on the number of elements in c
        % the "3" depends on the numbers of curve plotted (i.e. it would be
        % 4 if there are eight curves plotted)
        title(strcat('c=',num2str(c(f)))); %Title coded according to c(f)
        hold on; %Title can be 'saved' during the loop process
        discrim=dc(longll,retint(1),c(:,f)); %Using Long list length     
end
    suptitle('Change in list length and c parameter')
    annotation('textbox', [0.025, 0.85, 0, 0],'string', 'Short list length', 'fontsize', 14); % Short list length
    annotation('textbox', [0.025, 0.55, 0, 0],'string', 'Original', 'fontsize', 14); % Original
    annotation('textbox', [0.025, 0.35, 0, 0],'string', 'Long list length','fontsize', 14); % Long list length
%% Section 8 - Change in list length and c parameter (temporal gap included)
for s=1:size(c,2)
        figure(7); %Plotting a new figure
        subplot(4,size(c,2),s) %Column of the subplot depends on the number of elements in c
        title(strcat('c=',num2str(c(s)))); %Title coded according to c(f)
        hold on; %Title can be 'saved' during the loop process
        discrim=dc(shortll,retint(1),c(:,s)); %Using Short list length as td

        subplot(4,size(c,2),s+4) %Column of the subplot depends on the number of elements in c
        title(strcat('c=',num2str(c(s)))); %Title coded according to c(f)
        hold on; %Title can be 'saved' during the loop process
        discrim=dc(original,retint(1),c(:,s)); %Using Short list length as td
        
        subplot(4,size(c,2),s+8) %Column of the subplot depends on the number of elements in c
        % the "3" depends on the numbers of curve plotted (i.e. it would be
        % 4 if there are eight curves plotted)
        title(strcat('c=',num2str(c(s)))); %Title coded according to c(f)
        hold on; %Title can be 'saved' during the loop process
        discrim=dc(longll,retint(1),c(:,s)); %Using Long list length as td
        
        subplot(4,size(c,2),s+12) %Column of the subplot depends on the number of elements in c
        % the "3" depends on the numbers of curve plotted (i.e. it would be
        % 4 if there are eight curves plotted)
        title(strcat('c=',num2str(c(s)))); %Title coded according to c(f)
        hold on; %Title can be 'saved' during the loop process
        discrim=dc(tg,retint(1),c(:,s)); %Using temporal gap as td    
end
    suptitle('Change in list length and c parameter (temporal gap included)')
    annotation('textbox', [0.025, 0.85, 0, 0],'string', 'Short list length', 'fontsize', 14); % Short list length
    annotation('textbox', [0.025, 0.65, 0, 0],'string', 'Original', 'fontsize', 14); % Original
    annotation('textbox', [0.025, 0.45, 0, 0],'string', 'Long list length','fontsize', 14); % Long list length
    annotation('textbox', [0.025, 0.25, 0, 0],'string', 'Temporal Gap Added','fontsize', 14); % Temporal Gap Added