%��С��������У������
clear all; close all;

a=[1 -1.7 0.7]; b=[1 0.5]; c=[1 0.2]; d=4; %�������
na=length(a)-1; nb=length(b)-1; nc=length(c)-1; %na��nb��ncΪ����ʽA��B��C�״�
nf=nb+d-1; %nfΪ����ʽF�Ľ״�

L=400; %���Ʋ���
uk=zeros(d+nb,1); %�����ֵ��uk(i)��ʾu(k-i);
yk=zeros(na,1); %�����ֵ
yrk=zeros(nc,1); %���������ֵ
xik=zeros(nc,1); %��������ֵ
xiek=zeros(nc,1); %���������Ƴ�ֵ
yr=10*[ones(L/4,1);-ones(L/4,1);ones(L/4,1);-ones(L/4+d,1)]; %�������
xi=sqrt(0.1)*randn(L,1); %����������

%RELS��ֵ����
thetae_1=0.001*ones(na+nb+1+nc,1); %�ǳ�С�����������ﲻ��Ϊ0��
P=10^6*eye(na+nb+1+nc);
for k=1:L
    time(k)=k;
    y(k)=-a(2:na+1)*yk+b*uk(d:d+nb)+c*[xi(k);xik]; %�ɼ��������
        
    %����������С���˷�
    phie=[-yk;uk(d:d+nb);xiek];
    K=P*phie/(1+phie'*P*phie);
    thetae(:,k)=thetae_1+K*(y(k)-phie'*thetae_1);
    P=(eye(na+nb+1+nc)-K*phie')*P;
    
    xie=y(k)-phie'*thetae(:,k); %�������Ĺ���ֵ
    
    %��ȡ��ʶ����
    ae=[1 thetae(1:na,k)']; be=thetae(na+1:na+nb+1,k)'; ce=[1 thetae(na+nb+2:na+nb+1+nc,k)'];
    if abs(be(2))>0.9
        be(2)=sign(ce(2))*0.9; %MVC�㷨Ҫ��B�ȶ�
    end
    if abs(ce(2))>0.9
        ce(2)=sign(ce(2))*0.9;
    end
    
    [e,f,g]=sindiophantine(ae,be,ce,d); %��ⵥ��Diophantine����        
    u(k)=(-f(2:nf+1)*uk(1:nf)+ce*[yr(k+d:-1:k+d-min(d,nc));yrk(1:nc-d)]-g*[y(k);yk(1:na-1)])/f(1); %�������
    
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
    
    for i=nc:-1:2
        yrk(i)=yrk(i-1);
        xik(i)=xik(i-1);
        xiek(i)=xiek(i-1);
    end
    if nc>0
        yrk(1)=yr(k);
        xik(1)=xi(k);
        xiek(1)=xie;
    end
end
figure(1);
subplot(2,1,1);
plot(time,yr(1:L),'r:',time,y);
xlabel('k'); ylabel('y_r(k)��y(k)');
legend('y_r(k)','y(k)'); axis([0 L -20 20]);
subplot(2,1,2);
plot(time,u);
xlabel('k'); ylabel('u(k)'); axis([0 L -40 40]);
figure(2)
subplot(211)
plot([1:L],thetae(1:na,:));
xlabel('k'); ylabel('��������a');
legend('a_1','a_2'); axis([0 L -3 2]);
subplot(212)
plot([1:L],thetae(na+1:na+nb+1+nc,:));
xlabel('k'); ylabel('��������b��c');
legend('b_0','b_1','c_1'); axis([0 L 0 1.5]);