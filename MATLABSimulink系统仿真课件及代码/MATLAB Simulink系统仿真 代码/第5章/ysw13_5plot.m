close all;
figure(1);
plot(t,y(:,1),'r',t,y(:,2),'k:','linewidth',2);
xlabel('time(s)');ylabel('yd,y');
legend('ʵ���ź�','������');
figure(2);
plot(t,y(:,1)-y(:,2),'r','linewidth',2);
xlabel('time(s)'),ylabel('���');
title('���')