clear all;
clc;
load('lab5_2.mat');
U=id.InputData;
Y=id.OutputData;
U=detrend(U);
Y=detrend(Y);

subplot(2,1,1);
plot(tid,U);
grid;
xlabel('t');
ylabel('U');
title('Grafic pentru datele de intrare (identificare)');
subplot(2,1,2);
plot(tid,Y);
grid;
xlabel('t');
ylabel('Y');
title('Grafic pentru datele de iesire (identificare)');

n=length(U);
ryu=zeros(n,1);
for tau=0:(n-1)
    s1=0;
    for k=1:(n-tau)
        s1=s1+(Y(k+tau)*U(k));
    end
    ryu(tau+1,1)=1/n*s1;
end

ru=zeros(n,1);
for tau=0:(n-1)
    s2=0;
    for k=1:(n-tau)
        s2=s2+(U(k+tau)*U(k));
    end
    ru(tau+1,1)=1/n*s2;
end

m=80;
rum=zeros(n,m);
for i=1:n
    for j=1:m
     if(i==j)
     rum(i,j)=ru(i);
     end
      if(j>i)
         rum(i,j)=ru(j-i+1);
      else 
          rum(i,j)=ru(i-j+1);
      end
    end
end

H=rum\ryu;
yaprox=conv(H,U);
figure();
plot(H);
title('Functia de transfer - H');
figure();
plot(Y);
hold on 
plot(yaprox);
title('Convolutia (yaprox)');
legend('Y','yaprox');

figure();
U2=val.InputData;
Y2=val.OutputData;
subplot(2,1,1);
plot(tval,U2);
grid;
xlabel('t');
ylabel('U');
title('Grafic pentru datele de intrare (validare)');
subplot(2,1,2);
plot(tval,Y2);
grid;
xlabel('t');
ylabel('Y');
title('Grafic pentru datele de iesire (validare)');

yaprox2=conv(H,U2);
figure();
plot(Y2);
hold on 
plot(yaprox2);
title('Convolutia (yaprox)');
legend('Y2','yaprox2');

%l=length(yaprox)-249;
%y3=yaprox(l:length(yaprox));
%MSE=1/length(U2)*sum(Y2-y3).^2;
%MSE=1/length(U2)*sum(Y2-yaprox2(80:329)).^2;
MSE=1/length(U2)*sum(Y2-yaprox2(1:250)).^2;

figure();
plot(H);
hold on
plot(imp);
title('H si imp');
legend('H','imp');