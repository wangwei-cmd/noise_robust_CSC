f=randn([180,180]);
d=randn([7,7,32]);
dif=fun1(f,d);
dif1=fun2(f,d);
tt=dif-dif1;

function dif=fun1(f,d)
dif=zeros(180,180,32);
for i=1:32
    diotf=psf2otf(d(:,:,i),[180,180]);
    dif(:,:,i)=ifft2(fft2(f).*diotf);
end
end

function dif1=fun2(f,d)
dif1=zeros(180,180,32);
for i=1:32
    dif1(:,:,i)=conv2(f,d(:,:,i),'same');
%     dif1(:,:,i)=imfilter(f,rot90(d(:,:,i),2),'circular');
end
end

