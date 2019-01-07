%��Ԥѡdi��n��SISO��ɢϵͳMRAS�����ڲ������ƣ�
clear all; close all;

am=[1 -0.7 0.5]'; bm=[3 2]'; %�ο�ģ�Ͳ������ο�ģ���к���yr(k)��ע��nb��ʹ�ã���
thetam=[am;bm]; %�ο�ģ�Ͳ�������
na=length(am); nb=length(bm); %�ɵ���������

L=400; %���泤��
ypk=zeros(na,1); ymk=zeros(na,1); yrk=zeros(nb-1,1); epsilonk=zeros(na,1); %��ֵ��ypk(i)��ʾyp(k-i)
yr=rands(L,1); %�ο�����

G=1*eye(na+nb); G1=0.1*G; %ע��G1��ѡ��(����ѡΪ��������)
D=-am+0.1; %ϵ��di

thetapr_1=zeros(na+nb,1); %�ɵ�������ֵ��pr
for k=1:L
    time(k)=k;
    xm_1=[ymk;yr(k);yrk]; %����ο�ģ����������
    ym(k)=thetam'*xm_1; %�ɼ��ο�ģ�����
    
    xp_1=[ypk;yr(k);yrk]; %���������������
    v0(k)=ym(k)-thetapr_1'*xp_1+D'*epsilonk; %����v0(k)
    
    thetapp(:,k)=G1*xp_1*v0(k)/(1+xp_1'*(G+G1)*xp_1); %�����pp
    thetapr(:,k)=thetapr_1+G*xp_1*v0(k)/(1+xp_1'*(G+G1)*xp_1); %�����pr
    thetap(:,k)=thetapr(:,k)+thetapp(:,k); %��p
    
    yp(k)=thetap(:,k)'*xp_1; %�������¿ɵ���������yp
    epsilon=ym(k)-yp(k); %�����������
    
    %��������
    thetapr_1=thetapr(:,k);
    
    for i=nb-1:-1:2  %ע��ο�ģ������yr(k)
        yrk(i)=yrk(i-1);
    end
    if nb>1
        yrk(1)=yr(k);
    end
    
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
plot(time,thetap(1:na,:));
xlabel('k'); ylabel('�ɵ�ϵͳ����ap');
legend('a_p_1','a_p_2','a_p_3'); axis([0 L -1 1.5]);
subplot(2,1,2);
plot(time,thetap(na+1:na+nb,:));
xlabel('k'); ylabel('�ɵ�ϵͳ����bp');
legend('b_p_0','b_p_1'); axis([0 L 0 4]);