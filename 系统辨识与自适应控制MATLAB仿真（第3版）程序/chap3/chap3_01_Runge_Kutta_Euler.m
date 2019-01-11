%��ֵ���ַ����������ϵͳ���������-��������ŷ�����ıȽϣ�
clear all; close all;

h=0.1; L=15/h; %h���㲽����LΪ���沽��
z=[-1 -2]; p=[-4 -0.5+j -0.5-j]; k=2.5; %������㼫����
[A,B,C,D]=zp2ss(z,p,k); %ת��Ϊ״̬�ռ���
u=1*ones(L,1); u0=0; %���뼰��ֵ
n=length(p); %����״�

x0=zeros(n,1); xe0=zeros(n,1); %x0��xe0�ֱ�Ϊ����-��������ŷ������״̬��ֵ
for i=1:L
    time(i)=i*h;

    %ŷ����
    xe=xe0+h*(A*xe0+B*u0);
    ye(i)=C*xe;
    
    %����-������
    k1=A*x0+B*u0;
    k2=A*(x0+h*k1/2)+B*u0;
    k3=A*(x0+h*k2/2)+B*u0;
    k4=A*(x0+h*k3)+B*u(i);
    x=x0+h*(k1+2*k2+2*k3+k4)/6;
    y(i)=C*x;
    
    %��������
    u0=u(i);x0=x;xe0=xe;
end
plot(time,u,'k-.',time,ye,':',time,y,'r');
xlabel('t'); ylabel('y_r(t)��y(t)');
legend('y_r(t)','Euler:y(t)','Runge-Kutta:y(t)');