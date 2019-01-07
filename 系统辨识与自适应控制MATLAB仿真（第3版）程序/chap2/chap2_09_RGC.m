%ȷ����ϵͳ�ĵ����ݶ�У���������ƣ�RGC��
clear all; close all;

a=[1 -1.5 0.7]'; b=[1 0.5]'; d=3; %�������
na=length(a)-1; nb=length(b)-1; %na��nbΪA��B�״�

L=400; %���泤��
uk=zeros(d+nb,1); %�����ֵ��uk(i)��ʾu(k-i)
yk=zeros(na,1); %�����ֵ
u=randn(L,1); %������ð���������

theta=[a(2:na+1);b]; %���������ֵ

thetae_1=zeros(na+nb+1,1); %�������Ƴ�ֵ
alpha=1; %��Χ(0,2)
c=0.1; %��������
for k=1:L
    phi=[-yk;uk(d:d+nb)];
    y(k)=phi'*theta; %�ɼ��������
    
    thetae(:,k)=thetae_1+alpha*phi*(y(k)-phi'*thetae_1)/(phi'*phi+c); %�����ݶ�У���㷨
    
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
plot([1:L],thetae);
xlabel('k'); ylabel('��������a��b');
legend('a_1','a_2','b_0','b_1'); axis([0 L -2 2]);