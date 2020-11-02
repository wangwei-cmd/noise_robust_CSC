function [x]=updatex(d,diotf,s,b,q,y,c,gammac,gammaq,a1,a2,v1,v2,gammav,fdeta)
% [m1,n1,M]=size(d);
% [m,n]=size(s);
div=gammav./gammac.*(BackwardX(a1-v1)+BackwardY(a2-v2));

% padSize = [m,n] - [m1,n1];
% psf     = padarray(d, padSize, 'post');
% psf    = circshift(psf,-floor([m1,n1]/2));
% diotf = fft2(psf);

% bbf=conj(diotf).*fft2(y-c)-gammaq./gammac.*fft2(b-q)+fft2(div);
bbf=conj(diotf).*fft2(y-c)-fft2(gammaq/gammac*(b-q)-div);
aa=(gammav.*fdeta+gammaq)./gammac;

a1=sum(diotf.*bbf,3);
a2=aa+sum(abs(diotf).^2,3);
xf=(bbf-a1./a2.*conj(diotf))./aa;
x=real(ifft2(xf));



