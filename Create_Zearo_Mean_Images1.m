function [I] = Create_Zearo_Mean_Images1(imgs_path,n)

    files = dir(imgs_path); 
    j=1;
    for i=3:length(files)
            tmp = imread(strcat(imgs_path,'/',files(i).name));
            I{j}=double(tmp(:,:,1));
            I{j} = double(I{j});
            j=j+1;
    end
    k = (1/(n^2))*ones(n,n);

    for image=1:length(I)
       fprintf('Remove mean: %10d\r',image);
       temp = I{image};
       lmn = rconv2(temp,k);
       temp = temp - lmn;
       I{image} = temp;
    end
end