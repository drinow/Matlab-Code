%����ȫ������BP�������ʶ
clear all; close all;

ny=2; nu=3; d=2; %ny��nu��dΪϵͳ�ṹ����

L=600; %���泤��
uk=zeros(nu,1); %���������ֵ��uk(i)��ʾu(k-i);
yk=zeros(ny,1); %ϵͳ�����ֵ

%����BP�������
n=ny+nu-d+1; m=6; %n��m�ֱ�Ϊ������������ڵ���
eta=0.5; %ѧϰ����
alpha=0.05; %��������
%w1k1=rands(m,n); %�������������Ȩֵ�ĳ�ֵ: w1ki��ʾw1(k-i)
w1k1=[ -0.8633    0.9231    0.1046    0.7128
   -0.1273    0.5248   -0.5638   -0.1951
   -0.6523   -0.9853    0.5447   -0.3640
   -0.9478    0.3601   -0.5439    0.2173
    0.9094    0.4119   -0.2583    0.8204
   -0.1388    0.2903    0.7819    0.8182];
w1k2=w1k1; 
%w2k1=rands(1,m); %�������������Ȩֵ�ĳ�ֵ: w2ki��ʾw2(k-i)
w2k1=[0.1832  -0.3349  0.7061  -0.1152  0.8087  -0.9336];
w2k2=w2k1; 

%����ѵ������2.5L��
for  k=1:2.5*L
    time(k)=k;
    u(k)=0.8*sin(0.01*pi*k); %���������ź�
    y(k)=uk(2)^3+uk(3)^3+(0.8+yk(1)^3)/(1+yk(1)^2+yk(2)^4); %�ɼ�ϵͳ�������
    
    %��������
    for i=nu:-1:2
        uk(i)=uk(i-1);
    end
    uk(1)=u(k);
    
    for i=ny:-1:2
        yk(i)=yk(i-1);
    end
    yk(1)=y(k);
end

%����X(k)ѵ��BP���磬k=100, 101, ..., 900
eg=10; %��ʼ��ȫ�����
epsilon=0.002; %ȫ������
num=0; %��ʼ��ѵ������
M=100; %���ѵ������

while(eg>epsilon) %��ȫ��������ѵ������
%while(num<M) %ֱ���趨ѵ������
    num=num+1;
    es(num)=0;
    for k=100:1.5*L        
        %����BP�������
        X=[y(k-1); y(k-2); u(k-2); u(k-3)];
        O1=X;    
        net2=w1k1*O1;
        O2=1./(1+exp(-net2));    
        ym(k)=w2k1*O2; 
    
        e(k)=y(k)-ym(k); %ģ�����
        es(num)=es(num)+e(k)^2/2; %�ۼ����ƽ��   

        %BP����ѵ��
        dw2=eta*e(k)*O2'; 
        w2=w2k1+dw2+alpha*(w2k1-w2k2); %w2(k)

        df=exp(-net2)./(1+exp(-net2)).^2; %���������ĵ���
        dw1=eta*e(k)*w2k1'.*df*O1'; %������ʽ����
        w1=w1k1+dw1+alpha*(w1k1-w1k2); %w1(k)
    
        %��������
        w1k2=w1k1; w1k1=w1;
        w2k2=w2k1; w2k1=w2;
    end
    eg=es(num);
end %�������ȫ�����Ҫ���Ȩֵw1��w2

%����X(k)����BP����ģ�ͣ���w1��w2����k=901, 902, ..., 1500
egt=0; %�������������ȫ�����
for k=1.5*L+1:2.5*L
    %����BP�������
    X=[y(k-1); y(k-2); u(k-2); u(k-3)];
    O1=X;    
    net2=w1k1*O1;
    O2=1./(1+exp(-net2));   
    ymt(k)=w2k1*O2;
    
    et(k)=y(k)-ymt(k); %ģ�����
    egt=egt+et(k)^2/2;
end

t1=100:1.5*L;
figure(1);
subplot(211)
plot(t1,y(t1),'r:',t1,ym(t1),'k');
xlabel('k'); ylabel('y(k)��y_m(k)');
legend('y(k)','y_m(k)'); %axis([0 L -.4 1.6]);
subplot(212)
plot(1:num,es,'k');
xlabel('Steps'); ylabel('E=\Sigma{e^2(k)/2}'); axis([0 num 0 max(es)]);
if num>500
    axes('Position',[0.3,0.25,0.4,0.16]); %������ͼ
    t0=1:100;
    plot(t0,es(t0),'b'); axis([0 max(t0) 0 max(es)]);
end

t2=1.5*L+1:2.5*L;
figure(2);
subplot(211)
plot(t2,y(t2),'r:',t2,ymt(t2),'k');
xlabel('k'); ylabel('y(k)��y_m(k)');
legend('y(k)','y_m(k)'); %axis([0 L -.4 1.6]);
subplot(212)
plot(t2,et(t2),'k');
xlabel('k'); ylabel('e(k)'); %axis([0 L -.5 .5]);