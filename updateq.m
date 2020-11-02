function q=updateq(q,x,b,lambda,gammaq,normflg)
if nargin<6
    normflg=1;
end
t1=x+b;
TH=lambda./gammaq;
if normflg==1
   q=sign(t1).*max(abs(t1)-TH,0);
elseif normflg==0
   index=(t1.^2>2*TH);
   q=zeros(size(t1));
   q(index)=t1(index);
end