%�ɵ�����MIT-MRAC��һ���㷨
clear all; close all;

h=0.1; L=100/h; %��ֵ���ֲ����ͷ��沽��
num=[1]; den=[1 1 1]; n=length(den)-1; %�������
kp=1; [Ap,Bp,Cp,Dp]=tf2ss(kp*num,den); %���ݺ�����ת��Ϊ״̬�ռ���
km=1; [Am,Bm,Cm,Dm]=tf2ss(km*num,den); %�ο�ģ�Ͳ���

gamma=0.1; %����Ӧ����
alpha=0.01; beta=2;

yr0=0; u0=0; e0=0; ym0=0; %��ֵ
xp0=zeros(n,1); xm0=zeros(n,1); %״̬������ֵ
kc0=0; %�ɵ������ֵ
r=1.2; yr=r*[ones(1,L/4) -ones(1,L/4) ones(1,L/4) -ones(1,L/4)]; %�����ź�

for k=1:L
    time(k)=k*h;
    xp(:,k)=xp0+h*(Ap*xp0+Bp*u0); 
    yp(k)=Cp*xp(:,k)+Dp*u0; %����yp
    
    xm(:,k)=xm0+h*(Am*xm0+Bm*yr0); 
    ym(k)=Cm*xm(:,k)+Dm*yr0; %����ym
    e(k)=ym(k)-yp(k); %e=ym-yp
    
    DD=e0*ym0/km/(alpha+(ym0/km)^2);

    kc=kc0+h*gamma*DD; %MIT����Ӧ��
    u(k)=kc*yr(k); %������
    
    %��������
    yr0=yr(k); u0=u(k); e0=e(k); ym0=ym(k);
    xp0=xp(:,k); xm0=xm(:,k);
    kc0=kc;
end
plot(time,ym,'r',time,yp,':');
xlabel('t'); ylabel('y_m(t)��y_p(t)');
legend('y_m(t)','y_p(t)');