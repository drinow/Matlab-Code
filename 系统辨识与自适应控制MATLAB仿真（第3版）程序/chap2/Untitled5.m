%�������ţ�ٲ������ƣ�RSNA��
clear all; close all;
sampleTime=0.01;%����ʱ��
simTime=10;%����ʱ��
% �ٶ�һ������Ϊ����ʶϵͳ
num=[1 0.5];
den=[1 -0.1 -0.12];
% G=tf(num,den)
% Gz=c2d(G,sampleTime,'i') % ��ɢ���õ����崫������Ҫ˵�����ǣ���ʱ����ӻ���ֺ�С��ֵ���������󣬿��Ժ���Ϊ0����˸���ı�ʶҲ���п��ܲ���ȷ��
Gz=tf(num,den,sampleTime)% ֱ�Ӽٶ�һ����ɢ���Ĵ������ȶ���ϵͳ�ſ���ȷ��ʶ����λԲ�ڣ�
%��ʱ���Եõ���ֱ��ʽ��y/u=Gz
%��Ϊ��A(z)y(k)=B(z)u(k)*z^-d
%���У�A(z)=1+a1*z^-1+a2*z^-2+...
yt=step(Gz,0:sampleTime:simTime);%�õ���Ծ�������
step(Gz)
figure
step(feedback(Gz,1))
figure
[num_Gz,den_Gz]=tfdata(Gz,'v');

% a=[1 -0.1 -0.12]'; b=[1 0.5]'; 
d=1; %�������
n_Gz_num=length(num_Gz)-1-d;
n_Gz_den=length(den_Gz)-1;  %na��nbΪA��B�״�
L=simTime/sampleTime; %���泤��
u=ones(L,1); %������ð���������
uk=zeros(d+n_Gz_num,1); %�����ֵ��uk(i)��ʾu(k-i)
yk=zeros(n_Gz_den,1); %�����ֵ
thetae_1=zeros(n_Gz_den+n_Gz_num+1,1); %�������Ƴ�ֵ
Rk_1=eye(n_Gz_den+n_Gz_num+1);
for k=1:L
    phi=[-yk;uk(d:d+n_Gz_num)];
    y(k)=yt(k); %�ɼ��������
    
    %���ţ���㷨
    R=Rk_1+(phi*phi'-Rk_1)/k;
    dR=det(R);
    if abs(dR)<10^(-6)  %�������R������
        R=eye(n_Gz_den+n_Gz_num+1);
    end
    IR=inv(R);
    thetae(:,k)=thetae_1+IR*phi*(y(k)-phi'*thetae_1)/k;
           
    %��������
    thetae_1=thetae(:,k);
    Rk_1=R;
    
    for i=d+n_Gz_num:-1:2
        uk(i)=uk(i-1);
    end
    uk(1)=u(k);
    
    for i=n_Gz_den:-1:2
        yk(i)=yk(i-1);
    end
    yk(1)=y(k);
end
plot([1:L],thetae);
xlabel('k'); ylabel('��������a��b');
legend('a_1','a_2','b_0','b_1'); axis([0 L -2 2]);