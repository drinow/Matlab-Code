close all;
clc
figure(1);
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('λ�ø���');
legend('ʵ���ź�','������');
figure(2);
plot(t,y(:,1)-y(:,2),'k','linewidth',2);
xlabel('time(s)');ylabel('λ�ø������');
legend('�������');
figure(3);
plot(t,ut(:,1),'k','linewidth',2);
xlabel('time(s)');ylabel('��������');