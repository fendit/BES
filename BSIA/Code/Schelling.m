%% Schelling's Model of Segregration (Schelling)
%% Inputs
% name = name of the graph
% second = second(s) to pause each trial (0.0000000001 is ideal)
% nside = number of side (a square matrix)
% prop = proportion of psychologist relative to the population
% num_sadecon = number of sad econ as temp values
% num_sadpsych = number of sad psych as temp values
% threshold_sadecons = threshold of sad econ in while loop
% threshold_sadpsychs = threshold of sad psych in while loop
% unhappy_econ = number of psychologists as econ's neighbours make him unhappy (in %)
% unhappy_psych = number of economists as psych's neighbours make her unhappy (in %)
% Questions (user-interactive)
    % largeN = larger neighbourhood ('N' or simply press 'enter' = No; 'Y' = yes)
    % adj = adjacent neighbours swapping ('N' or simply press 'enter' = switching randomly; 'Y' = allow adjacent switching)
    % samerandworld = 'Y' if we want the same randworld,; 'N' or or simply press 'enter' for original
    % randworld_i = used only when comparing with different situations
%% Outputs (Quantitative)
% econ = number of economists in the world
% psych = number of psychologists in the world
% numsadecons = number of sad economists in the world
% numsadpsychs = number of sad psychologists in the world
% p = a struct contains:
    % p.sadecons_econ = proportion of sad econ in econ
    % p.sadpsychs_psych = proportion of sad psych in psych
    % p.sadecon_sadppl = proportion of sad econ in sad ppl
    % p.sadpsych_sadppl = proportion of sad psych in sad ppl
    % p.sadecons_sadpsych = ratio between sad econ and sad psych
    % p.happylevel = the overall happiness level in the world
% randworld_i = a copy of the randworld generated after running function with original case
% nside = number of side for the world
% necon = number of econ neighbours around an econ
% world = world with econs and psychs
% randworld = random world (each element is between 0 and 1)
% sadecons = map locating sad econs
% sadpsychs = map locating sad psychs
% r,c = coordinates of random sadecons or sadpsychs
% North,South,West,East,NorthWest,SouthWest,NorthEast,SouthEast = maps for finding econ neighbours
% index = used for finding a random sad econ or psych
%% Outputs (Graph & Video)
% A subplot of the world (left of the figure)
% A subplot of the percent of similar neighbour (top right of the figure)
% A subplot of the percent of unhappy people (down right of the figure)
% Number of iterations are shown inside () in xlabel 
% A video (in 60 fps) will be stored in the same directory of this function m.file locates 
%% Functions
function [econ,psych,numsadecons,numsadpsychs,p,randworld_i,...
    nside,necon,world,randworld,sadecons,sadpsychs,r,c,North,South,West,East,index]...
    =Schelling(name,second,nside,prop,num_sadecon,num_sadpsych,threshold_sadecons,threshold_sadpsychs,...
    unhappy_econ,unhappy_psych,randworld_i)

Question_largeN = 'Are you considering a larger neighbourhood? [Y/N]:';
Question_adj = 'Are agents allowed to switch with her adjacent neighbours only? [Y/N]:';
Question_samerworld = 'Are you using the same random world? [Y/N]:';

str_largeN = input(Question_largeN,'s');
if isempty(str_largeN)
    str_largeN = 'N'; % Larger Neighbourhood is not considered when pressing 'enter'
end

str_adj = input(Question_adj,'s');
if isempty(str_adj)
    str_adj = 'N'; % Random switching is considered when pressing 'enter'
end

str_samerandworld = input(Question_samerworld,'s');
if isempty(str_samerandworld)
    str_samerandworld = 'N'; % Same random world is not considered when pressing 'enter'
end

if str_samerandworld == 'N' % If not consider using the same random world
    [randworld_i,randworld]=GenerateRandWorld(nside); %Otherwise the function will generate a randworld based on nside
else
    randworld_i=randworld_i; % If using the same rand world from the original case
end
    
% video=VideoWriter(sprintf('%s.avi',name)); % The name of the video relies on the name (input)
% video.FrameRate = 60; % 60fps is better!
% open(video); 

world=randworld_i>prop; % Psychologist=0; economist=1;

totalppl=nside*nside; % Total number of people in this world
econ=sum(sum(world)); % The total number of econ
psych=totalppl-econ; % The total number of psych

colormap([.5 0 1;1 0.5 0]);% Psychs as purple , econs as orange

numsadecons=num_sadecon; numsadpsychs=num_sadpsych; % High temporary values for both academics to execute the while-loop below

nsadppl=[]; % nsadppl = number of sad people
nsimilarneighbour=[]; % nsimilarneighbour = number of similar neighbour
count=0; % initial count of iteration

while (numsadecons>threshold_sadecons) && (numsadpsychs>threshold_sadpsychs) % Use && instead of &

    % Calcuate number of econs surrounding each agent
    North=circshift(world,[1,0]); % North neighbour of econ
    South=circshift(world,[-1,0]); % South neighbour of econ
    West=circshift(world,[0,1]); % West neighbour of econ
    East=circshift(world,[0,-1]); % East neightbour of econ

        if str_largeN == 'Y'  % If Larger neighbourhood is considered
        NorthWest=circshift(world,[1,1]); % Northwest neighbour of econ
        SouthWest=circshift(world,[-1,1]); % Southwest neighbour of econ
        NorthEast=circshift(world,[1,-1]); % Northeast neighbour of econ
        SouthEast=circshift(world,[-1,-1]); % Southeast neightbour of econ
        else
            NorthWest=0;SouthWest=0;NorthEast=0;SouthEast=0; % If small neighbourhood is considered (original)
        end

    necon=North+South+West+East+NorthWest+SouthWest+NorthEast+SouthEast; %now necon has numbers of econ neighbours for each person in world

    % Find sad econs in the world
    sadecons=world.*((world.*necon)<unhappy_econ); % An econ wants to be around at least unecon econs

    % Find sad psychs in the world
    sadpsychs=abs(world-1).*((abs(world-1).*necon)>unhappy_psych); % A psych is unhappy around > unpsych econ

    numsadecons=sum(sum(sadecons)); numsadpsychs=sum(sum(sadpsychs));

    % Swap a random sad econ to be a psych
    if str_adj == 'Y' % if adjacent neighbours swapping is considered
        %now choose a random sad econ and change to be a psych:
        [r,c]=find(sadecons); %get the row and col indices of all sad econs
        index=ceil(rand*numsadecons); %choose a random sad econ
        se=[r(index),c(index)]; % % Find the sad econ's location with index

        %now choose a random sad psych and change to be an econ:
        [rp,cp]=find(sadpsychs); %get the row and col indices of all sad psychs
        sp=[rp,cp]; %assign a name sp to the vector 
        [Idx,d]=knnsearch(sp,se,'k',1); %get position of 1 sad psych neighbour

            if d==1  % if the distance is equal to 1 
                yoyo=sp(Idx,:);
                world(yoyo(1),yoyo(2))=1;
                world(r(index),c(index))=0;
            end
    else % if normal swapping is considered
    [r,c]=find(sadecons); % Find the row and col indices of all sad econs
    index=ceil(rand*numsadecons); % Choose a random sad econ
    world(r(index),c(index))=0;% Change the sad econ to a psych

    % Swap a random sad psych to be an econ
    [r,c]=find(sadpsychs); % Find the row and col indices of all sad psychs
    index=ceil(rand*numsadpsychs); % Choose a random sad psych
    world(r(index),c(index))=1; %change the psych to an econ
    end

    % Calculate the final step of changing
    % Calcuate number of econs surrounding each agent
    North=circshift(world,[1,0]); % North neighbour of econ
    South=circshift(world,[-1,0]); % South neighbour of econ
    West=circshift(world,[0,1]); % West neighbour of econ
    East=circshift(world,[0,-1]); % East neightbour of econ

        if str_largeN == 'Y' % If Larger neighbourhood is considered
        NorthWest=circshift(world,[1,1]); % Northwest neighbour of econ
        SouthWest=circshift(world,[-1,1]); % Southwest neighbour of econ
        NorthEast=circshift(world,[1,-1]); % Northeast neighbour of econ
        SouthEast=circshift(world,[-1,-1]); % Southeast neightbour of econ
        else
            NorthWest=0;SouthWest=0;NorthEast=0;SouthEast=0; % If small neighbourhood is considered (original)
        end

    necon=North+South+West+East+NorthWest+SouthWest+NorthEast+SouthEast; %now necon has numbers of econ neighbours for each person in world

    % Find sad econs in the world
    sadecons=world.*((world.*necon)<unhappy_econ); % An econ wants to be around at least unecon econs

    % Find sad psychs in the world
    sadpsychs=abs(world-1).*((abs(world-1).*necon)>unhappy_psych); % A psych is unhappy around > unpsych econ

    numsadecons=sum(sum(sadecons)); numsadpsychs=sum(sum(sadpsychs));
    SimilarEcon=sum(sum(necon.*world));
    if str_largeN == 'Y' % If Larger neighbourhood is considered
        SimilarPsych=sum(sum((8-necon).*abs(world-1))); % numbers of psychs neighbours around psych would be 8 - necon
    else
        SimilarPsych=sum(sum((4-necon).*abs(world-1))); % numbers of psychs neighbours around psych would be 4 - necon
    end
    nsimilarneighbour=[nsimilarneighbour;[SimilarEcon,SimilarPsych]]; % Store SimilarEcon and SimilarPsych for future reference and drawing a graph
    nsadppl=[nsadppl;[numsadecons,numsadpsychs]]; % Store numsadecons and numsadpsychs for future reference and drawing a graph
%% Subplot
    subplot('Position',[0.035,0.10,0.55,0.8]) % Create a subplot that shows the world
    imagesc(world) % Draw a colourmap
    title(sprintf('%s',name),'Fontsize',16) % The title of the graph depends on the name input
    pause(second) % Pause in second (depending on the input in the function)
    
    subplot ('Position',[0.67,0.575,0.3,0.325]) % Create a subplot that shows the percent of similar neighbours (base: totalppl)
    % Graph showing percentage of unhappy people during moving process
    Similar=1:length(nsimilarneighbour);
    if str_largeN == 'Y' % If Larger neighbourhood is considered
        PercentofSimilarEcon=(nsimilarneighbour(:,1)/(8*totalppl))*100; % Calculate the percent of similar econs compared to total neighbours
        PercentofSimilarPsych=(nsimilarneighbour(:,2)/(8*totalppl))*100; % Calculate the percent of similar psychs compared to total neighbours
        PercentofSimilarNeighbour=((nsimilarneighbour(:,1)+nsimilarneighbour(:,2))/(8*totalppl))*100; % Calculate the percent of similar neighbours compared to total neighbours
    else % If Larger neighbourhood is not considered
        PercentofSimilarEcon=(nsimilarneighbour(:,1)/(4*totalppl))*100; % Calculate the percent of similar econs compared to total neighbours
        PercentofSimilarPsych=(nsimilarneighbour(:,2)/(4*totalppl))*100; % Calculate the percent of similar psychs compared to total neighbours
        PercentofSimilarNeighbour=((nsimilarneighbour(:,1)+nsimilarneighbour(:,2))/(4*totalppl))*100; % Calculate the percent of similar neighbours compared to total neighbours
    end

    plot(Similar,PercentofSimilarEcon,Similar,PercentofSimilarPsych,Similar,PercentofSimilarNeighbour)
    title('Percentage of Similar Neighbours')
    ylabel('Percentage of Similar Neighbours')
    xlabel(sprintf('Number of trials (%d)',count)) % Number of iteration is shown in () in xlabel 
    ylim([0 100])
    
    subplot ('Position',[0.67,0.1,0.3,0.325]) % Create a subplot that shows the percentage of unhappy people (base: totalppl)
    % Graph showing percentage of unhappy people during moving process
    x=1:length(nsadppl); 
    PercentofSadecons=(nsadppl(:,1)/totalppl)*100; % Calculate the percent of sad econs relative to the population
    PercentofSadpsychs=(nsadppl(:,2)/totalppl)*100; % Calculate the percent of sad psychs relative to the population
    Percentofsadpeople=((nsadppl(:,1)+nsadppl(:,2))/totalppl)*100; % Calculate the percent of sad people relative to the population
    plot(x,PercentofSadecons,x,PercentofSadpsychs,x,Percentofsadpeople)
    title('Percentage of Unhappy People')
    ylabel('Percentage of unhappy people')
    xlabel(sprintf('Number of trials (%d)',count)) % Number of iteration is shown in () in xlabel 
    ylim([0 100])
    
%     frame=getframe(gcf); % Getting the frame from the current figure (gcf)
%     writeVideo(video,frame); % Make a video!

    count=count+1; % the count is incremented by 1 after one while loop
end
% Add a legend back to the last subplot; putting here would not slow down the process
legend(subplot('Position',[0.67,0.575,0.3,0.325]),{'Econs','Psychs','All'},'Location','southeast')
legend(subplot('Position',[0.67,0.1,0.3,0.325]),{'Econs','Psychs','All'}) 
    
% Calculate the proportion of sadecons and sadpsychs
p.sadecons_econ=numsadecons/econ; % Calculate the proportion of sad econ in econ
p.sadpsychs_psych=numsadpsychs/psych; % Calculate the proportion of sad psych in psych
p.sadecon_sadppl=numsadecons/(numsadecons+numsadpsychs); % Calculate the proportion of sad econ in sad ppl
p.sadpsych_sadppl=numsadpsychs/(numsadecons+numsadpsychs); % Calculate the proportion of sad psych in sad ppl
p.sadecons_sadpsych=numsadecons/numsadpsychs; % Calculate the ratio between sad econ and sad psych
p.sadppl_totalppl=(numsadecons+numsadpsychs)/totalppl; % Calculate the percentage of sad people to the world
if str_largeN == 'Y' % If Larger neighbourhood is considered
    p.similarneighbour=(SimilarEcon+SimilarPsych)/(8*totalppl);% Calculate the percentage of similar neighbours to total neighbours
else
    p.similarneighbour=(SimilarEcon+SimilarPsych)/(4*totalppl);
end
p.happylevel=1-((numsadecons+numsadpsychs)/(econ+psych)); % Calculate the overall happiness level in the world

% close(video) 
end

function [randworld_i,randworld]=GenerateRandWorld(nside) % Generate the rand world with nside (input)

s=rng;
randworld=rand(nside,nside); % Generate the randworld with nside 

rng(s);
randworld_i=rand(nside,nside); % Save the random results for future comparison
end
