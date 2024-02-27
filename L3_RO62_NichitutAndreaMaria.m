clear all;
clc;

load('lab3_order1_2.mat'); %incarcare fisier
U=data.InputData;
Y=data.OutputData;

subplot(2,1,1);
plot(t,U);
grid;
xlabel('t');
ylabel('U');
title('Grafic pentru datele de intrare');
subplot(2,1,2);
plot(t,Y);
grid;
xlabel('t');
ylabel('Y');
title('Grafic pentru datele de iesire');

uss=data.InputData(1);
%y0=data.OutputData(1);
y0=0;
s=0;
for i=50:100
    s=s+Y(i);
end
yss=s/51;
K=(yss-y0)/uss
t2=y0+(yss-y0)*0.632;
%[t2,index]=min(abs(Y-t2));
t1=0;
t2=0.98;
T=t2-t1
%T=t(index)-t1
H=tf(K,[T 1])
yaprox=lsim(H,U,t);
yaproxx=lsim(H,U(201:500),t(201:500));
%MSE=1/length(U)*sum(Y-yaprox).^2; %valoare MSE pe tot
MSE=1/length(U(201:500))*sum(Y(201:500)-yaproxx).^2; %valoare MSE pe treptele 3-5

figure();
plot(t,Y,t,yaprox);
legend('sistem','model');
grid;
title('Grafic pentru sistemul de ordin 1');
xlabel('t');
ylabel('amplitudine');

%%
clear all;
clc;

load('lab3_order2_2.mat'); %incarcare fisier
U=data.InputData;
Y=data.OutputData;

subplot(2,1,1);
plot(t,U);
grid;
xlabel('t');
ylabel('U');
title('Grafic pentru datele de intrare');
subplot(2,1,2);
plot(t,Y);
grid;
xlabel('t');
ylabel('Y');
title('Grafic pentru datele de iesire');

uss=data.InputData(1);
%y0=data.OutputData(1);
y0=0;
s=0;
for i=50:100
    s=s+Y(i);
end
yss=s/51;
K=(yss-y0)/uss;
[ymax,indexmax]=max(Y);
t1=t(indexmax);
t2=y0+(yss-y0)*0.632;
T=t(42)-t1
M=(ymax-yss)/(yss-y0)
Z=(-log(M))/sqrt(pi^2+log(M)^2);
W=2*pi/(T*sqrt(1-Z^2));
H=tf(K*W^2,[1 2*Z*W W^2])
yaprox=lsim(H,U,t);
yaproxx=lsim(H,U(201:500),t(201:500));
%MSE=1/length(U)*sum(Y-yaprox).^2; %valoare MSE pe tot
MSE=1/length(U(201:500))*sum(Y(201:500)-yaproxx).^2; %valoare MSE pe treptele 3-5

figure();
plot(t,Y,t,yaprox);
legend('sistem','model');
grid;
title('Grafic pentru sistemul de ordin 2');
xlabel('t');
ylabel('amplitudine');







