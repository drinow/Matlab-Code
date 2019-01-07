%���Ƽ�����Ȼ�������ƣ�RML��
clear all; close all;

a=[1 -1.5 0.7]'; b=[1 0.5]'; c=[1 -0.5]'; d=1; %�������
na=length(a)-1; nb=length(b)-1; nc=length(c)-1; %na��nb��ncΪA��B��C�״�
nn=max(na,nc); %����yf(k-i)��uf(k-i)����

L=1000; %���泤��
uk=zeros(d+nb,1); %�����ֵ��uk(i)��ʾu(k-i)
yk=zeros(na,1); %�����ֵ
xik=zeros(nc,1); %��������ֵ
xiek=zeros(nc,1); %���������Ƴ�ֵ
yfk=zeros(nn,1); %yf(k-i)
ufk=zeros(nn,1); %uf(k-i)
xiefk=zeros(nc,1); %��f(k-i)
u=randn(L,1); %������ð���������
xi=randn(L,1); %����������

thetae_1=zeros(na+nb+1+nc,1); %�������Ƴ�ֵ
P=eye(na+nb+1+nc);
for k=1:L
    y(k)=-a(2:na+1)'*yk+b'*uk(d:d+nb)+c'*[xi(k);xik]; %�ɼ��������
        
    %��������
    phi=[-yk;uk(d:d+nb);xiek];
    xie=y(k)-phi'*thetae_1;
    phif=[-yfk(1:na);ufk(d:d+nb);xiefk];
    
    %���Ƽ�����Ȼ���������㷨
    K=P*phif/(1+phif'*P*phif);
    thetae(:,k)=thetae_1+K*xie;
    P=(eye(na+nb+1+nc)-K*phif')*P;    
        
    yf=y(k)-thetae(na+nb+2:na+nb+1+nc,k)'*yfk(1:nc); %yf(k)
    uf=u(k)-thetae(na+nb+2:na+nb+1+nc,k)'*ufk(1:nc); %uf(k)
    xief=xie-thetae(na+nb+2:na+nb+1+nc,k)'*xiefk(1:nc); %xief(k)
      
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
        xik(i)=xik(i-1);
        xiek(i)=xiek(i-1);
        xiefk(i)=xiefk(i-1);
    end
    xik(1)=xi(k);
    xiek(1)=xie;
    xiefk(1)=xief;
    
    for i=nn:-1:2
        yfk(i)=yfk(i-1);
        ufk(i)=ufk(i-1);
    end
    yfk(1)=yf;
    ufk(1)=uf;
end
figure(1)
plot([1:L],thetae(1:na,:),[1:L],thetae(na+nb+2:na+nb+1+nc,:));
xlabel('k'); ylabel('��������a��c');
legend('a_1','a_2','c_1'); axis([0 L -2 2]);
figure(2)
plot([1:L],thetae(na+1:na+nb+1,:));
xlabel('k'); ylabel('��������b');
legend('b_0','b_1'); axis([0 L 0 1.5]);