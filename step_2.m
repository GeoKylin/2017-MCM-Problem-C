clear
close all
clc

load data;  load pre;
% figure;plot(Aver_daily_n);hold on;plot(math3_daily_n)
% grid on;
% figure;plot(start_M(1:135),Aver_daily_n(1:135));
% hold on;plot(start_M(1:135),math3_daily_n(1:135))
% grid on;
figure;plot(start_M(136:162),Aver_daily_n(136:162));
hold on;plot(start_M(136:162),math3_daily_n(136:162))
grid on;title('I-90');
% figure;plot(start_M(163:209),Aver_daily_n(163:209));
% hold on;plot(start_M(163:209),math3_daily_n(163:209))
% grid on;
% figure;plot(start_M(210:224),Aver_daily_n(210:224));
% hold on;plot(start_M(210:224),math3_daily_n(210:224))
% grid on;
% 
% alpha=0.5;
% Vmax=60;
% t_safe=3;   t_man=5;
% Tsdc=Vmax^2/t_safe; Tnosdc=Vmax^2/t_man;
% model_per_n=alpha*Tsdc+(1-alpha)*Tnosdc;
% model_daily_n=24*model_per_n*All_num;
% figure;plot(Aver_daily_n);hold on;plot(model_daily_n)
% grid on;
% 
am=(sum(All_num(136:162).*(Aver_daily_n(136:162)-24*720*All_num(136:162))))/...
    (sum(24*480*All_num(136:162).^2));
if am<0
    am=0
else am>1
    am=1
end
alpha=am;
Vmax=60;
t_safe=3;   t_man=5;
Tsdc=Vmax^2/t_safe; Tnosdc=Vmax^2/t_man;
model_per_n=alpha*Tsdc+(1-alpha)*Tnosdc;
model_daily_n=24*model_per_n*All_num(136:162);
figure;plot(start_M(136:162),Aver_daily_n(136:162));
hold on;plot(start_M(136:162),model_daily_n)
grid on;title('I-90');



t_peak=1.6;
Aver_peak_n=Aver_daily_n*0.08*24/t_peak;
figure;plot(Aver_peak_n(136:162));hold on;plot(math3_daily_n(136:162))
grid on;title('I-90');

am_p=(sum(All_num(136:162).*(Aver_peak_n(136:162)-24*720*All_num(136:162))))/...
    (sum(24*480*All_num(136:162).^2))
if am_p<0
    am_p=0
elseif am_p>1
    am_p=1
end
alpha=am_p;
Vmax=60;
t_safe=3;   t_man=5;
Tsdc=Vmax^2/t_safe; Tnosdc=Vmax^2/t_man;
model_per_n=alpha*Tsdc+(1-alpha)*Tnosdc;
model_peak_n=24*model_per_n*All_num(136:162);
figure;plot(start_M(136:162),Aver_peak_n(136:162));
hold on;plot(start_M(136:162),model_peak_n)
grid on;title('I-90');