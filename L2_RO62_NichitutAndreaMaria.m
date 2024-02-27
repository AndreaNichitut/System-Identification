load('lab2_02.mat'); %incarcare fisier

%reprezentare date de identificare si validare
plot(id.X,id.Y);
hold on
plot(val.X,val.Y);
legend('identificare','validare');
title('Datele de identificare si validare');
xlabel('X');
ylabel('Y');
figure();

phi=[];
phi_val=[];
mseidv=[];
msevalv=[];

for n=1:25

for i=1:length(id.X)
    for j=1:n
    phi(i,j)=id.X(i)^(j-1);
    end
end

theta=phi\id.Y';
y_id=phi*theta;

for i=1:length(val.X)
    for j=1:n
    phi_val(i,j)=val.X(i)^(j-1);
    end
end

y_val=phi_val*theta;

MSEid=1/length(id.X)*sum((id.Y-y_id').^2);
MSEval=1/length(val.X)*sum((val.Y-y_val').^2);

%plot(MSEid);
%figure();
%plot(MSEval);

mseidv=[mseidv MSEid];
msevalv=[msevalv MSEval];

end

%reprezentare functie aproximata pentru setul de intrari de validare
plot(val.X,val.Y,val.X,y_val);
xlabel('X');
ylabel('Y');
title('Functia aproximata pentru setul de intrari de validare');
legend('validare','aproximare');
figure();

min(msevalv) %MSEval minimala
min(mseidv)  %MSEid minimala
[x,indx]=min(msevalv,[],'all','linear');
[y,indy]=min(mseidv,[],'all','linear');

%reprezentare valori MSE
plot([1:25],msevalv);
hold on
plot([1:25],mseidv);
hold on
plot(indx,x,'g*');
hold on
plot(indy,y,'b*');
title('Grafic al valorilor MSE');
legend('MSEval','MSEid');
xlabel('X');
ylabel('Y');




