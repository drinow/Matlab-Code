close all;
clc
figure(1);
plot(t,y(:,1),'r',t,y(:,3),'b','linewidth',2);
xlabel('time(s)');ylabel('λ�ø���');
legend('ʵ���ź�','������');
figure(2);
plot(t,y(:,2),'r',t,y(:,4),'b','linewidth',2);
xlabel('time(s)');ylabel('�ٶȸ���');
legend('ʵ���ź�','������');
figure(3);
plot(t,u(:,1),'r','linewidth',2);
xlabel('time(s)');ylabel('��������');