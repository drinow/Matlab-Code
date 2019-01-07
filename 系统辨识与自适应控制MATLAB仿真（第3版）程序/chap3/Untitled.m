%����Ԥѡdi��n��SISO��ɢϵͳMRAS�����ڲ������ƣ�
%�ܱ���ʶ��ϵͳ
clear all; 
close all;

% am=conv([1 0.8],[1 0.4])'
% bm=[3 2]'; %�ο�ģ�Ͳ������ο�ģ���к���yr(k)��ע��nb��ʹ�ã���
% am=[1 0.5 -0.6]';
% bm=[3 2]'; %�ο�ģ�Ͳ������ο�ģ���к���yr(k)��ע��nb��ʹ�ã���
am=conv([1 -0.2],[1 0.4])';
am=-am(2:3)
bm=[3]'; %�ο�ģ�Ͳ������ο�ģ���к���yr(k)��ע��nb��ʹ�ã���
thetam=[am;bm]; %�ο�ģ�Ͳ�������
na=length(am); nb=length(bm); %�ɵ���������

L=1000; %���泤��
ypk=zeros(na,1); ymk=zeros(na,1); yrk=zeros(nb-1,1); epsilonk=zeros(na,1); %��ֵ��ypk(i)��ʾyp(k-i)
yr=rands(L,1); %�ο�����

G_1=eye(2*na+nb); lambda=1; %�����Գƾ���G(0)����

thetape_1=zeros(2*na+nb,1); %�ɵ�������ֵ��pe(0)
for k=1:L
    time(k)=k;
    xm_1=[ymk;yr(k);yrk]; %����ο�ģ����������
    ym(k)=thetam'*xm_1; %�ɼ��ο�ģ�����
    
    xpe_1=[ypk;yr(k);yrk;epsilonk]; %���������������
    v0(k)=ym(k)-thetape_1'*xpe_1; %����v0(k)
 
    G=G_1-G_1*xpe_1*xpe_1'*G_1/lambda/(1+xpe_1'*G_1*xpe_1/lambda); %����G
    thetape(:,k)=thetape_1+G_1*xpe_1*v0(k)/(1+xpe_1'*G_1*xpe_1); %�����pe
    
    yp(k)=thetape(1:na+nb,k)'*xpe_1(1:na+nb); %�������¿ɵ���������yp
    epsilon=ym(k)-yp(k); %�����������
    
    %��������
    thetape_1=thetape(:,k);
    G_1=G;
    
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
plot(time,thetape(1:na,:));
xlabel('k'); ylabel('�ɵ�ϵͳ����ap');
legend('a_p_1','a_p_2','a_p_3'); 
% axis([0 L -1 1.5]);
subplot(2,1,2);
plot(time,thetape(na+1:na+nb,:));
xlabel('k'); ylabel('�ɵ�ϵͳ����bp');
legend('b_p_0','b_p_1'); 
% axis([0 L 0 4]);