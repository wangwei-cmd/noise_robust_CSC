clear;

M=200;
% Construct initial dictionary
Width=11;
D0 = zeros(Width,Width,M);
kk=ceil(Width/4);
D0(kk:Width-kk,kk:Width-kk,:) = (randn(Width-2*kk+1,Width-2*kk+1,M));

% D0=randn(11,11,M);
D0=bsxfun(@rdivide, D0, max(sqrt(sum(sum(D0.^2, 1), 2)),1));

data = 'fruit_10';
data1='city_10';
S0=load (sprintf('datasets/%s/train/train_lcne.mat',data)); %%% 
S0=S0.b;
S1=load (sprintf('datasets/%s/train/train_lcne.mat',data1)); %%% 
S1=S1.b;
S0=cat(3,S0,S1);

% alpha=0.1;
% lambda=2;
% gammaq=10;
% gammav=10;
% gammac=10;

alpha=0.1;
lambda=0.02;
gammaq=10;
gammav=10;
gammac=10;


maxiterd=100; 
maxiterx=200;
t=0.1;
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
imwrite(ls1(tiledict(d)),'d.png');
save('d.mat','d'); 