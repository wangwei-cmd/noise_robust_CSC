function [y,x,iterx]=solvex(d,diotf,s,gammaq,gammav,gammac,lambda,alpha,fdeta,maxiter,tol)
% q is saprser than x, so we use the q as the returned value.
M=size(d,3);
[m,n]=size(s);
x=zeros(m,n,M);
b=zeros(m,n,M);
q=zeros(m,n,M);
a1=b;a2=b;v1=b;v2=b; 
y=s;c=zeros(m,n);
for i=1:maxiter
    oldx=x;
    [x]=updatex(d,diotf,s,b,q,y,c,gammac,gammaq,a1,a2,v1,v2,gammav,fdeta);
    q=updateq(q,x,b,lambda,gammaq);
    b=updateb(b,x,q);
    [y,sdixi]=updatey(d,diotf,x,s,c,gammac);
    c=updatec(sdixi,y,c);
    [v1,v2,xix,xiy]=updatev(d,x,a1,a2,alpha,gammav);
    [a1,a2]=updatea(a1,a2,xix,xiy,v1,v2);
    if norm(vec(oldx-x))/norm(vec(x))<tol
        break; 
    end  
end
iterx=i