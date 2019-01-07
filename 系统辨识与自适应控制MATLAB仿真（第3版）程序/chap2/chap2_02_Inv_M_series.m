%M���м���M���еĲ���
clear all; close all;

L=60; %M���г���
x1=1; x2=1; x3=1; x4=0; %��λ�Ĵ�����ֵxi-1��xi-2��xi-3��xi-4
S=1; %������ֵ

for k=1:L
    M(k)=xor(x3,x4); %�����������,����M����
    IM=xor(M(k),S); %�����������,������M����
    if IM==0
        u(k)=-1;
    else
        u(k)=1;
    end
    
    S=not(S); %��������
    
    x4=x3; x3=x2; x2=x1; x1=M(k); %�Ĵ�����λ
    
end
subplot(2,1,1);
stairs(M); grid;
axis([0 L/2 -0.5 1.5]); xlabel('k'); ylabel('M���з�ֵ'); title('M����');
subplot(2,1,2);
stairs(u); grid;
axis([0 L -1.5 1.5]); xlabel('k'); ylabel('��M���з�ֵ'); title('��M����');