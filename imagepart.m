function S=imagepart(S0,ratio)
[m,n,L]=size(S0);
assert(m==n);
inter=m/ratio;
S=zeros(inter,inter,L*ratio*ratio);
for i=1:L
    for j1=1:ratio-1
        for j2=1:ratio-1
    S(:,:,j2+(i-1)*ratio*ratio+(j1-1)*ratio)=S0(j1*inter:(j1+1)*inter-1,j2*inter:(j2+1)*inter-1,i);
        end
    end
end