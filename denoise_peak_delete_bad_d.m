clear;
pp=[];

% D=load('d_peak=30.mat');
% d1=D.d;
% bad=[166,164,147,146,143,138,137,134,133,130,...
%     128,126,114,101,100,99,98,73,59,58,57,52,50,43,31,23,13,9,8,6,5];

D=load('d_peak=30_100.mat');
d1=D.d;
bad=[96,91,86,82,81,60,55,53,47,44,43,40,28,24,23,20];

for i=bad
    d1(:,:,i)=[];
end

bad1=[80,79,59];
for i=bad1
    d1(:,:,i)=[];
end



alpha=0.6;
lambda=.01;
d=gpuArray(d1);
M=size(d1,3);

gammaq=1/alpha;gammav=1/alpha;gammac=1/alpha;
% gammaq=1;gammav=1;gammac=1;
maxiter=250;tol=5e-3;
gammaq=gpuArray(gammaq);gammav=gpuArray(gammav);gammac=gpuArray(gammac);
lambda=gpuArray(lambda);alpha=gpuArray(alpha);
% dixi=cell(1,10);

peak =30; 
% for i=4
for i=1:10
if i==6
    alpha=1.0;
else
    alpha=0.6;
end
    t=num2str(i);
    t1=['.\clear\',t,'.bmp'];
    t2=['peak_nosiy\',t,'_peak=',num2str(peak),'.bmp'];
S = imread(t1);
S1=imread(t2);
S=double(S(:,:,1));
S1=double(S1(:,:,1));
[m,n]=size(S);
otfDx=psf2otf([1,-1],[m,n]);
otfDy=psf2otf([1;-1],[m,n]);
fdeta=abs(otfDx).^2 + abs(otfDy).^2;
fdeta=gpuArray(fdeta);


[m1,n1,M]=size(d);
padSize = [m,n] - [m1,n1];
psf     = padarray(d, padSize, 'post');
psf    = circshift(psf,-floor([m1,n1]/2));
diotf = fft2(psf);
% diotf=gpuArray(diotf);

[y,x,iterx]=solvex(d,diotf,S1,gammaq,gammav,gammac,lambda,alpha,fdeta,maxiter,tol);
yy{i}=real(gather(y));
iternum{i}=gather(iterx);

% for k=1:M
%     dixi(:,:,k)=imfilter(x(:,:,k),rot90(d(:,:,k),2),'circular');
% end
% g1=sum(dixi,3);
% gg{i}=gather(g1);
% imshow(gg{i},[]);
   
imwrite(ls1(yy{i}),['.\peak_nosiy\denoised\peak=',num2str(peak),'_',t,'.bmp']);
% pp(i)=psnr(ls1(S),ls1(gg{i}),1);
% qq(i)=ssim(uint8(ls1(S)*255),uint8(ls1(gg{i})*255));
pp1(i)=psnr(ls1(S),ls1(yy{i}),1);
qq1(i)=ssim(uint8(ls1(S)*255),uint8(ls1(yy{i})*255));
% i
end
% % sum(pp)/length(pp)
% % sum(qq)/length(qq)
sum(pp1)/length(pp1)
sum(qq1)/length(qq1)