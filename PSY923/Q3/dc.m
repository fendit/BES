function [discrim,dist,eta,td]=dc(td,retint,c) %td=[(ll-1)*pt+r0:-pt:r0];
%discrim - the resulting discriminability of each item
%dist - distance between items in log space
%eta - similarity of each item's temporal distance to every other item's temporal distance
%td - temporal distance
%ll - listlength
%pt - present time for items (s)
%r0 - recall time after the last item (s)
%retint - retention interval
%c - free parameter

dist=log(td+(retint));
for i=1:length(dist)
    eta=exp(-c*abs(dist(i)-dist));
    discrim(i)=1/sum(eta);
    plot(discrim,'-om');
    axis([0 length(dist) 0 1]);
    xlabel('Serial Position','fontsize',14);
    ylabel('Discriminability','fontsize',14);
    set(gcf, 'color', 'white');
end