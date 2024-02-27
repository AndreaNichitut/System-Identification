clear all
clc
close all
load('L9_AndreaNichitut_DataSet.mat');

subplot(2,1,1);
plot(u);
title('Date de intrare - motor');
xlabel('t');
ylabel('u');
subplot(2,1,2);
plot(vel);
title('Date de iesire - motor');
xlabel('t');
ylabel('vel');

Te=0.01;
N=300;
a=-0.8;
b=0.8;

na=2;
nb=2;
nk=1;

id=iddata(vel(1:306)',u(1:306)',Te);
val=iddata(vel(307:end)',u(307:end)',Te);
arx1=arx(id,[na nb nk]);
figure
compare(arx1,val);
title('Comparatie - arx&validare');
y_hat=compare(arx1,id);

%A=arx1.A;
%B=arx1.B;

%theta=[A B]';

yid=id.OutputData;
uid=id.InputData;

for i=1:N
for j=1:na+nb
    if(i-j<=0) 
        phi(i,j)=0;
    end
    if(i-j>0 && j<=na)
        phi(i,j)=-yid(i-j);
    else
        if (i-j+na>0 && j>na)
        phi(i,j)=uid(i-j-nk+na+1);
        end
    end
end
end

y_hat_arx=y_hat.OutputData;
for i=1:N
for j=1:na+nb
    if(i-j<=0) 
        z(i,j)=0;
    end
    if(i-j>0 && j<=na)
        z(i,j)=-y_hat_arx(i-j);
    else
        if (i-j+na>0 && j>na)
         z(i,j)=uid(i-j-nk+na+1);
        end
    end
end
end

phimare=zeros(na+nb,na+nb);
for i=1:na+nb
    for j=1:na+nb
for k=1:N
phimare(i,j)=phimare(i,j)+z(k,i)*phi(k,j)';
end
phimare(i,j)=1/N*phimare(i,j);
    end
end

Y=zeros(na+nb,1);
for i=1:na+nb
    for j=1:N
Y(i)=Y(i)+z(j,i)*yid(j);
    end
    Y(i)=1/N*Y(i);
end
 
theta=phimare\Y;
A=1;
A=[A theta(1:na)'];
B=zeros(1,nk);
B=[B theta(na+1:na+nb)'];

model=idpoly(A,B,1,1,1,0,Te);
figure
compare(model,val);
title('Comparatie - model&validare');
