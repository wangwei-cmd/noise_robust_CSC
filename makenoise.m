for i=1:10
     t=num2str(i);
     name=['.\fruit_100_100\',t,'.jpg'];
     name1=['.\fruit_100_100\noisy\',t,'.jpg'];
     f=imread(name);
     f=rgb2gray(f);
     f=imnoise(f,'poisson');
     f=imnoise(f,'gaussian',0,0.002);
     imwrite(f,name1);
end