%����������ɫ�������еĲ���
clear all; close all;

L=500; %���泤��
d=[1 -1.5 0.7 0.1]; c=[1 0.5 0.2]; %D��C����ʽ��ϵ��(����roots���������)
nd=length(d)-1; nc=length(c)-1; %nd��ncΪD��C�Ľ״�
xik=zeros(nc,1); %��������ֵ���൱�ڦ�(k-1)...��(k-nc)
ek=zeros(nd,1); %��ɫ������ֵ
xi=randn(L,1); %randn������ֵΪ0������Ϊ1�ĸ�˹������У����������У�

for k=1:L
    e(k)=-d(2:nd+1)*ek+c*[xi(k);xik]; %������ɫ����
    
    %���ݸ���
    for i=nd:-1:2
        ek(i)=ek(i-1);
    end
    ek(1)=e(k);
    
    for i=nc:-1:2
        xik(i)=xik(i-1);
    end
    xik(1)=xi(k);
end
subplot(2,1,1);
plot(xi);
xlabel('k'); ylabel('������ֵ'); title('����������');
subplot(2,1,2);
plot(e);
xlabel('k'); ylabel('������ֵ'); title('��ɫ��������');