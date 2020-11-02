clear
n=5;
syms lambda;
D=sym('d',[1,n]);
for i=1:n
    for j=1:n
        M(i,j)=D(i)*D(j);
        if j==i
            M(i,j)=lambda+M(i,j);
        end
    end
end
MM=inv(M);