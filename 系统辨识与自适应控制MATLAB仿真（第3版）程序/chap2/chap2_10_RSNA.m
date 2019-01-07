%�������ţ�ٲ������ƣ�RSNA��
clear all; close all;

a=[1 -1.5 0.7]'; b=[1 0.5]'; d=3; %�������
na=length(a)-1; nb=length(b)-1; %na��nbΪA��B�״�

L=400; %���泤��
uk=zeros(d+nb,1); %�����ֵ��uk(i)��ʾu(k-i)
yk=zeros(na,1); %�����ֵ
xik=zeros(na,1); %��������ֵ��
etak=zeros(d+nb,1); %��������ֵ��
u=randn(L,1); %������ð���������
xi=sqrt(0.1)*randn(L,1); %���������Ц�
eta=sqrt(0.25)*randn(L,1); %���������Ц�

theta=[a(2:na+1);b]; %���������ֵ

thetae_1=zeros(na+nb+1,1); %�������Ƴ�ֵ
Rk_1=eye(na+nb+1);
for k=1:L
    phi=[-yk;uk(d:d+nb)];
    e(k)=a'*[xi(k);xik]-b'*etak(d:d+nb);
    y(k)=phi'*theta+e(k); %�ɼ��������
    
    %���ţ���㷨
    R=Rk_1+(phi*phi'-Rk_1)/k;
    dR=det(R);
    if abs(dR)<10^(-6)  %�������R������
        R=eye(na+nb+1);
    end
    IR=inv(R);
    thetae(:,k)=thetae_1+IR*phi*(y(k)-phi'*thetae_1)/k;
           
    %��������
    thetae_1=thetae(:,k);
    Rk_1=R;
    
    for i=d+nb:-1:2
        uk(i)=uk(i-1);
        etak(i)=etak(i-1);
    end
    uk(1)=u(k);
    etak(1)=eta(k);  
    
    for i=na:-1:2
        yk(i)=yk(i-1);
        xik(i)=xik(i-1);
    end
    yk(1)=y(k);
    xik(1)=xi(k);
end
plot([1:L],thetae);
xlabel('k'); ylabel('��������a��b');
legend('a_1','a_2','b_0','b_1'); axis([0 L -2 2]);