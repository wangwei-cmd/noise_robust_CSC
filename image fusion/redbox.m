s_ori=imread('bird_orig.png');
s_our=imread('bird_fused.png');
s_csr=imread('./CSR_Fusion/results/bird_csr.tif');

s_ori=repmat(s_ori,[1,1,3]);
s_our=repmat(s_our,[1,1,3]);
s_csr=repmat(s_csr,[1,1,3]);


s_ori(132:167,120)=1000;
s_ori(132:167,140)=1000;
s_ori(132,120:140)=1000;
s_ori(167,120:140)=1000;

s_our(132:167,120)=1000;
s_our(132:167,140)=1000;
s_our(132,120:140)=1000;
s_our(167,120:140)=1000;

s_csr(132:167,120)=1000;
s_csr(132:167,140)=1000;
s_csr(132,120:140)=1000;
s_csr(167,120:140)=1000;
figure;imshow(s_ori,[]);
figure;imshow(s_our,[]);
figure;imshow(s_csr,[]);
imwrite(ls1(s_ori),'bird_ori_box.png')
imwrite(ls1(s_our),'bird_our_box.png')
imwrite(ls1(s_csr),'bird_csr_box.png')