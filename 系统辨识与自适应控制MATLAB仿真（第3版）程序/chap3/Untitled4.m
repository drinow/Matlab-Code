%����SISO��ɢϵͳMRAS�����ڲ������ƣ�
clear all; close all;

am=[1 -0.2]'; bm=[2]'; d=1; %�ο�ģ�Ͳ���
na=length(am); nb=length(bm)-1; %na��nbΪA��B�״�

L=400; %���泤��
ypk=zeros(na,1); %��ֵ��ypk(i)��ʾyp(k-i)
ymk=zeros(na,1);
yrk=zeros(nb+d,1);
epsilonk=zeros(na,1);
yr=ones(L,1); %�ο�����

ap_1=zeros(na,1); bp_1=zeros(nb+1,1); %�ɵ�������ֵ

alpha=ones(na,1); beta=ones(nb+1,1); %��>0����>0
D=zeros(na,1); D(1)=4*(1+am(2))/(3+am(1)+am(2)); D(2)=D(1)-1; %ϵ��di
for k=1:L
    time(k)=k;
    ym(k)=am'*ymk+bm'*yrk(d:d+nb); %�ɼ��ο�ģ�����
    
    yp0(k)=ap_1'*ypk+bp_1'*yrk(d:d+nb);
    v0(k)=ym(k)-yp0(k)+D'*epsilonk; %����v0(k)
    for i=1:na
        ap(i,k)=ap_1(i)+alpha(i)*ypk(i)*v0(k)/(1+alpha'*ypk.^2+beta*yrk(d:d+nb).^2); %����ap(k)
    end
    for i=1:nb+1
        bp(i,k)=bp_1(i)+beta(i)*yrk(i)*v0(k)/(1+alpha'*ypk.^2+beta*yrk(d:d+nb).^2); %����bp(k)
    end
    
    yp(k)=ap(:,k)'*ypk+bp(:,k)'*yrk(d:d+nb); %����yp
    epsilon=ym(k)-yp(k); %�����������
    
    %��������
    ap_1=ap(:,k); bp_1=bp(:,k);
    
    for i=d+nb:-1:2
        yrk(i)=yrk(i-1);
    end
    yrk(1)=yr(k);
    
    for i=na:-1:2
        ypk(i)=ypk(i-1);
        ymk(i)=ymk(i-1);
        epsilonk(i)=epsilonk(i-1);
    end
    ypk(1)=yp(k);
    ymk(1)=ym(k);
    epsilonk(1)=epsilon;
end
subplot(2,1,1);
plot(time,ym,'r',time,yp,':');
xlabel('k'); ylabel('y_m(k)��y_p(k)');
legend('y_m(k)','y_p(k)');
subplot(2,1,2);
plot(time,[ap;bp]);
xlabel('k'); ylabel('�������ap��bp');
legend('a_p_1','a_p_2','b_p_1');