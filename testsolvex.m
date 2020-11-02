clear;
D=load('d-best.mat');
d=D.d;
M=size(d,3);

m=256;n=256;
otfDx=psf2otf([1,-1],[m,n]);
otfDy=psf2otf([1;-1],[m,n]);
fdeta=abs(otfDx).^2 + abs(otfDy).^2;
[m1,n1,M]=size(d);
padSize = [m,n] - [m1,n1];
psf     = padarray(d, padSize, 'post');
psf    = circshift(psf,-floor([m1,n1]/2));
diotf = fft2(psf);
alpha=1;
lambda=.0001;
gammaq=1;gammav=1;gammac=1;maxiter=150;tol=1e-3;  

d=gpuArray(d);
diotf=gpuArray(diotf);
gammaq=gpuArray(gammaq);gammav=gpuArray(gammav);gammac=gpuArray(gammac);
lambda=gpuArray(lambda);alpha=gpuArray(alpha);fdeta=gpuArray(fdeta);


for i=1:1
t=num2str(i);
t1=['.\clear\',t,'.bmp'];
t2=['.\Poisson_image_peak=30\',t,'_noisy.png'];
S = imread(t1);
S1=imread(t2);
% S1=imnoise(S,'poisson');
S=double(S(:,:,1));
S1=double(S1(:,:,1));
S1=gpuArray(S1);


[y,x,iterx]=solvex(d,diotf,S1,gammaq,gammav,gammac,lambda,alpha,fdeta,maxiter,tol);
y=real(gather(y));
% x=gather(x);

dixi=gpuArray(zeros(m,n,M)); 
for k=1:M
    dixi(:,:,k)=imfilter(x(:,:,k),rot90(d(:,:,k),2),'circular');
end
g1=sum(dixi,3);
g1=gather(g1);
imshow(g1,[]);
imwrite(ls1(g1),['.\Poisson_image_peak=30\denoised\',t,'.bmp']);
pp(i)=psnr(ls1(S),ls1(g1));
pp1(i)=psnr(ls1(S),ls1(y));
qq(i)=ssim(ls1(S),ls1(g1));
qq1(i)=ssim(ls1(S),ls1(y));
end
averpp=sum(pp)/length(pp)
averqq=sum(qq)/length(qq)
averpp1=sum(pp1)/length(pp1)
averqq1=sum(qq1)/length(qq1)
