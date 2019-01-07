%��������ֱ����У������ ����С��λȷ����ϵͳ��
clear all; close all;

a=[1 -2 1.1]; b=[1 0.5]; d=3; Am=[1 -1.3 0.5]; %��������������ջ���������ʽ
na=length(a)-1; nb=length(b)-1; nam=length(Am)-1; %na��nb��namΪ����ʽA��B��Am�״�
nf=nb+d-1; ng=na-1; %F��G�Ľ״�

%ȷ������ʽA0
na0=2*na-nam-nb-1; %�۲�����ͽ״�
A0=1;
for i=1:na0
    A0=conv(A0,[1 0.3-i*0.1]);%���ɹ۲���
end
AA=conv(A0,Am); naa=na0+nam; %A0*Am
nfg=max(naa,max(nf,ng)); %����ufk��yuf����
nr=na0; %R�Ľ״�

L=400; %���Ʋ���
uk=zeros(d+nb,1); %�����ֵ��uk(i)��ʾu(k-i)
ufk=zeros(d+nfg,1); %�˲������ֵ
yk=zeros(max(na,d),1); %�����ֵ
yfk=zeros(d+nfg,1); %�˲������ֵ
yrk=zeros(max(na,d),1); %���������ֵ
yr=10*[ones(L/4,1);-ones(L/4,1);ones(L/4,1);-ones(L/4+d,1)]; %�������

%RLS��ֵ
thetae_1=0.001*ones(nf+ng+2,1);
P=10^6*eye(nf+ng+2);
lambda=1; %��������[0.9 1]
for k=1:L
    time(k)=k;
    y(k)=-a(2:na+1)*yk(1:na)+b*uk(d:d+nb); %�ɼ��������
    ufk(d)=-AA(2:naa+1)*ufk(d+1:d+naa)+uk(d); %�˲��������
    yfk(d)=-AA(2:naa+1)*yfk(d+1:d+naa)+yk(d);
    
    %������С���˷�
    phie=[ufk(d:d+nf);yfk(d:d+ng)];
    K=P*phie/(lambda+phie'*P*phie);
    thetae(:,k)=thetae_1+K*(y(k)-phie'*thetae_1);
    P=(eye(nf+ng+2)-K*phie')*P/lambda;
    
    %��ȡ��ʶ����
    be0=thetae(1,k); thetaeb(:,k)=thetae(:,k)/be0;
    Fe=thetaeb(1:nf+1,k)'; Ge=thetaeb(nf+2:nf+ng+2,k)';
        
    Bm1=sum(Am)/be0; %Bm'
    R=Bm1*A0;
    
    u(k)=(-Fe(2:nf+1)*uk(1:nf)+R*[yr(k+d:-1:k+d-min(d,nr));yrk(1:nr-d)]-Ge*[y(k);yk(1:ng)])/Fe(1); %������
    
    %��������
    thetae_1=thetae(:,k);
    
    for i=d+nb:-1:2
        uk(i)=uk(i-1);
    end
    uk(1)=u(k);
    
    for i=max(na,d):-1:2
        yk(i)=yk(i-1);
        yrk(i)=yrk(i-1);
    end
    yk(1)=y(k);
    yrk(1)=yr(k);
    
    for i=d+nfg:-1:d+1
        ufk(i)=ufk(i-1);
        yfk(i)=yfk(i-1);
    end
end
figure(1);
subplot(2,1,1);
plot(time,yr(1:L),'r:',time,y);
xlabel('k'); ylabel('y_r(k)��y(k)');
legend('y_r(k)','y(k)'); axis([0 L -20 20]);
subplot(2,1,2);
plot(time,u);
xlabel('k'); ylabel('u(k)'); axis([0 L -5 5]);
figure(2)
plot([1:L],thetaeb(2:nf+ng+2,:));
xlabel('k'); ylabel('��������f��g');
legend('f_1','f_2','f_3','g_0','g_1'); axis([0 L -1 1.5]);

