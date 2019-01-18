clear
close all
clc

load data;
a=0:0.01:1;
tao=1.2;
t_safe=3;
Vmax=60;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%    1   %%%%%%%%%%%%%%%%%%%%%%%%%
Qsdc=3600/t_safe;
k=0;
for i=0:0.01:1
    k=k+1;
    a(k)=i;
    lan(k)=log(a(k)+tao);
    Qnosdc(k)=(Vmax*0.85)/(1/lan(k)+Vmax*tao/3600);
    Q(k)=a(k)*Qsdc+(1-a(k))*Qnosdc(k);
    D=24*Q(k)*All_num(1:135);
    E=Aver_daily_n(1:135)-D;
    S(k)=sum(E.^2);
end
% plot(a,Q);
% xlabel('alpha');ylabel('Q')
% figure;plot(a,S)
% xlabel('SDC车所占的比例\alpha');ylabel('通行量与通行能力的误差平方和f');
% title('f(\alpha)关系曲线')
% 
S1=[0 S(1:end-1)];
SS=S-S1;
figure;subplot(2,2,1);
plot(a(2:end),SS(2:end));grid on;   %76.7%   55.8%   85.6%   60.3%
xlabel('\alpha_1');ylabel('\partialF/\partial\alpha_1');
%%%%%%%%%%%%%%%%%%%%%%%%%   2   %%%%%%%%%%%%%%%%%%%%%%%%
k=0;
for i=0:0.01:1
    k=k+1;
    a(k)=i;
    lan(k)=log(a(k)+tao);
    Qnosdc(k)=(Vmax*0.85)/(1/lan(k)+Vmax*tao/3600);
    Q(k)=a(k)*Qsdc+(1-a(k))*Qnosdc(k);
    D=24*Q(k)*All_num(136:162);
    E=Aver_daily_n(136:162)-D;
    S(k)=sum(E.^2);
end
% plot(a,Q);
% xlabel('alpha');ylabel('Q')
% figure;plot(a,S)
% xlabel('SDC车所占的比例\alpha');ylabel('通行量与通行能力的误差平方和f');
% title('f(\alpha)关系曲线')
% 
S1=[0 S(1:end-1)];
SS=S-S1;
subplot(2,2,2);plot(a(2:end),SS(2:end));grid on;   %76.7%   55.8%   85.6%   60.3%
xlabel('\alpha_2');ylabel('\partialF/\partial\alpha_2');
%%%%%%%%%%%%%%%%%%%%%%%%%%  3   %%%%%%%%%%%%%%%%%%%%%%%%%%
k=0;
for i=0:0.01:1
    k=k+1;
    a(k)=i;
    lan(k)=log(a(k)+tao);
    Qnosdc(k)=(Vmax*0.85)/(1/lan(k)+Vmax*tao/3600);
    Q(k)=a(k)*Qsdc+(1-a(k))*Qnosdc(k);
    D=24*Q(k)*All_num(163:209);
    E=Aver_daily_n(163:209)-D;
    S(k)=sum(E.^2);
end
% plot(a,Q);
% xlabel('alpha');ylabel('Q')
% figure;plot(a,S)
% xlabel('SDC车所占的比例\alpha');ylabel('通行量与通行能力的误差平方和f');
% title('f(\alpha)关系曲线')
% 
S1=[0 S(1:end-1)];
SS=S-S1;
subplot(2,2,3);plot(a(2:end),SS(2:end));grid on;   %76.7%   55.8%   85.6%   60.3%
xlabel('\alpha_3');ylabel('\partialF/\partial\alpha_3');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   4   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k=0;
for i=0:0.01:1
    k=k+1;
    a(k)=i;
    lan(k)=log(a(k)+tao);
    Qnosdc(k)=(Vmax*0.85)/(1/lan(k)+Vmax*tao/3600);
    Q(k)=a(k)*Qsdc+(1-a(k))*Qnosdc(k);
    D=24*Q(k)*All_num(210:224);
    E=Aver_daily_n(210:224)-D;
    S(k)=sum(E.^2);
end
% plot(a,Q);
% xlabel('alpha');ylabel('Q')
% figure;plot(a,S)
% xlabel('SDC车所占的比例\alpha');ylabel('通行量与通行能力的误差平方和f');
% title('f(\alpha)关系曲线')
% 
S1=[0 S(1:end-1)];
SS=S-S1;
subplot(2,2,4);plot(a(2:end),SS(2:end));grid on;   %76.7%   55.8%   85.6%   60.3%
xlabel('\alpha_4');ylabel('\partialF/\partial\alpha_4');

a1=0.767;
a2=0.558;
a3=0.856;
a4=0.603;

lan1=log(a1+tao);   lan2=log(a2+tao);   lan3=log(a3+tao);   lan4=log(a4+tao);
Qnosdc1=(Vmax*0.85)/(1/lan1+Vmax*tao/3600);
Q1=a1*Qsdc+(1-a1)*Qnosdc1;
Qnosdc2=(Vmax*0.85)/(1/lan2+Vmax*tao/3600);
Q2=a2*Qsdc+(1-a2)*Qnosdc2;
Qnosdc3=(Vmax*0.85)/(1/lan3+Vmax*tao/3600);
Q3=a3*Qsdc+(1-a3)*Qnosdc3;
Qnosdc4=(Vmax*0.85)/(1/lan4+Vmax*tao/3600);
Q4=a4*Qsdc+(1-a4)*Qnosdc4;
D=[24*Q1*All_num(1:135);24*Q2*All_num(136:162);...
    24*Q3*All_num(163:209);24*Q4*All_num(210:224)];
figure;plot(D,'r');hold on;plot(Aver_daily_n,'b');
xlabel('数据采集点n');ylabel('通行能力和通行量');
title('\alpha1=76.7% \alpha2=55.8% \alpha3=85.6% \alpha4=60.3%')