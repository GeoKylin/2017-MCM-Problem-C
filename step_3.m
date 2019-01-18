clear
close all
clc

load data;
tao=1.2;
t_safe=3;
Vmax=60;

for a=0:0.1:1
    lan=log(a+tao);
    b=a^(1/2)+a^(-1/2);
    Qsdc=3600/t_safe;
    Qnosdc=(Vmax*0.85)/(1/lan+Vmax*tao/3600);
    Q=a*Qsdc+(1-a)*Qnosdc;
    D=24*Q*All_num;
    figure;plot(D,'r');hold on;plot(Aver_daily_n,'b')
end