%���ھֲ�����RBF�������ʶ
clear all; close all;

ny=2; nu=3; d=2; %ny��nu��dΪϵͳ�ṹ����

L=600; %���泤��
uk=zeros(nu,1); %���������ֵ��uk(i)��ʾu(k-i);
yk=zeros(ny,1); %ϵͳ�����ֵ

%����RBF�������
n=ny+nu-d+1; m=6; %n��m�ֱ�Ϊ������������ڵ���
eta=0.5; %ѧϰ����
alpha=0.05; %��������
ck1=20*ones(m,n); ck2=ck1; %����������������ֵ: cki��ʾc(k-i)
bk1=40*ones(m,1); bk2=bk1; %����������������ֵ: bki��ʾb(k-i)
wk1=rands(1,m); wk2=wk1; %�������������Ȩֵ�ĳ�ֵ: wki��ʾw(k-i)
R=zeros(m,1); %����R�ṹ
db=zeros(m,1); %���妤b�ṹ
dc=zeros(m,n); %���妤c�ṹ

for k=1:L
    time(k)=k;
    u(k)=0.8*sin(0.01*pi*k); %���������ź�
    y(k)=uk(2)^3+uk(3)^3+(0.8+yk(1)^3)/(1+yk(1)^2+yk(2)^4); %�ɼ�ϵͳ�������
    
    %����RBF�������
    x=[yk; uk(d:nu)];
    for j=1:m
        R(j)=exp(-norm(x-ck1(j,:)')^2/(2*bk1(j)^2));
    end 
    ym(k)=wk1*R;
    
    e(k)=y(k)-ym(k); %ģ�����
    
    %RBF����ѵ��
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
end
subplot(211)
plot(time,y,'r:',time,ym,'k');
xlabel('k'); ylabel('y(k)��y_m(k)');
legend('y(k)','y_m(k)'); axis([0 L -.5 2]);
subplot(212)
plot(time,y-ym,'k');
xlabel('k'); ylabel('e(k)'); %axis([0 L -.5 .5]);