clear
close all
clc

load data;
t_peak=1.6;
Aver_peak_n=Aver_daily_n*0.08*24/t_peak;
tao=1.2;
t_safe=3;
Vmax=60;

Qsdc=3600/t_safe;
k=0;
for i=0:0.01:1
    k=k+1;
    a(k)=i;
    lan(k)=log(a(k)+tao);
    Qnosdc(k)=(Vmax*0.85)/(1/lan(k)+Vmax*tao/3600);
    Q(k)=a(k)*Qsdc+(1-a(k))*Qnosdc(k);
    D=24*Q(k)*All_num;
    E=Aver_peak_n-D;
    S(k)=sum(E.^2);
end
% plot(a,Q);
% xlabel('alpha');ylabel('Q')
figure;plot(a,S)
xlabel('\alpha');ylabel('F(\alpha)');grid on;

% S1=[0 S(1:end-1)];
% SS=S-S1;
% plot(a(2:end),SS(2:end));grid on;   %90.5%

a=0.905;
lan=log(a+tao);
Qnosdc=(Vmax*0.85)/(1/lan+Vmax*tao/3600);
Q=a*Qsdc+(1-a)*Qnosdc;
D=24*Q*All_num;
figure;plot(D,'r');hold on;plot(Aver_peak_n,'b');
xlabel('n');ylabel('T_{peak}&D');grid on;
title('\alpha=90.5%');legend('D','T_{peak}')