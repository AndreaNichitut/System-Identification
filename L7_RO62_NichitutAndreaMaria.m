clear all
clc
close all
load('Andrealab7.mat');

N=200;
a=-0.7;
b=0.7;
mid=3;
mval=10;

[u1,P]=SPAB1(N,mid,a,b);
figure();
plot(u1);
title('spab - 3 biti');

[u2,P]=SPAB2(N,mval,a,b);
figure();
plot(u2);
title('spab - 10 biti');

u3=[zeros(1,100),u1,zeros(1,100),u2,zeros(1,100),0.4*ones(1,70)];
figure();
plot(u3);
title('SPAB');

figure;
subplot(2,1,1);
plot(vel);
title('date motor - iesire');
subplot(2,1,2);
plot(u);
title('date motor - intrare');

na=6;
nb=7;
nk=1;

vel=vel';
id1=iddata(vel(11:220),u(11:220),0.01);
id2=iddata(vel(221:430),u(221:430),0.01);
val=iddata(vel(431:end),u(431:end),0.01);

model1=arx(id1,[na nb nk]);
model2=arx(id2,[na nb nk]);

figure;
compare(model1,val);
figure;
compare(model2,val);

%u3=[zeros(1,100),u1,zeros(1,100),u2,zeros(1,100),0.4*ones(1,70)];
%[vel,alpha,t]=run(u3,'7',0.01);
%plot(t,vel);

function [U,P]=SPAB1(N,mid,a,b)
    P = 2^mid - 1;
    Aid=[1 0 1];
    x = zeros(N, mid);
    x(1,1)=1;
    x(1,2:end)=0;
    Aprim=zeros(mid,mid);
    Aprim(1, :) = Aid;
    Aprim(2:mid,:)=eye(mid-1,mid);
    U=zeros(1,N);
   for i=1:(N-1)
            x(i+1,:)=mod(Aprim*x(i,:)',2);
        U(i)=x(i,mid);
    end
    U(mid)=x(N,mid);
for i=1:N-1
 U(i)=a+(b-a)*U(i);
end
end

function [U,P]=SPAB2(N,mval,a,b)
    P = 2^mval - 1;
    Aid=[0 0 1 0 0 0 0 0 0 1];
    x = zeros(N, mval);
    x(1,1)=1;
    x(1,2:end)=0;
    Aprim=zeros(mval,mval);
    Aprim(1, :) = Aid;
    Aprim(2:mval,:)=eye(mval-1,mval);
    U=zeros(1,N);
   for i=1:(N-1)
            x(i+1,:)=mod(Aprim*x(i,:)',2);
        U(i)=x(i,mval);
    end
    U(mval)=x(N,mval);
for i=1:N-1
 U(i)=a+(b-a)*U(i);
end
end