function [d,x,k]=traind(d,s,lambda,alpha,gammaq,gammav,gammac,t,maxiterd,maxiterx,tol)
[m,n,N]=size(s);
otfDx=psf2otf([1,-1],[m,n]);
otfDy=psf2otf([1;-1],[m,n]);
fdeta=abs(otfDx).^2 + abs(otfDy).^2;

[m1,n1,~]=size(d);
padSize = [m,n] - [m1,n1];
psf     = padarray(d, padSize, 'post');
psf    = circshift(psf,-floor([m1,n1]/2));
diotf = fft2(psf);

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
%     mode=randperm(8,1);
%     mode=1;
%     ss=data_augmentation(s(:,:,k), mode);
    ss=s(:,:,k);
    [~,x,~]=solvex(d,diotf,ss,gammaq,gammav,gammac,lambda,alpha,fdeta,maxiterx,tol);
    [d,diotf]=solved(d,diotf,x,ss,delt,gammac,inniterd);
%     fprintf('iterx:%4d i:%4d  error: %.4e  index: %3d mode:%1d\n',...
%     iterx,i,norm(vec(oldd-d)),k,mode)
end