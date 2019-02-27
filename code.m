clc
clear all
close all
a=imread('D:/sree/matlab excersises/sem2/signal/imageclr/lena_color.jpg');
a=im2double(a);
b=imread('img_mask.tif');
%b=im2double(b);
%b=imresize(b,[512,512]);
b=imresize(b,[225,225]);
for i=1:3
   t=a(:,:,i);
t(b~=1)=b(b~=1);
c(:,:,i)=t;
end
figure
imshow(c);
m=b;
m=m(:);
for w=1:3
u0=c(:,:,w);    
u0(m(:,1)==0)=NaN;
u0=reshape(u0,225,225);
u1=[];
for j=1:225
    y=u0(j,:)';
    n=length(y);
    k=isfinite(y);
    S=speye(n);
    S(~k,:)=[];
    Sc=speye(n);
    Sc(k,:)=[];
    e=ones(n,1);
    d=spdiags([e -2*e e],0:2,n-2,n);
    S=full(S);
    Sc=full(Sc);
    v=-pinv([Sc*d'*d*Sc'])*(Sc*d'*d*S'*y(k));
    x=zeros(n,1);
    x(k)=y(k);
    x(~k)=v;
    u1=[u1;x'];
end
u2=[];
for j=1:225
    y=u0(:,j);
    n=length(y);
    k=isfinite(y);
    S=speye(n);
    S(~k,:)=[];
    Sc=speye(n);
    Sc(k,:)=[];
    e=ones(n,1);
    d=spdiags([e -2*e e],0:2,n-2,n);
    S=full(S);
    Sc=full(Sc);
    v=-pinv([Sc*d'*d*Sc'])*(Sc*d'*d*S'*y(k));
    x=zeros(n,1);
    x(k)=y(k);
    x(~k)=v;
    u2=[u2 x];
end
u=(u1+u2)./2;
f(:,:,w)=u;
end
figure
imshow(f)