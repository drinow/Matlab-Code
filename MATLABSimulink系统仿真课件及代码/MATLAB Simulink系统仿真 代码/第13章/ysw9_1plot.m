close all;

figure(1);
plot(t,sin(t),'k',t,y(:,2),'r:','linewidth',2);
xlabel('time(s)');ylabel('λ�ø���');
legend('ʵ���ź�','������');


figure(2);
plot(t,cos(t),'k',t,y(:,3),'r:','linewidth',2);
xlabel('time(s)');ylabel('�ٶȸ���');
legend('ʵ���ź�','������');

figure(3);
plot(t,ut,'r','linewidth',2);
xlabel('time(s)');ylabel('��������');