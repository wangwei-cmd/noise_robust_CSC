for i=1:10
    peak=30;
t=['clear\',num2str(i),'.bmp'];
t1=['peak_nosiy\',num2str(i),'_peak=',num2str(peak),'.bmp'];
f=imread(t);
f=double(f(:,:,1));
% f=ls1(f);
% f1=f+poissrnd(f,size(f));

sd=2;
rng(sd)
Q = max(f(:)) /peak;
f1 = f / Q;
f1(1 == 0) = min(min(f1(f1 > 0)));
f1 = knuth_poissrnd(f1);
imwrite(ls1(f1),t1);
end