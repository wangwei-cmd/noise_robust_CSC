function ne=calnorm(d)
M=size(d,3);
for i=1:M
    ne(i)=norm(d(:,:,i),'fro');
end