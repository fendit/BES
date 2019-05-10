function [RFTP,r,range,freq,w,i,name]=RFT(w,i,name)
%RFTP: RFT prediction
%r: RFT values from rp that transform into predicted ratings between 1 and 7
%Range: Range position of a target price within a vector i at a given w
%freq: Frequency/rank position of a target price in a vector i at a given w
%w: Weighting parameter exogenously given at the beginning (scalar/vector)
%i: Vector (distribution); a set of target prices
%name: name of the distribution i (for legend)
    
    RFTP=w.'*((i-min(i))/(max(i)-min(i)))+(1-w).'*(((floor(tiedrank(i)))-1)/(numel(i)-1));
    r = rescale(-RFTP,1,7); 
    range=(i-min(i))/(max(i)-min(i));
    freq=((floor(tiedrank(i)))-1)/(numel(i)-1);
    w=w; i=i;
    name = input('What is the name of your distribution again?','s');

end