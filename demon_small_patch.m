clear;


M=100;
% % Construct initial dictionary
% D0 = zeros(8,8,M);
% D0(3:6,3:6,:) = (randn(4,4,M));

D0=randn(10,10,M);
D0=bsxfun(@rdivide, D0, max(sqrt(sum(sum(D0.^2, 1), 2)),1));


npd = 32;
fltlmbd = 5;

n = 8; % patch size
imgs_path = '.\fruit_100_100';
I= Create_Zearo_Mean_Images(imgs_path,n);
for i=1:length(I)
    S0(:,:,i)=I{i};
end
S0=imagepart(S0,4);

alpha=0.1;
lambda=0.2;
gammaq=10;
gammav=10;
gammac=10;


[m,n,N]=size(S0);
maxiterd=N*5; 
maxiterx=200;
t=0.02;
tol=5e-3;

D0=gpuArray(D0);
S0=gpuArray(S0);
lambda=gpuArray(lambda);
alpha=gpuArray(alpha);
gammaq=gpuArray(gammaq);
gammav=gpuArray(gammav);
gammac=gpuArray(gammac);
t=gpuArray(t);

[d,x,k]=traind(D0,S0,lambda,alpha,gammaq,gammav,gammac,t,maxiterd,maxiterx,tol);
d=gather(d);
x=gather(x);
imdisp(tiledict(d));
imwrite(ls1(tiledict(d)),'d_small_patch.png');
save('d_small_patch.mat','d'); 