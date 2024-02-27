clear all;
clc;

load('lab4_order1_2.mat'); %incarcare fisier
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
s=0;
for i=1:30
s=s+Y(i);
end
yss=s/30;
[ymax,indexmax]=max(Y(1:100));
t1=t(indexmax);
t2=yss+0.368*(ymax-yss);
T=t(45)-t1
K=yss/uss
H=tf(K,[T 1])
%[num,den]=tfdata(H,'v');
%[A,B,C,D]=tf2ss(num,den);
A=-1/T;
B=K/T;
C=1;
D=0;
H2=ss(A,B,C,D);

yaprox=lsim(H2,U,t,yss);
%MSE=1/length(U)*sum(Y-yaprox).^2; %MSE pe tot
MSE=1/length(U(131:330))*sum(Y(131:330)-yaprox(131:330)).^2; %MSE pe impulsul 2 si 3

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

load('lab4_order2_2.mat'); %incarcare fisier
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
s=0;
for i=1:30
s=s+Y(i);
end
yss=s/30;
%yss=data.OutputData(1);
[ymax,indexmax]=max(Y(1:100));
t1=t(indexmax);
t2=yss+0.368*(ymax-yss);
T=t(62)-t1
K=yss/uss;
Ts=t(4)-t(3);
A1=Ts*sum(Y(31:44)-yss);
A2=Ts*sum(yss-Y(44:56));
M=A2/A1
Z=-log(M)/sqrt(pi^2+log(M)^2);
W=2*pi/(T*sqrt(1-Z^2));
H=tf(K*W^2,[1 2*Z*W W^2])
A=[0 1;-W^2 -2*Z*W];
B=[0;K*W^2];
C=[1 0];
D=0;
H2=ss(A,B,C,D);

yaprox=lsim(H2,U,t,[yss 0]);
%MSE=1/length(U)*sum(Y-yaprox).^2; %MSE pe tot
MSE=1/length(U(131:330))*sum(Y(131:330)-yaprox(131:330)).^2; %MSE pe impulsul 2 si 3

figure();
plot(t,Y,t,yaprox);
legend('sistem','model');
grid;
title('Grafic pentru sistemul de ordin 2');
xlabel('t');
ylabel('amplitudine');