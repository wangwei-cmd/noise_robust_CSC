function [d,x,iterx]=traind_cell(d,s,lambda,alpha,gammaq,gammav,gammac,t,maxiterd,maxiterx,tol)
[m1,n1,~]=size(d);
N=length(s);


epochs = round(maxiterd / N);
indices = [];
for ee = 1:epochs
  indices = [indices, randperm(N)];
end
delt=t;
inniterd=1;
for i=1:maxiterd
    oldd=d;
    k=indices(i);
    ss=gpuArray(s{k});
    [m,n]=size(s{k});
    otfDx=psf2otf([1,-1],[m,n]);
    otfDy=psf2otf([1;-1],[m,n]);
    fdeta=abs(otfDx).^2 + abs(otfDy).^2;

    padSize = [m,n] - [m1,n1];
    psf     = padarray(d, padSize, 'post');
    psf    = circshift(psf,-floor([m1,n1]/2));
    diotf = fft2(psf);
    [~,x,iterx{i}]=solvex(d,diotf,ss,gammaq,gammav,gammac,lambda,alpha,fdeta,maxiterx,tol);
    [d,diotf]=solved(d,diotf,x,ss,delt,gammac,inniterd);
    i;
end