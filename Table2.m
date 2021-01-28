D=load('d_best.mat'); 
% D=load('d.mat');
d1=D.d;
d=gpuArray(d1); 
M=size(d1,3); 

alpha=[0.45,0.4,0.5,0.33,0.4,0.5,0.4,0.35,0.5,0.55,0.4,0.4,0.45,0.3,0.55,...
    0.4,0.9,0.4,0.55,0.42];
lambda=.01; 
gammaq=ones(1,20);
gammaq(17)=3;gammaq(20)=0.2;
gammav=gammaq;gammac=gammaq;
maxiter=200*ones(1,20);
maxiter(13)=300;
tol=1e-3;

gammaq=gpuArray(gammaq);gammav=gpuArray(gammav);gammac=gpuArray(gammac);
lambda=gpuArray(lambda);alpha=gpuArray(alpha);
% dixi=cell(1,10);

peak =30; 
for i=1:20
    t=num2str(i);
    t1=['.\clear\',t,'.bmp'];
    t2=['peak_nosiy\',t,'_peak=',num2str(peak),'.bmp'];
%  t=num2str(i,'%03d');
%     t1=['.\clear\Train400\test_',t,'.png'];
%     t2=['peak_nosiy\Train400\',num2str(i),'_peak=',num2str(peak),'.bmp'];
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
% S1=S1/max(S1(:));
[y,x,iterx]=solvex(d,diotf,S1,gammaq(i),gammav(i),gammac(i),lambda,alpha(i),fdeta,maxiter(i),tol);
y=real(gather(y));
% figure;imshow(y,[])
yy{i}=y;

imwrite(ls1(y),['.\peak_nosiy\denoised\peak=',num2str(peak),'_',t,'.bmp']);

Q = max(max(S)) /peak;
pp1(i)=psnr(ls1(S),ls1(y),1);
qq1(i)=ssim(uint8(ls1(S)*255),uint8(ls1(y)*255));
% i
end
 sum(pp1)/15
 sum(qq1)/15