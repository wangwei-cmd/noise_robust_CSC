function [d,diotf]=solved(d,diotf,x,s,t,gammac,inniterd)
c=zeros(size(s));
for i=1:inniterd
[y,sdixi]=updatey(d,diotf,x,s,c,gammac);
c=updatec(sdixi,y,c);
[d,diotf]=updated(d,diotf,x,c,y,t);
end