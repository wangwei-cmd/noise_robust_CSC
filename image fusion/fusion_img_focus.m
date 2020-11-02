function [imgf,Y1,Y2] = fusion_img_focus(img1,img2,d,diotf,lambda,alpha,fdeta,gammaq,gammav,gammac,maxiter,tol,flag)
s1=double(img1)/255;
s2=double(img2)/255;
[hei,wid]=size(s1);

tic;
% Highpass filter test image
% npd = 16;
% fltlmbd = 5;
% [s1_l, s1_h] = lowpass(s1, fltlmbd, npd);
% [s2_l, s2_h] = lowpass(s2, fltlmbd, npd);
% s1_l=0;s2_l=0;
% s1_h=s1;s2_h=s2;
[Y1,X1,~]=solvex(d,diotf,s1,gammaq,gammav,gammac,lambda,alpha,fdeta,maxiter,tol);
[Y2,X2,~]=solvex(d,diotf,s2,gammaq,gammav,gammac,lambda,alpha,fdeta,maxiter,tol);
A1=sum(abs(X1),3);
A2=sum(abs(X2),3);
if flag == 1  
    r=9;  
else
    r=3; 
end

ker=ones(2*r+1,2*r+1)/((2*r+1)*(2*r+1));
AA1=imfilter(A1,ker);
AA2=imfilter(A2,ker);
decisionMap=AA1>AA2;
% if flag == 1  
%     imgf_l=s1_l.*decisionMap+s2_l.*(1-decisionMap);
% else
%     imgf_l=(s1_l+s2_l)/2;
% end
[height,width]=size(A1);
X=X1;
for j=1:height
    for i=1:width
        if decisionMap(j,i)==0
            X(j,i,:)=X2(j,i,:);
        end
    end
end
% imgf_h = ifft2(sum(bsxfun(@times, fft2(d, size(X,1), size(X,2)), fft2(X)),3),'symmetric');
for k=1:size(d,3)
    dixi(:,:,k)=imfilter(X(:,:,k),rot90(d(:,:,k),2),'circular');
end
imgf=sum(dixi,3);

imgf=uint8(imgf*255);



