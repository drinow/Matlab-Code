% ϵͳ��ʶ���ݺ���
% �����ݺ�����Ϊ��ɢ��ʽ��ARģ�ͣ���Ȼ���ʶ���ARģ�͵Ĳ���
% ��ɢ��ϵͳ���������ȫ��λ�ڵ�λԲ�ڣ���ĸΪ��һʽ���ſ��Ա�ʶ
% ���Կ������ȶ�������ջ��ȶ���
clear all; close all;
sampleTime=0.01;%����ʱ��
simTime=10;%����ʱ��
% �ٶ�һ������Ϊ����ʶϵͳ
num=[0.05 -0.03];
den=[1 -0.5 -0.5];
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

%׼��������ǰ2�����������˹��˶�һ�£���
d=1;%d>0,dΪ����ʶϵͳ��z�򣩵ķ�����z����Сָ����һ��Ϊ0��+1
n_Gz_num=length(num_Gz)-1-d;%n_Gz_num+d���ڴ���ʶϵͳ��z�򣩵ķ��ӽ���
n_Gz_den=length(den_Gz)-1;%n_Gz_denΪ����ʶϵͳ��z�򣩵ķ�ĸ����
L=simTime/sampleTime; %���棨��ʶ������
u=ones(L,1); %�����������У���Ϊһ���õ��ǽ�Ծ�ź�

%׼��������С���˲������ƣ�RLS��
uk=zeros(d+n_Gz_num,1); %�����ֵ��uk(i)��ʾu(k-i)
yk=zeros(n_Gz_den,1); %�����ֵ
thetae_1=zeros(n_Gz_den+n_Gz_num+1,1); %thetae��ֵ
P=10^6*eye(n_Gz_den+n_Gz_num+1); 
for k=1:L
    % �ӡ�������������ȡ��һ��������
    phi=[-yk;uk(d:d+n_Gz_num)]; %�˴�phiΪ������
    y(k)=yt(k); %�ɼ��������
   
    %������С���˷�
    K=P*phi/(1+phi'*P*phi);
    thetae(:,k)=thetae_1+K*(y(k)-phi'*thetae_1);%ʹ��thetae(:,k)����µ����������飬Ϊ�˱�����ʷ��ʶ������ڻ�ͼ
    P=(eye(n_Gz_den+n_Gz_num+1)-K*phi')*P;
    
    %��������
    thetae_1=thetae(:,k);
    
    %�޳��ɵġ��������㣬���ƻ�������
    for i=d+n_Gz_num:-1:2
        uk(i)=uk(i-1);
    end
    uk(1)=u(k);
    
    for i=n_Gz_den:-1:2
        yk(i)=yk(i-1);
    end
    yk(1)=y(k);
end
disp('���µĹ���ֵΪ'),thetae_1
hold on
tmp=size(thetae);%��ȡ�ж��ٸ�����
for i=1:tmp(1)
    plot(thetae(i,:))
end
title('���Ʋ������ֱ�Ϊa0-an��b0-bn')