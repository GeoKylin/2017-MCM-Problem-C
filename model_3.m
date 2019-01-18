clear
close all
clc

%% 模拟退火算法参数设置
a=0.99; %温度衰减函数的参数
t0=97;  tf=3;   t=t0;
Markov_length=1000;   %Markov链长度
amount=34;
tao=1.2;
t_safe=3;
Vmax=60;

%% 模型数据
load data;
wk=Aver_daily_n;
L=zeros(13,13);
L(1,2)=wk(104)/4;   L(1,3)=wk(104)/4;
L(2,1)=wk(103)/4;   L(2,3)=wk(103)/4;   L(2,4)=wk(80)/4;    L(2,6)=wk(80)/4;
L(3,1)=wk(209)/4;   L(3,2)=wk(209)/4;   L(3,4)=wk(192)/4;   L(3,5)=wk(192)/4;   L(3,7)=wk(192)/4;
L(4,2)=wk(210)/4;   L(4,3)=wk(219)/4;   L(4,5)=wk(219)/4;   L(4,6)=wk(210)/4;   L(4,7)=wk(219)/4;
L(5,:)=wk(220)/4*ones(1,13);
L(6,2)=wk(79)/4;    L(6,8:end)=wk(72)/4*ones(1,6);
L(7,1:5)=wk(191)/4*ones(1,5);   L(7,9:end)=wk(186)/4*ones(1,5);
L(8,:)=wk(140)/4*ones(1,13);
L(9,6)=wk(141)/4;   L(9,7)=wk(150)/4;   L(9,8)=wk(141)/4;   L(9,10)=wk(150)/4;  L(9,11)=wk(141)/4;  L(9,12)=wk(150)/4;
L(10,:)=wk(151)/4*ones(1,13);
L(11,1:9)=wk(72)/4*ones(1,9);   L(11,12:13)=wk(59)/4*ones(1,2);
L(12,1:10)=wk(185)/4*ones(1,10);    L(12,11:13)=wk(163)/4*ones(1,3);
L(13,:)=wk(60)/4*ones(1,13);

%% 模拟退火算法
sol_new=rand(1,amount);   %产生初始解
%sol_new是每次产生的新解；sol_current是当前解；sol_best是冷却中的最好解
E_current=inf;  E_best=inf;
%E_new是新解的回路距离
%E_best是最优解
sol_current=sol_new;    sol_best=sol_new;
p=1;
while t>=tf
    for r=1:Markov_length
        %产生随机扰动
        if rand<0.5 %随机决定是进行两交换还是三交换
            %两交换
            ind1=0; ind2=0;
            while ind1==ind2
                ind1=ceil(rand.*amount);    %向正无穷方向取整
                ind2=ceil(rand.*amount);
            end
            tmp1=sol_new(ind1);
            sol_new(ind1)=sol_new(ind2);
            sol_new(ind2)=tmp1;
        else
            %三交换
            ind1=0; ind2=0; ind3=0;
            while (ind1==ind2)||(ind1==ind3)||(ind2==ind3)||(abs(ind1-ind2)==1)
                ind1=ceil(rand.*amount);
                ind2=ceil(rand.*amount);
                ind3=ceil(rand.*amount);
            end
            tmp1=ind1;  tmp2=ind2;  tmp3=ind3;
            %确保ind1<ind2<ind3
            if (ind1<ind2)&&(ind2<ind3);
            elseif (ind1<ind3)&&(ind3<ind2)
                ind2=tmp3;  ind3=tmp2;
            elseif (ind2<ind1)&&(ind1<ind3)
                ind1=tmp2;  ind2=tmp1;
            elseif (ind2<ind3)&&(ind3<ind1)
                ind1=tmp2;  ind2=tmp3;  ind3=tmp1;
            elseif (ind3<ind1)&&(ind1<ind2)
                ind1=tmp3;  ind2=tmp1;  ind3=tmp2;
            elseif (ind3<ind2)&&(ind2<ind1)
                ind1=tmp3;  ind2=tmp2;  ind3=tmp1;
            end
            
            tmplist1=sol_new((ind1+1):(ind2-1));
            sol_new((ind1+1):(ind1+ind3-ind2+1))=sol_new(ind2:ind3);
            sol_new((ind1+ind3-ind2+2):ind3)=tmplist1;
        end
        
        %检查是否满足约束
        
        %计算目标函数值（即内能）
        E_new=0;
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
        
        wt(1:59)=wk(1:59)+sum(L(:,13).*C(:,13))*ones(1,59)';
        wt(60:71)=wk(60:71)+sum(L(:,11).*C(:,11))*ones(1,71-60+1)';
        wt(72:79)=wk(72:79)+sum(L(:,6).*C(:,6))*ones(1,79-72+1)';
        wt(80:103)=wk(80:103)+sum(L(:,2).*C(:,2))*ones(1,103-80+1)';
        wt(104:135)=wk(104:135)+sum(L(:,1).*C(:,1))*ones(1,135-104+1)';
        wt(136:140)=wk(136:140)+sum(L(:,8).*C(:,8))*ones(1,140-136+1)';
        wt(141:150)=wk(141:150)+sum(L(:,9).*C(:,9))*ones(1,150-141+1)';
        wt(151:162)=wk(151:162)+sum(L(:,10).*C(:,10))*ones(1,162-151+1)';
        wt(163:185)=wk(163:185)+sum(L(:,12).*C(:,12))*ones(1,185-163+1)';
        wt(186:191)=wk(186:191)+sum(L(:,7).*C(:,7))*ones(1,191-186+1)';
        wt(192:209)=wk(192:209)+sum(L(:,3).*C(:,3))*ones(1,209-192+1)';
        wt(210:219)=wk(210:219)+sum(L(:,4).*C(:,4))*ones(1,219-210+1)';
        wt(220:224)=wk(220:224)+sum(L(:,5).*C(:,5))*ones(1,5)';
        E_new=sum((wt-D').^2);
        
        if E_new<E_current
            E_current=E_new;
            D_current=D;
            wt_best=wt;
            C_best=C;
            sol_current=sol_new;
            if E_new<E_best
                %把冷却过程中最好的解保存下来
                E_best=E_new;
                sol_best=sol_new;
                D_best=D;
                wt_best=wt;
                C_best=C;
            end
        else
            %若新解的目标函数值小于当前解的，则仅以一定概率接收新解
            if rand<exp(-(E_new-E_current)./t)
                E_current=E_new;
                sol_current=sol_new;
                D_current=D;
                wt_best=wt;
                C_best=C;
            else
                sol_new=sol_current;
            end
        end
    end
    t=t.*a; %控制参数t（温度）减少为原来的a倍
end

%% 结果显示
disp('最优解为：')
disp(sol_best)
disp('最小误差平方和为：')
disp(E_best)
figure;plot(D_best,'r');hold on;plot(wt_best,'b')