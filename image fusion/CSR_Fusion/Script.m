close all;
clear;
clc;

% Load dictionary
% load('dict.mat');  
% load('d.mat'); 
load('../d.mat');
D=d;
 
% Load images
% id='S1';
% flag=1;

id='S3';
flag=2;

nA=['../',id,'_0_n','.bmp'];
nB=['../',id,'_1_n','.bmp'];
A=imread(nA);
B=imread(nB);
% A=imread('sourceimages/s01_1.tif');
% B=imread('sourceimages/s01_2.tif');



figure,imshow(A) 
figure,imshow(B)

%key parameters
lambda=0.01; 
 % 1 for multi-focus image fusion and otherwise for multi-modal image fusion

%CSR-based fusion
tic;
F=CSR_Fusion(A,B,D,lambda,flag); 
toc;

figure,imshow(F);
imwrite(F,['results/',id,'_fuse_n.bmp']);
