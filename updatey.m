function [y,sdixi]=updatey(d,diotf,x,s,c,gammac)
% [m1,n1,M]=size(d);
% [m,n]=size(s);
% padSize = [m,n] - [m1,n1];
% psf     = padarray(d, padSize, 'post');
% psf    = circshift(psf,-floor([m1,n1]/2));
% diotf = fft2(psf);

dixif=diotf.*fft2(x);
dixi=real(ifft2(dixif));
sdixi=sum(dixi,3);
b=gammac*(sdixi+c)-1;
y=(b+sqrt(complex(b.^2+4*gammac.*s)))./2./gammac;