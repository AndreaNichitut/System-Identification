
clear all;
clc;
close all;
uval=[zeros(20,1); 0.3*ones(70,1); zeros(20,1)];
uid=idinput(200,'prbs',[],[-0.8 0.8]);

na=2;
nb=2;
N=200;
theta=zeros(na+nb,1);
P=1000*eye(na+nb,na+nb);

obj=DCMRun.start("Ts",0.01);

for k=1:length(uval)
yval(k)=obj.step(uval(k));
obj.wait();
end
%%
phi=zeros(na+nb,1);
for k=1:N
yid(k)=obj.step(uid(k));
    for j=1:na
       if(k-j<=0)
           phi(j)=0;
       else
           phi(j)=-yid(k-j);
       end
    end
    for j=1:nb
        if(k-j<=0)
            phi(j+na)=0;
        else
            phi(j+na)=uid(k-j);
        end
    end
   

e(k)=yid(k)-phi'*theta(:,k);
P=P-(P*phi*phi'*P)/(1+phi'*P*phi);
W=P*phi; %vector coloana na+nb
theta(:,k+1)=theta(:,k)+W*e(k);
obj.wait();
end
obj.stop();
%%

%plot(yid);
%figure
%plot(yval);

model1=idpoly([1; theta(1:na,end)]',[0; theta(1+na:na+nb,end)]',[],[],[],0,0.01);
model2=idpoly([1; theta(1:na,10)]',[0; theta(1+na:na+nb,10)]',[],[],[],0,0.01);

val=iddata(yval',uval,0.01);

figure
compare(val,model1);
title("comparatie pe intregul set de date");
figure
compare(val,model2);
title("comparatie pe 5% din date");