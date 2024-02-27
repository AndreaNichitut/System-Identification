clear all;
clc;
load('Andrea.mat');

subplot(2,1,1);
plot(u);
grid;
xlabel('t');
ylabel('u');
title('Grafic pentru datele de intrare');
subplot(2,1,2);
plot(t,speed);
grid;
xlabel('t');
ylabel('y');
title('Grafic pentru datele de iesire');

yid=speed(10:211);
yval=speed(220:290);
uid=u(10:211);
uval=u(220:290);

na=5;
nb=5;
n1=length(uid);
for i=0:(n1-1)
    for j=0:(na+nb-1)
    if(i-j<=0) 
        phi(i+1,j+1)=0;
    end
    if(i-j>0 && j<=na-1)
        phi(i+1,j+1)=-yid(i-j);
    else
        if(i-j+na-1>0 && j>na-1)
        phi(i+1,j+1)=uid(i-j+na);
        end
    end
    end
end

theta=phi\yid';

ypred=phi*theta;

figure();
plot(yid);
hold on
plot(ypred);
legend('yid','ypred');
title('predictie pt identificare');


for i=0:(length(uval)-1)
    for j=0:(na+nb-1)
    if(i-j<=0) 
        phival(i+1,j+1)=0;
    end
    if(i-j>0 && j<=na-1)
        phival(i+1,j+1)=-yval(i-j);
    else
        if(i-j+na-1>0 && j>na-1)
        phival(i+1,j+1)=uval(i-j+na);
        end
    end
    end
end

ypred2=phival*theta;

figure();
plot(yval);
hold on
plot(ypred2);
legend('yval','ypred2');
title('predictie pt validare');

%simulare
n2=length(uval);
sl=zeros(n2,1);
for i=0:(n2-1)
for j=0:(na+nb-1)
    if(i-j>0 && j<=na-1)
    sl(i+1)=sl(i+1)+(-sl(i-j)*theta(j+1));
    else
        if(i-j+na-1>0 && j>na-1)
        sl(i+1)=sl(i+1)+uval(i-j+na)*theta(j+1);
        end
    end
end
end

figure();
plot(yval);
hold on
plot(sl);
legend('yval','Y');
title('simulare');

mse=1/n2*sum(yval-sl').^2;
