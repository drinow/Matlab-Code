clear all; close all;
sampleTime=0.01;%����ʱ��
simTime=10;%����ʱ��
% �ٶ�һ������Ϊ����ʶϵͳ
num=[0.9];
den=[1 2];
G=tf(num,den)
Gz=c2d(G,sampleTime,'i') % ��ɢ���õ����崫������Ҫ˵�����ǣ���ʱ����ӻ���ֺ�С��ֵ���������󣬿��Ժ���Ϊ0����˸���ı�ʶҲ���п��ܲ���ȷ��
% Gz=tf(num,den,sampleTime)% ֱ�Ӽٶ�һ����ɢ���Ĵ������ȶ���ϵͳ�ſ���ȷ��ʶ����λԲ�ڣ�
%��ʱ���Եõ���ֱ��ʽ��y/u=Gz
%��Ϊ��A(z)y(k)=B(z)u(k)*z^-d
%���У�A(z)=1+a1*z^-1+a2*z^-2+...
yt=step(Gz,0:sampleTime:simTime);%�õ���Ծ�������
step(Gz)
figure
step(feedback(Gz,1))
[num_Gz,den_Gz]=tfdata(Gz,'v');

%ȷ����ϵͳ�ĵ����ݶ�У���������ƣ�RGC��
d=1; %�������
n_den_Gz=length(den_Gz)-1; n_num_Gz=length(num_Gz)-1-d+1; %na��nbΪA��B�״�

L=simTime/sampleTime; %���泤��
uk=zeros(d+n_num_Gz,1); %�����ֵ��uk(i)��ʾu(k-i)
yk=zeros(n_den_Gz,1); %�����ֵ
u=ones(L,1); %������ð���������
% xi=sqrt(0.1)*randn(L,1);%����
% theta=[den_Gz(2:na+1);num_Gz]; %���������ֵ

thetae_1=zeros(n_den_Gz+n_num_Gz+1,1); %�������Ƴ�ֵ
alpha=1; %��Χ(0,2)
c=0.1; %��������
for k=1:L
    phi=[-yk;uk(d:d+n_num_Gz)];
    y(k)=yt(k); %�ɼ��������
    
    thetae(:,k)=thetae_1+alpha*phi*(y(k)-phi'*thetae_1)/(phi'*phi+c); %�����ݶ�У���㷨
    
    %��������
    thetae_1=thetae(:,k);
    
    for i=d+n_num_Gz:-1:2
        uk(i)=uk(i-1);
    end
    uk(1)=u(k);
    
    for i=n_den_Gz:-1:2
        yk(i)=yk(i-1);
    end
    yk(1)=y(k);
end
thetae_1'
% plot([1:L],thetae);
% xlabel('k'); ylabel('��������a��b');
% legend('a_1','a_2','b_0','b_1'); axis([0 L -2 2]);