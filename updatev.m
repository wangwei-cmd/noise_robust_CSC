function [v1,v2,xix,xiy]=updatev(d,x,a1,a2,alpha,gammav)
[m,n,M]=size(x);
% dixi=zeros(m,n,M);
TH=alpha./gammav;

% TTH=zeros(m,n,M);
% for i=1:M
% %     dixi(:,:,i)=imfilter(x(:,:,i),rot90(d(:,:,i),2),'circular');
% %     dixi(:,:,i)=conv2(x(:,:,i),d(:,:,i),'same');
%     TTH(:,:,i)=TH(i);
% end

TTH=repmat(TH',[1,m,n]);
TTH=permute(TTH,[2,3,1]);


xix=ForwardX(x);
xiy=ForwardY(x);
t1=xix+a1;
t2=xiy+a2;
TH1=abs(t1)-TTH;
TH2=abs(t2)-TTH;
v1=sign(t1).*max(0,TH1);
v2=sign(t2).*max(0,TH2);