%��С������ƣ�MVC��
clear all; close all;

a=[1 -1.7 0.7]; b=[1 0.5]; c=[1 0.2]; d=4; %�������
na=length(a)-1; nb=length(b)-1; nc=length(c)-1; %na��nb��ncΪ����ʽA��B��C�״�
nf=nb+d-1; %nfΪ����ʽF�Ľ״�

L=400; %���Ʋ���
uk=zeros(d+nb,1); %�����ֵ��uk(i)��ʾu(k-i);
yk=zeros(na,1); %�����ֵ
yrk=zeros(nc,1); %���������ֵ
xik=zeros(nc,1); %��������ֵ
yr=10*[ones(L/4,1);-ones(L/4,1);ones(L/4,1);-ones(L/4+d,1)]; %�������
xi=sqrt(0.1)*randn(L,1); %����������

[e,f,g]=sindiophantine(a,b,c,d); %��ⵥ��Diophantine����
for k=1:L
    time(k)=k;
    y(k)=-a(2:na+1)*yk+b*uk(d:d+nb)+c*[xi(k);xik];%�ɼ��������
           
    u(k)=(-f(2:nf+1)*uk(1:nf)+c*[yr(k+d:-1:k+d-min(d,nc));yrk(1:nc-d)]-g*[y(k);yk(1:na-1)])/f(1);%�������
    
    %��������
    for i=d+nb:-1:2
        uk(i)=uk(i-1);
    end
    uk(1)=u(k);
    
    for i=na:-1:2
        yk(i)=yk(i-1);
    end
    yk(1)=y(k);
    
    for i=nc:-1:2
        yrk(i)=yrk(i-1);
        xik(i)=xik(i-1);
    end
    if nc>0
        yrk(1)=yr(k);
        xik(1)=xi(k);
    end
end
subplot(2,1,1);
plot(time,yr(1:L),'r:',time,y);
xlabel('k'); ylabel('y_r(k)��y(k)');
legend('y_r(k)','y(k)');
subplot(2,1,2);
plot(time,u);
xlabel('k'); ylabel('u(k)');