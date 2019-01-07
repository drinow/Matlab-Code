%��У��PID���ƣ�����ϵͳ���������δ֪��
clear all; close all;

a=[1 -1.6065 0.6065]; b=[0.1065 0.0902]; d=3; Am=[1 -1.3205 0.4966]; %��������������ջ���������ʽ
na=length(a)-1; nb=length(b)-1; nam=length(Am)-1; %na��nb��nc��namΪ����ʽA��B��C��Am�״�
nf1=nb+d+2-(na+1)+1; ng=2; %nf1=nf+1

L=400; %���Ʋ���
uk=zeros(d+nb,1); %�����ֵ��uk(i)��ʾu(k-i)
yk=zeros(na,1); %�����ֵ
yr=10*[ones(L/4,1);-ones(L/4,1);ones(L/4,1);-ones(L/4,1)]; %�������
e=2*ones(L,1); %��ֵ����

%RLS��ֵ
thetae_1=0.001*ones(na+nb+1,1);
P=10^6*eye(na+nb+1);
lambda=1; %��������[0.9 1]
for k=1:L
    time(k)=k;
    y(k)=-a(2:na+1)*yk+b*uk(d:d+nb)+e(k); %�ɼ��������
    
    %������С���˷�
    phie=[-yk(1:na);uk(d:d+nb)];
    K=P*phie/(lambda+phie'*P*phie);
    thetae(:,k)=thetae_1+K*(y(k)-phie'*thetae_1);
    P=(eye(na+nb+1)-K*phie')*P/lambda;
    
    %��ȡ��ʶ����
    ae=[1 thetae(1:na,k)']; be=thetae(na+1:na+nb+1,k)';
    
    %����Diophantine���̣��õ�F��G��R
    [F,G]=diophantine(conv(ae,[1 -1]),be,d,1,Am); %A0=1
    F1=conv(F,[1 -1]); R=sum(G);
    
    u(k)=(-F1(2:nf1+1)*uk(1:nf1)+R*yr(k)-G*[y(k);yk(1:ng)])/F1(1);%�������
    
    %��������
    thetae_1=thetae(:,k);
    
    for i=d+nb:-1:2
        uk(i)=uk(i-1);
    end
    uk(1)=u(k);
    
    for i=na:-1:2
        yk(i)=yk(i-1);
    end
    yk(1)=y(k);
end
figure(1);
subplot(2,1,1);
plot(time,yr(1:L),'r:',time,y);
xlabel('k'); ylabel('y_r(k)��y(k)');
legend('y_r(k)','y(k)'); axis([0 L -20 20]);
subplot(2,1,2);
plot(time,u);
xlabel('k'); ylabel('u(k)'); axis([0 L -40 20]);
figure(2)
subplot(211)
plot([1:L],thetae(1:na,:));
xlabel('k'); ylabel('��������a');
legend('a_1','a_2'); axis([0 L -2 2]);
subplot(212)
plot([1:L],thetae(na+1:na+nb+1,:));
xlabel('k'); ylabel('��������b');
legend('b_0','b_1'); axis([0 L 0 0.15]);