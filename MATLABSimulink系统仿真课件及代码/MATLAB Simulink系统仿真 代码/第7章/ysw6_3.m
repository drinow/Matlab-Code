%PID ������
clc % ����
clear all; % ɾ��workplace����
close all; % �ص���ʾͼ�δ���
M=0.5;m=0.5;b=0.1;I=0.006;l=0.3;g=9.8;
a=(M+m)*m*g*l/((M+m)*I+M*m*l^2);b=-m*l/(((M+m)*I+M*m*l^2));
c=-m^2*l^2*g/((M+m)*I+M*m*l^2);d=(I+m*l^2)/((M+m)*I+M*m*l^2);
A=[           0                   1 0             0;...
    (M+m)*m*g*l/((M+m)*I+M*m*l^2) 0 0 m*l*b/((M+m)*I+M*m*l^2);...
              0                   0 0             1;...
     -m^2*l^2*g/((M+m)*I+M*m*l^2) 0 0 -(I+m*l^2)*b/((M+m)*I+M*m*l^2)];
B=[0;-m*l/(((M+m)*I+M*m*l^2));0;(I+m*l^2)/((M+m)*I+M*m*l^2)];
C=[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
D=[0;0;0;0];
p2=eig(A)';             % A����ֵ���
p=[-10,-7,-1.901,-1.9]; % ��������
K=place(A,B,p)          % ״̬��������
eig(A-B*K)'  % �����������
%%��������֤
[x,y]=sim('pedulumpid.mdl');
subplot(121),plot(y(:,1),'r','linewidth',2);
grid on,title('��ǿ���')
subplot(122),plot(y(:,3),'r','linewidth',2);
grid on,title('λ�ƿ���')
