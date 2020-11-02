close all;
clear;
clc;
addpath('..');
% Load dictionary
% load('dict.mat');  
% load('./CSR_Fusion/d.mat'); 
load('./d.mat'); 
d=gpuArray(d);

% Load images
% id='S1';
% flag=1;

id='S3';
flag=2;

nA=['./',id,'_0_n','.bmp'];
nB=['./',id,'_1_n','.bmp'];
A=imread(nA);
B=imread(nB);
A=double(A);
B=double(B);

figure,imshow(A,[]);
figure,imshow(B,[]);

[m,n]=size(A);
otfDx=psf2otf([1,-1],[m,n]);
otfDy=psf2otf([1;-1],[m,n]);
fdeta=abs(otfDx).^2 + abs(otfDy).^2;

[m1,n1,M]=size(d);
padSize = [m,n] - [m1,n1];
psf     = padarray(d, padSize, 'post');
psf    = circshift(psf,-floor([m1,n1]/2));
diotf = fft2(psf);

alpha=0.5;
lambda=.01;
% gammaq=1/alpha;gammav=1/alpha;gammac=1/alpha;
gammaq=10;gammav=10;gammac=10;
maxiter=150;tol=5e-3;
diotf=gpuArray(diotf);
gammaq=gpuArray(gammaq);gammav=gpuArray(gammav);gammac=gpuArray(gammac);
lambda=gpuArray(lambda);alpha=gpuArray(alpha);fdeta=gpuArray(fdeta);
if flag==1
[imgf,Y1,Y2] = fusion_img_focus(A,B,d,diotf,lambda,alpha,fdeta,gammaq,gammav,gammac,maxiter,tol,flag);
elseif flag==2
    [imgf,Y1,Y2] = fusion_img_model(A,B,d,diotf,lambda,alpha,fdeta,gammaq,gammav,gammac,maxiter,tol,flag);
end

figure;imshow(imgf);
imwrite(gather(ls1(imgf)),[id,'_fuse_n.bmp']);