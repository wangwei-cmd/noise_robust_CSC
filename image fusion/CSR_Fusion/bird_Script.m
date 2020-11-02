close all;
clear;
clc;

% Load dictionary
% load('dict.mat');  
% load('d.mat'); 
load('../d.mat');
D=d;

% Load images
% A=imread('sourceimages/s01_1.tif');
% B=imread('sourceimages/s01_2.tif');

orig=imread('../bird_orig.png');
A=imread('../bird_A.png');
B=imread('../bird_B.png');


figure,imshow(A) 
figure,imshow(B)

%key parameters
lambda=0.01; 
flag=1; % 1 for multi-focus image fusion and otherwise for multi-modal image fusion

%CSR-based fusion
tic;
F=CSR_Fusion(A,B,D,lambda,flag); 
toc;

figure,imshow(F);
imwrite(F,'results/bird_csr.tif');
psnr(ls1(F),ls1(orig),1)
ssim(uint8(ls1(F)*255),uint8(ls1(orig)*255))