clc,close all
figure(1);
l = length(simout1);
t = 0:10/(l-1):10;
plot(t,simout1(:,1),'r','linewidth',2)
hold on
plot(t,simout1(:,2),'g','linewidth',2)
plot(t,simout1(:,3),'b','linewidth',2)
legend('��ǰ���ֱ������Ƶ�4WSϵͳ','2WSϵͳ','��ڽ��ٶȷ�����4WSϵͳ')
figure(2),
plot(t,simout2(:,1),'r','linewidth',2)
hold on
plot(t,simout2(:,2),'b','linewidth',2)
legend('��ڽ��ٶȷ�����4WSϵͳ','2WSϵͳ')
%%
clc,close all
figure(1);
l = length(simout1);
t = 0:10/(l-1):10;
plot(t,simout1(:,1),'r','linewidth',2)
hold on
plot(t,simout1(:,2),'g','linewidth',2)
plot(t,simout1(:,3),'b','linewidth',2)
legend('��ǰ���ֱ������Ƶ�4WSϵͳ','2WSϵͳ','��ڽ��ٶȷ�����4WSϵͳ')
figure(2),
plot(t,simout2(:,1),'r','linewidth',2)
hold on
plot(t,simout2(:,2),'b','linewidth',2)
legend('��ڽ��ٶȷ�����4WSϵͳ','2WSϵͳ')




