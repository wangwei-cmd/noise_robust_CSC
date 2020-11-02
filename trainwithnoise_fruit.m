clear;



M=100;
% Construct initial dictionary
% D0 = zeros(8,8,M);
% D0(3:6,3:6,:) = (randn(4,4,M));
D0=randn(11,11,M);
D0=bsxfun(@rdivide, D0, max(sqrt(sum(sum(D0.^2, 1), 2)),1));
% 
% n = 8; % patch size
% imgs_path = '.\noisy-fruit\';
% I= Create_Zearo_Mean_Images1(imgs_path,n);
% for i=1:length(I)
%      S0(:,:,i)=I{i};
% end

name='.\fruit_100_100\';
peak=30;
for i=1:10
    name1=[name,num2str(i),'.jpg'];
    tmp=imread(name1);
%     tmp=double(tmp(:,:,1));
    tmp=rgb2gray(tmp);
    tmp=double(tmp);
    Q = max(tmp(:)) /peak;
    ima_lambda = tmp / Q;
    ima_lambda(tmp == 0) = min(min(ima_lambda(ima_lambda > 0)));
    S0(:,:,i)= knuth_poissrnd(ima_lambda);
end

npd = 16;
fltlmbd = 5;
[Sl, S0] = lowpass(S0, fltlmbd, npd);

save('fruit_noisy.mat','S0');


% alpha=0.1;
% lambda=0.02;
% gammaq=10;
% gammav=10;
% gammac=10;

alpha=0.1;
lambda=2;
gammaq=10;
gammav=10;
gammac=10;



maxiterd=50; 
maxiterx=200;
t=0.1;
tol=5e-3;
% tol=1e-100;

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
save(['d_peak=',num2str(peak),'_100.mat'],'d'); 
imdisp(tiledict(d));



% dixi=zeros(m,n,M);
% for i=1:M
%     dixi(:,:,i)=imfilter(x(:,:,i),rot90(d(:,:,i),2),'circular');
% end
% g=sum(dixi,3);
% imshow(S0(:,:,k),[]);figure;imshow(g,[]);
% nozero=sum(vec(x~=0))
% sum(vec(abs(g-S0(:,:,k))))