close all;
clc,
figure(1);
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('λ�ø���');
legend('ʵ���ź�','������');
figure(2)
plot(t,cos(t),'k',t,y(:,3),'r:','linewidth',2);
xlabel('time(s)');ylabel('�ٶȸ���');
legend('ʵ���ź�','������');
figure(3);
plot(t,u(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('��������');
figure(4);
plot(t,s(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('�л�����');