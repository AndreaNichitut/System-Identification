clear all
clc
close all
load('Andrealab8.mat');

u=u4;
subplot(2,1,1);
plot(u);
subplot(2,1,2);
plot(vel);

Te=0.01;
N=200;
a=-0.7;
b=0.7;

alfa=0.1;
theta=[1;1];
pc=0.001;
l=0;
lmax=150;
nk=2;
f=theta(1);
bb=theta(2);

e=zeros(1,N);
df=zeros(N,1);
db=zeros(N,1);
de=zeros(N,2);
H=zeros(2,2);
gradientul=zeros(2,1);

yid=vel(1:210);
uid=u(1:210);

while 1

for k=1:nk
e(k)=yid(k);
df(k)=0;
db(k)=0;
end

for k=nk+1:N
e(k)=yid(k)+f*yid(k-1)-bb*uid(k-nk)-f*e(k-1);
df(k)=yid(k-1)-e(k-1)-f*df(k-1);
db(k)=-uid(k-nk)-f*db(k-1); 
end

de=[df db];

for i=1:2
for j=1:N
   gradientul(i)=gradientul(i)+e(j)*de(j,i);
end
   gradientul(i)=2/(N-nk)*gradientul(i);
end

for i=1:2
   for j=1:2
   for k=1:N
   H(i,j)=H(i,j)+de(k,i)*de(k,j)';
   end
   H(i,j)=2/(N-nk)*H(i,j);
   end
end

thetai=theta;
theta=thetai-alfa*H^(-1)*gradientul;
f=theta(1);
bb=theta(2);

l=l+1;

if l==lmax || norm(theta-thetai)<=pc
    break;
end

end

val=iddata(vel(211:end)',u(211:end)',Te);
model=idpoly(1,[zeros(1,nk) bb],1,1,[1 f],0,Te);
figure
compare(model,val);