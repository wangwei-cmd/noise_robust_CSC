% j=2;
% test=imread('H:\clear image\7.bmp');
% test=double(test);
test=S0(:,:,k);
[height,width]=size(test);
a=zeros(height,width,M);
for i=1:M
    tt=imfilter(x(:,:,i),rot90(d(:,:,i),2),'circular');
%     figure;imshow(tt,[]);
    a(:,:,i)=tt;
    ee=['./filterd/',num2str(i),'.bmp'];
    imwrite(ls1(tt),ee);
end
rest=test-sum(a,3);
imwrite(ls1(rest),'./filterd/rest.bmp');
