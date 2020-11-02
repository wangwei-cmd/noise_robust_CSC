clear;

M=100;
% Construct initial dictionary
Width=11;
D0 = zeros(Width,Width,M);
kk=ceil(Width/4);
D0(kk:Width-kk,kk:Width-kk,:) = (randn(Width-2*kk+1,Width-2*kk+1,M));

% D0=randn(11,11,M);
D0=bsxfun(@rdivide, D0, max(sqrt(sum(sum(D0.^2, 1), 2)),1));

% data = 'fruit_10';
% S0=load (sprintf('datasets/%s/train/train_lcne.mat',data)); %%% 
% S0=S0.b;

npd = 16;
fltlmbd = 8;
name=glob('./lfw','.jpg');
n=8;
 k = (1/(n^2))*ones(n,n);
for i=1:10
    tmp=imread(name{i});
    tmp=double(rgb2gray(tmp));
%     lmn = rconv2(tmp,k);
%     Sh{i} = ls1(tmp - lmn)-0.5;
   Sh{i}=ls1(tmp)-0.5;
end

% for i=1:20
%     tmp=imread(name{i});
%     tmp=double(rgb2gray(tmp))/255;
%     [Sl, Sh{i}] = lowpass(tmp, fltlmbd, npd);
%     Sh{i}=ls1(Sh{i})-0.5;
% end

 
% figure;imshow(Sh{1},[]);


% name=glob('./lfw','.jpg');
% for i=1:10
%     tmp=imread(name{i});
%     Sh{i}=double(rgb2gray(tmp));
% end

alpha=0.1;
lambda=0.02;
gammaq=10;
gammav=10;
gammac=10;


maxiterd=5*length(Sh); 
maxiterx=200;
t=0.1;
tol=5e-3;

D0=gpuArray(D0);
% S0=gpuArray(S0);
lambda=gpuArray(lambda);
alpha=gpuArray(alpha);
gammaq=gpuArray(gammaq);
gammav=gpuArray(gammav);
gammac=gpuArray(gammac);
t=gpuArray(t);

[d,x,iterx]=traind_cell(D0,Sh,lambda,alpha,gammaq,gammav,gammac,t,maxiterd,maxiterx,tol);
d=gather(d);
x=gather(x);
imdisp(tiledict(d));
imwrite(ls1(tiledict(d)),'d.png');
save('d.mat','d'); 