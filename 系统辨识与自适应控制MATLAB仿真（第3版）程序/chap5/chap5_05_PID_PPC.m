%PID�������ÿ��ƣ�����ϵͳ�����������֪��
clear all; close all;

a=[1 -1.6065 0.6065]; b=[0.1065 0.0902]; d=3; Am=[1 -1.3205 0.4966]; %��������������ջ���������ʽ
na=length(a)-1; nb=length(b)-1; nam=length(Am)-1; %na��nb��nc��namΪ����ʽA��B��C��Am�״�
nf1=nb+d+2-(na+1)+1; ng=2; %nf1=nf+1

%���Diophantine���̣��õ�F��G��R
[F,G]=diophantine(conv(a,[1 -1]),b,d,1,Am); %A0=1
F1=conv(F,[1 -1]); R=sum(G);

L=400; %���Ʋ���
uk=zeros(d+nb,1); %�����ֵ��uk(i)��ʾu(k-i)
yk=zeros(na,1); %�����ֵ
yr=10*[ones(L/4,1);-ones(L/4,1);ones(L/4,1);-ones(L/4,1)]; %�������
e=2*ones(L,1); %��ֵ����

for k=1:L
    time(k)=k;
    y(k)=-a(2:na+1)*yk+b*uk(d:d+nb)+e(k); %�ɼ��������
    
   % u(k)=(-F1(2:nf1+1)*uk(1:nf1)+R*yr(k)-G*[y(k);yk(1:ng)])/F1(1); %�������
    u(k)=-[0.2860    0.3496   -0.8073   -0.8282]*uk(1:nf1)+0.8953*yr(k)-[11.2246  -15.8984    5.5691]*[y(k);yk(1:ng)];

    %��������
    for i=d+nb:-1:2
        uk(i)=uk(i-1);
    end
    uk(1)=u(k);
    
    for i=na:-1:2
        yk(i)=yk(i-1);
    end
    yk(1)=y(k);
end
subplot(2,1,1);
plot(time,yr(1:L),'r:',time,y);
xlabel('t'); ylabel('y_r(t)��y(t)');
legend('y_r(t)','y(t)');
subplot(2,1,2);
plot(time,u);
xlabel('t'); ylabel('u(t)');