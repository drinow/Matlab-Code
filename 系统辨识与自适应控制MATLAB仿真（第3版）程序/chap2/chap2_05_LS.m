%��������С���˲������ƣ�LS��
clear all;

a=[1 -1.5 0.7]'; b=[1 0.5]'; d=3; %�������
na=length(a)-1; nb=length(b)-1; %na��nbΪA��B�״�

L=100; %���ݳ���
uk=zeros(d+nb,1); %�����ֵ��uk(i)��ʾu(k-i)
yk=zeros(na,1); %�����ֵ
x1=1; x2=1; x3=1; x4=0; S=1; %��λ�Ĵ�����ֵ��������ֵ
xi=sqrt(1)*randn(L,1); %����������

theta=[a(2:na+1);b]; %���������ֵ
for k=1:L
    phi(k,:)=[-yk;uk(d:d+nb)]'; %�˴�phi(k,:)Ϊ���������������phi����
    y(k)=phi(k,:)*theta+xi(k); %�ɼ��������
    
    M=xor(x3,x4); %����M����
    IM=xor(M,S);  %������M����
    if IM==0
        u(k)=-1;
    else
        u(k)=1;
    end
    S=not(S); %��������
    
    %��������
    x4=x3; x3=x2; x2=x1; x1=M; 
    
    for i=d+nb:-1:2
        uk(i)=uk(i-1);
    end
    uk(1)=u(k);
    
    for i=na:-1:2
        yk(i)=yk(i-1);
    end
    yk(1)=y(k);
end
thetae=inv(phi'*phi)*phi'*y' %�����������ֵthetae�������MATLAB����ڣ�