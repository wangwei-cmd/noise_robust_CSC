close all;
clear;
addpath('..');
% Load dictionary
% load('dict.mat');  
% load('./CSR_Fusion/d.mat'); 
load('./d.mat'); 
d=gpuArray(d);

% Load images
% load('Multi_Focus_param.mat');
% orig=rgb2gray(z_bird_rgb);
% A=rgb2gray(Background_inFocus);
% A=imnoise(A,'poisson');
% B=rgb2gray(Foreground_inFocus);
% B=imnoise(B,'poisson');

orig=imread('bird_orig.png');
A=imread('bird_A.png');
B=imread('bird_B.png');

A=double(A);
B=double(B);
flag=1;
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

alpha=0.7;
lambda=.01;
gammaq=1/alpha;gammav=1/alpha;gammac=1/alpha;

maxiter=150;tol=5e-3;
diotf=gpuArray(diotf);
gammaq=gpuArray(gammaq);gammav=gpuArray(gammav);gammac=gpuArray(gammac);
lambda=gpuArray(lambda);alpha=gpuArray(alpha);fdeta=gpuArray(fdeta);
[imgf,Y1,Y2] = fusion_img_focus(A,B,d,diotf,lambda,alpha,fdeta,gammaq,gammav,gammac,maxiter,tol,flag);
imgf=gather(imgf);
figure;imshow(imgf);
psnr(ls1(imgf),ls1(orig),1)
ssim(uint8(ls1(imgf)*255),uint8(ls1(orig)*255))
imwrite(ls1(imgf),'bird_fused.png')