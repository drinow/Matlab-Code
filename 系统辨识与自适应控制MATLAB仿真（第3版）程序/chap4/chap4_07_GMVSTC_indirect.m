%������С������У�����ƣ�����㷨��
clear all; close all;

a=[1 -1.7 0.7]; b=[1 2]; c=[1 0.2]; d=4; %�������
na=length(a)-1; nb=length(b)-1; nc=length(c)-1; %na��nb��ncΪ����ʽA��B��C�״�
nf=nb+d-1; ng=na-1; %nf��ngΪ����ʽF��G�Ľ״�

Pw=1; R=1; Q=2; %��Ȩ����ʽP��R��Q
np=length(Pw)-1; nr=length(R)-1; nq=length(Q)-1;

L=400; %���Ʋ���
uk=zeros(d+nb,1); %�����ֵ��uk(i)��ʾu(k-i);
yk=zeros(na,1); %�����ֵ
yrk=zeros(nc,1); %���������ֵ
xik=zeros(nc,1); %��������ֵ
xiek=zeros(nc,1); %���������Ƴ�ֵ
yr=10*[ones(L/4,1);-ones(L/4,1);ones(L/4,1);-ones(L/4+d,1)]; %�������
xi=sqrt(0.1)*randn(L,1); %����������

%RELS ��ֵ����
thetae_1=0.001*ones(na+nb+1+nc,1);%�ǳ�С���������˴�����Ϊ0��
P=10^6*eye(na+nb+1+nc);
for k=1:L
    time(k)=k;
    y(k)=-a(2:na+1)*yk+b*uk(d:d+nb)+c*[xi(k);xik]; %�ɼ��������
    
    %����������С���˷�
    phie=[-yk;uk(d:d+nb);xiek];
    K=P*phie/(1+phie'*P*phie);
    thetae(:,k)=thetae_1+K*(y(k)-phie'*thetae_1);
    P=(eye(na+nb+1+nc)-K*phie')*P;
    
    xie=y(k)-phie'*thetae(:,k);%�������Ĺ���ֵ
    
    %��ȡ��ʶ����
    ae=[1 thetae(1:na,k)']; be=thetae(na+1:na+nb+1,k)'; ce=[1 thetae(na+nb+2:na+nb+1+nc,k)'];
    if abs(ce(2))>0.9
        ce(2)=sign(ce(2))*0.9;
    end
    
    [e,f,g]=sindiophantine(ae,be,ce,d); %��ⵥ��Diophantine����   
    CQ=conv(ce,Q); FP=conv(f,Pw); CR=conv(ce,R); GP=conv(g,Pw); %CQ=Ce*Q
    
    u(k)=(-Q(1)*CQ(2:nc+nq+1)*uk(1:nc+nq)/be(1)-FP(2:np+nf+1)*uk(1:np+nf)...
        +CR*[yr(k+d:-1:k+d-min(d,nr+nc)); yrk(1:nr+nc-d)]...
        -GP*[y(k); yk(1:np+ng)])/(Q(1)*CQ(1)/be(1)+FP(1));%�������
    
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
xlabel('k'); ylabel('u(k)'); axis([0 L -10 10]);
figure(2)
plot([1:L],thetae);
xlabel('k'); ylabel('��ʶ����a��b��c');
legend('a_1','a_2','b_0','b_1','c_1'); axis([0 L -2 2.5]);