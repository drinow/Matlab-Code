%�������ÿ��ƣ�PPC��������ϵͳ��ɢ����
clear all; close all;

%���ض�����ɢ��
den=[1 1 0]; num=[1]; Ts=0.5; Td=0; %����ϵͳ�������
sys=tf(num,den,'inputdelay',Td); %����ϵͳ���ݺ���
dsys=c2d(sys,Ts,'zoh'); %��ɢ��
[dnum,a]=tfdata(dsys,'v'); %��ȡ��ɢϵͳ����
na=length(a)-1; b=dnum(2:na+1); nb=length(b)-1;
d=Td/Ts+1; %����ʱ

%����������ɢ��
den=[1 2*0.7*1 1^2]; num=[1];
sys=tf(num,den);
dsys=c2d(sys,Ts,'zoh');
[dnum,Am]=tfdata(dsys,'v'); %��ȡAm
nam=length(Am)-1; %������������ʽ�״�

%����ʽB�ķֽ�
br=roots(b); %��B�ĸ�
b0=b(1); b1=1; %b0ΪB-��b1ΪB+
Val=0.8; %ͨ���޸��ٽ�ֵ��ȷ��B����Ƿ������������ֵС���ٽ�ֵ���򱻵�����
for i=1:nb %�ֽ�B-��B+
    if abs(br(i))>=Val
        b0=conv(b0,[1 -br(i)]);
    else
        b1=conv(b1,[1 -br(i)]);
    end
end

Bm1=sum(Am)/sum(b0);Bm=Bm1*b0; %ȷ������ʽBm

%ȷ������ʽA0
na0=2*na-1-nam-(length(b1)-1); %�۲�����ͽ״�
A0=1;
for i=1:na0
    A0=conv(A0,[1 0.5]); %���ɹ۲���
end

%����Diophantine���̣��õ�F��G��R
[F1,G]=diophantine(a,b0,d,A0,Am); %ע�⣬�˴�Ϊb0
F=conv(F1,b1); R=Bm1*A0; 
nf=length(F)-1; ng=length(G)-1; nr=length(R)-1;

L=400; %���Ʋ���
uk=zeros(d+nb,1); %�����ֵ��uk(i)��ʾu(k-i)
yk=zeros(na,1); %�����ֵ
yrk=zeros(na,1); %���������ֵ
yr=10*[ones(L/4,1);-ones(L/4,1);ones(L/4,1);-ones(L/4+d,1)]; %�������

for k=1:L
    time(k)=k*Ts;
    y(k)=-a(2:na+1)*yk+b*uk(d:d+nb); %�ɼ��������
    
    u(k)=(-F(2:nf+1)*uk(1:nf)+R*[yr(k+d:-1:k+d-min(d,nr));yrk(1:nr-d)]-G*[y(k);yk(1:ng)])/F(1); %�������

    %��������
    for i=d+nb:-1:2
        uk(i)=uk(i-1);
    end
    uk(1)=u(k);
    
    for i=na:-1:2
        yk(i)=yk(i-1);
        yrk(i)=yrk(i-1);
    end
    yk(1)=y(k);
    yrk(1)=yr(k);
end
subplot(2,1,1);
plot(time,yr(1:L),'r:',time,y);
xlabel('t'); ylabel('y_r(t)��y(t)');
legend('y_r(t)','y(t)');
subplot(2,1,2);
plot(time,u);
xlabel('t'); ylabel('u(t)');