%���ھֲ�����RBF�������ʶ+PID��У������
clear all; close all;

ny=2; nu=3; d=2; %ny��nu��dΪϵͳ�ṹ����

L=1500; %���泤��
uk=zeros(nu,1); %���������ֵ��uk(i)��ʾu(k-i);
yk=zeros(ny,1); %ϵͳ�����ֵ

%����RBF�������
n=ny+nu+1; m=10; %n��m�ֱ�Ϊ������������ڵ�����ע�⣺������������ڵ������ʶ����chap6_04��ͬ����
eta=0.5; %ѧϰ����
alpha=0.05; %��������
ck1=20*ones(m,n); ck2=ck1; %����������������ֵ: cki��ʾc(k-i)
bk1=40*ones(m,1); bk2=bk1; %����������������ֵ: bki��ʾb(k-i)
wk1=[0.3219  0.4595  0.7815  0.9646  0.5381  0.1629  0.8566  0.1602  -0.9660  -0.7583];
%wk1=rands(1,m);
wk2=wk1; %�������������Ȩֵ�ĳ�ֵ: wki��ʾw(k-i)
R=zeros(m,1); %����R�ṹ
db=zeros(m,1); %���妤b�ṹ
dc=zeros(m,n); %���妤c�ṹ

%����PID������ֵ
Kp1=0.0; Kp2=Kp1; %����: Kpi��ʾKp(k-i)
Ki1=0.0; Ki2=Ki1; %����: Kii��ʾKi(k-i)
Kd1=0.0; Kd2=Kd1; %΢��: Kdi��ʾKd(k-i)
eck1=0;  eck2=0; %���: ecki��ʾec(k-i)

etac=1; %PID����ѧϰ����
alphac=0.1; %PID������������

for k=1:L
    time(k)=k;
    y(k)=uk(2)^3+uk(3)^3+(0.8+yk(1)^3)/(1+yk(1)^2+yk(2)^4); %�ɼ�ϵͳ�������
    
    %����PID������u(k)
    yr(k)=0.25*sign(sin(0.002*pi*k))+0.75;
    ec(k)=yr(k)-y(k);
    xc(1)=ec(k)-eck1;
    xc(2)=ec(k);
    xc(3)=ec(k)-2*eck1+eck2;
    
    du=Kp1*xc(1)+Ki1*xc(2)+Kd1*xc(3); %����������u(k)
    u(k)=uk(1)+du;
    
    %����RBF�������
    x=[yk; u(k); uk]; %RBF�������루����u(k)�������� 
    for j=1:m
        R(j)=exp(-norm(x-ck1(j,:)')^2/(2*bk1(j)^2));
    end 
    ym(k)=wk1*R; 
    
    %����Jacobian��Ϣ
    J(k)=0;
    for j=1:m
        J(k)=J(k)+wk1(j)*R(j)*(ck1(j,ny+1)-u(k))/bk1(j)^2;
    end
    
    %PID����ѧϰ
    dKp=etac*ec(k)*J(k)*xc(1); %��Kp(k)
    dKi=etac*ec(k)*J(k)*xc(2); 
    dKd=etac*ec(k)*J(k)*xc(3); 
    
    Kp(k)=Kp1+dKp+alphac*(Kp1-Kp2); %Kp(k)
    Ki(k)=Ki1+dKi+alphac*(Ki1-Ki2);
    Kd(k)=Kd1+dKd+alphac*(Kd1-Kd2);
    if Kp(k)<0
        Kp(k)=0;
    end
    if Ki(k)<0
        Ki(k)=0;
    end
    if Kd(k)<0
        Kd(k)=0;
    end
    
    %RBF����ѵ��
    e(k)=y(k)-ym(k); %ģ�����
    
    dw=eta*e(k)*R'; %��w(k)
    for j=1:m
        db(j)=eta*e(k)*wk1(j)*R(j)*norm(x-ck1(j,:)')^2/bk1(j)^3; %��b(k)
        for i=1:n
            dc(j,i)=eta*e(k)*wk1(j)*R(j)*(x(i)-ck1(j,i))/bk1(j)^2; %��c(k)
        end
    end

    w=wk1+dw+alpha*(wk1-wk2);
    b=bk1+db+alpha*(bk1-bk2);
    c=ck1+dc+alpha*(ck1-ck2);
            
    %��������
    bk2=bk1; bk1=b;
    ck2=ck1; ck1=c;
    wk2=wk1; wk1=w;
    
    for i=nu:-1:2
        uk(i)=uk(i-1);
    end
    uk(1)=u(k);
    
    for i=ny:-1:2
        yk(i)=yk(i-1);
    end
    yk(1)=y(k);
    
    eck2=eck1; eck1=ec(k);
    Kp2=Kp1; Kp1=Kp(k);
    Ki2=Ki1; Ki1=Ki(k);
    Kd2=Kd1; Kd1=Kd(k);
end
figure(1);
plot(time,yr,'r--',time,y,'k:',time,ym,'k');
xlabel('k'); ylabel('y_r(k)��y(k)��y_m(k)');
legend('y_r(k)','y(k)','y_m(k)'); axis([0 L 0.4 1.1]);
figure(2);
plot(time,y-ym,'k');
xlabel('k'); ylabel('e(k)'); axis([0 L -.1 .1]);
figure(3);
plot(time,u,'k');
xlabel('k'); ylabel('u(k)'); axis([0 L -.8 .8]);
figure(4);
subplot(311)
plot(time,Kp,'k');
set(gca,'xtick',[]); ylabel('Kp(k)');
subplot(312)
plot(time,Ki,'k');
set(gca,'xtick',[]); ylabel('Ki(k)'); 
subplot(313)
plot(time,Kd,'k');
xlabel('k'); ylabel('Kd(k)'); axis([0 L -.5 .5]);
figure(5)
plot(time,J,'k');
xlabel('k'); ylabel('dy(k)/du(k)'); 