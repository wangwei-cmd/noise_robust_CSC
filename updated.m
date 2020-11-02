function [d,diotf]=updated(d,diotf,x,c,y,t)
[m,n,M]=size(x);
% dixi=zeros(m,n,M);
[m1,n1,~]=size(d);
rm1=floor(m1/2);
rn1=floor(n1/2);
% for i=1:M
%     dixi(:,:,i)=imfilter(x(:,:,i),rot90(d(:,:,i),2),'circular');
% end



xf=fft2(x);
dixif=xf.*diotf;
t1=sum(dixif,3)+fft2(c-y);
t5=t1.*conj(xf);

% t1=sum(dixi,3)+c-y;
% t5=fft2(t1).*conj(fft2(x));


t6=real(ifft2(t5));
t6=circshift(t6,[rm1,rn1]);
grad=t6(1:m1,1:n1,:);
d=d-t*grad;
d=d./max(1,sqrt(sum(sum(d.^2,2),1)));

padSize = [m,n] - [m1,n1];
psf     = padarray(d, padSize, 'post');
psf    = circshift(psf,-floor([m1,n1]/2));
diotf = fft2(psf);


