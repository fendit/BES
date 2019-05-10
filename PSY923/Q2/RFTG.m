%% RFT Generalised function (RFTG)
% r: RFT values from rp that transform into predicted ratings between 1 and 7
% RFTP: RFT prediction
% Range: Range position of a target price within a vector i at a given w
% freq: Frequency/rank position of a target price in a vector i at a given w
% w: Weighting parameter exogenously given at the beginning (scalar/vector)
% i: Vector (distribution); a set of target prices

function[r,RFTP,range,freq]=RFTG(distribution,w)
    range=(distribution-min(distribution))/(max(distribution)-min(distribution));
    freq=((floor(tiedrank(distribution)))-1)/(numel(distribution)-1);
    RFTP=w.'*range+(1-w).'*freq;
    r = rescale(-RFTP,1,7); 
end