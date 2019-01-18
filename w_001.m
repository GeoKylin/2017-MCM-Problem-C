clear
close all
clc

a=0.99; %温度衰减函数的参数
t0=97;  tf=3;   t=t0;
Markov_length=10000;   %Markov链长度
amount=34;

tao=1.2;
t_safe=3;
Vmax=60;
load data;

sol_new=rand(1,amount);   %产生初始解
sol_new(7:30)=sol_new(7:30)*2/3;
sol_new(8)=1/3;    sol_new(10)=1/3;    sol_new(11)=1/3;    sol_new(12)=1/3;    sol_new(14)=1/3;
sol_new(15)=1/3;    sol_new(17)=1/3;    sol_new(18)=1/3;    sol_new(20)=1/3;    sol_new(22)=1/3;
sol_new(24)=1/3;    sol_new(26)=1/3;    sol_new(27)=1/3;    sol_new(28)=1/3;    sol_new(30)=1/3;    
alpha=sol_new(34);
lan=log(alpha+tao);
Qsdc=3600/t_safe;
Qnosdc=(Vmax*0.85)/(1/lan+Vmax*tao/3600);
Q=alpha*Qsdc+(1-alpha)*Qnosdc;
D=24*Q*All_num;
C=zeros(13,13);
C(1,2)=sol_new(1)-0.5;  C(1,3)=0.5-sol_new(1);
C(2,1)=sol_new(2)-0.5;  C(2,3)=0.5-sol_new(2); C(2,4)=sol_new(4)-0.5;  C(2,6)=0.5-sol_new(4);
C(3,1)=sol_new(3)-0.5;   C(3,2)=0.5-sol_new(3);   C(3,4)=sol_new(7)-0.5;   C(3,5)=sol_new(8)-0.5;   C(3,7)=0.5-sol_new(7)-sol_new(8);
C(4,2)=sol_new(5)-0.5;    C(4,3)=sol_new(9)-0.5;    C(4,5)=sol_new(10)-0.5;    C(4,6)=0.5-sol_new(5);    C(4,7)=0.5-sol_new(9)-sol_new(10);    
C(5,3)=sol_new(11)-0.5;    C(5,4)=sol_new(12)-0.5;    C(5,7)=0.5-sol_new(11)-sol_new(12);   
C(6,2)=sol_new(6)-0.5;    C(6,4)=0.5-sol_new(6);    C(6,8)=sol_new(15)-0.5;    C(6,9)=sol_new(16)-0.5;    C(6,11)=0.5-sol_new(15)-sol_new(16);    
C(7,3)=sol_new(13)-0.5;    C(7,4)=0.5-sol_new(13)-sol_new(14);    C(7,5)=sol_new(14)-0.5;    C(7,9)=sol_new(23)-0.5;    C(7,10)=sol_new(24)-0.5;    C(7,12)=0.5-sol_new(23)-sol_new(24);    
C(8,6)=sol_new(17)-0.5;    C(8,9)=sol_new(18)-0.5;    C(8,11)=0.5-sol_new(17)-sol_new(18);   
C(9,6)=sol_new(19)-0.5;    C(9,7)=sol_new(27)-0.5;    C(9,8)=sol_new(20)-0.5;    C(9,10)=sol_new(26)-0.5;    C(9,11)=0.5-sol_new(19)-sol_new(20);    C(9,12)=0.5-sol_new(26)-sol_new(27);    
C(10,7)=sol_new(27)-0.5;    C(10,9)=sol_new(28)-0.5;    C(10,12)=0.5-sol_new(27)-sol_new(28);    
C(11,6)=sol_new(21)-0.5;    C(11,8)=sol_new(22)-0.5;    C(11,9)=0.5-sol_new(21)-sol_new(22);    C(11,12)=sol_new(31)-0.5;    C(11,13)=0.5-sol_new(31);    
C(12,7)=sol_new(29)-0.5;    C(12,9)=0.5-sol_new(29)-sol_new(30);    C(12,10)=sol_new(30)-0.5;    C(12,11)=sol_new(32)-0.5;    C(12,13)=0.5-sol_new(32);    
C(13,11)=sol_new(33)-0.5;    C(13,12)=0.5-sol_new(33);   




sol_new(7:30)=sol_new(7:30)*2/3;
sol_new(8)=1/3;    sol_new(10)=1/3;    sol_new(11)=1/3;    sol_new(12)=1/3;    sol_new(14)=1/3;
sol_new(15)=1/3;    sol_new(17)=1/3;    sol_new(18)=1/3;    sol_new(20)=1/3;    sol_new(22)=1/3;
sol_new(24)=1/3;    sol_new(26)=1/3;    sol_new(27)=1/3;    sol_new(28)=1/3;    sol_new(30)=1/3;
alpha=sol_new(34);
lan=log(alpha+tao);
Qsdc=3600/t_safe;
Qnosdc=(Vmax*0.85)/(1/lan+Vmax*tao/3600);
Q=alpha*Qsdc+(1-alpha)*Qnosdc;
D=24*Q*All_num;
C=zeros(13,13);
C(1,2)=sol_new(1)-0.5;  C(1,3)=0.5-sol_new(1);
C(2,1)=sol_new(2)-0.5;  C(2,3)=0.5-sol_new(2); C(2,4)=sol_new(4)-0.5;  C(2,6)=0.5-sol_new(4);
C(3,1)=sol_new(3)-0.5;   C(3,2)=0.5-sol_new(3);   C(3,4)=sol_new(7)-0.5;   C(3,5)=sol_new(8)-0.5;   C(3,7)=0.5-sol_new(7)-sol_new(8);
C(4,2)=sol_new(5)-0.5;    C(4,3)=sol_new(9)-0.5;    C(4,5)=sol_new(10)-0.5;    C(4,6)=0.5-sol_new(5);    C(4,7)=0.5-sol_new(9)-sol_new(10);
C(5,3)=sol_new(11)-0.5;    C(5,4)=sol_new(12)-0.5;    C(5,7)=0.5-sol_new(11)-sol_new(12);
C(6,2)=sol_new(6)-0.5;    C(6,4)=0.5-sol_new(6);    C(6,8)=sol_new(15)-0.5;    C(6,9)=sol_new(16)-0.5;    C(6,11)=0.5-sol_new(15)-sol_new(16);
C(7,3)=sol_new(13)-0.5;    C(7,4)=0.5-sol_new(13)-sol_new(14);    C(7,5)=sol_new(14)-0.5;    C(7,9)=sol_new(23)-0.5;    C(7,10)=sol_new(24)-0.5;    C(7,12)=0.5-sol_new(23)-sol_new(24);
C(8,6)=sol_new(17)-0.5;    C(8,9)=sol_new(18)-0.5;    C(8,11)=0.5-sol_new(17)-sol_new(18);
C(9,6)=sol_new(19)-0.5;    C(9,7)=sol_new(27)-0.5;    C(9,8)=sol_new(20)-0.5;    C(9,10)=sol_new(26)-0.5;    C(9,11)=0.5-sol_new(19)-sol_new(20);    C(9,12)=0.5-sol_new(26)-sol_new(27);
C(10,7)=sol_new(27)-0.5;    C(10,9)=sol_new(28)-0.5;    C(10,12)=0.5-sol_new(27)-sol_new(28);
C(11,6)=sol_new(21)-0.5;    C(11,8)=sol_new(22)-0.5;    C(11,9)=0.5-sol_new(21)-sol_new(22);    C(11,12)=sol_new(31)-0.5;    C(11,13)=0.5-sol_new(31);
C(12,7)=sol_new(29)-0.5;    C(12,9)=0.5-sol_new(29)-sol_new(30);    C(12,10)=sol_new(30)-0.5;    C(12,11)=sol_new(32)-0.5;    C(12,13)=0.5-sol_new(32);
C(13,11)=sol_new(33)-0.5;    C(13,12)=0.5-sol_new(33);

wt(1:59)=wk(1:59)+sum(L(:,13).*C(:,13))*ones(1,59);
wt(60:71)=wk(60:71)+sum(L(:,11).*C(:,11))*ones(1,71-60+1);
wt(72:79)=wk(72:79)+sum(L(:,6).*C(:,6))*ones(1,79-72+1);
wt(80:103)=wk(80:103)+sum(L(:,2).*C(:,2))*ones(1,103-80+1);
wt(104:135)=wk(104:135)+sum(L(:,1).*C(:,1))*ones(1,135-104+1);
wt(136:140)=wk(136:140)+sum(L(:,8).*C(:,8))*ones(1,140-136+1);
wt(141:150)=wk(141:150)+sum(L(:,9).*C(:,9))*ones(1,150-141+1);
wt(151:162)=wk(151:162)+sum(L(:,10).*C(:,10))*ones(1,162-151+1);
wt(163:185)=wk(163:185)+sum(L(:,12).*C(:,12))*ones(1,185-163+1);
wt(186:191)=wk(186:191)+sum(L(:,7).*C(:,7))*ones(1,191-186+1);
wt(192:209)=wk(192:209)+sum(L(:,3).*C(:,3))*ones(1,209-192+1);
wt(210:219)=wk(210:219)+sum(L(:,4).*C(:,4))*ones(1,219-210+1);
wt(220:224)=wk(220:224)+sum(L(:,5).*C(:,5))*ones(1,5);
E=sum((wt-D).^2);