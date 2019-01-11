%��������µĲ���Ԥѡdi��n��SISO��ɢϵͳMRAS�����ڲ������ƣ�
%����ʶϵͳ��ʽ��'_'��ʾ�±�
%              y(k)=��am_i*y(k-i)+��bm_i*u(k-i)
%�����źű���ƽ������źţ���Ծ�źŲ�����,��Ϊ��Ծ�ź��޷���ּ���ϵͳ����Ӧ��
clf;
clear all;

EndTime=100000;%�����ֹʱ��
sampleTime=0.01;%�������
t=0:sampleTime:EndTime;
L=EndTime/sampleTime; %���泤��

num=[0.0005 0];
den=[1 -0.99];
% G=tf([0.98407],[13.407 1]);%���ñ�ʶ����ɢ�������ϵ��̫С����Ҫ�ܳ��ı�ʶ���ڡ�
% Gz=c2d(G,sampleTime,'i')
G=tf(num,den,sampleTime);%����ϵͳ
Gz=G
% G=tf([3 2 0 0],[1 -1 0.7 0.5],sampleTime);%����ϵͳ���鱾�ϵ�
% Gz=G
% seqGz=step(Gz,t);%Gz��Ծ��Ӧ���У���Ӧ����
rng(1);%������������ӣ���֤��������ظ�
yk=0;yk1=0;yk2=0;yk3=0;
% uk=idinput(L);%�ٷ�������-1/1�������
uk=fix(rands(L,1)+1);%����01�������
% uk=sign(rands(L,1));%����-1/1������У�01�����ƺ�������������׻����ȷ���
uk1=0;uk2=0;uk3=0;
%���ɱ���ʶϵͳ������ź�
for k=1:L
%     yk(k)=[1 -0.7 0.5]*[yk1 yk2 yk3]'+[3 2 0 0]*[uk(k) uk1 uk2 uk3]';
    %�ǵ�Ҫ��Ϊ�ͼٶ�����ϵͳһ��
    yk(k)=[den(2) 0 0]*[yk1 yk2 yk3]'+[num(1) num(2) 0]*[uk(k) uk1 uk2]';

    yk3=yk2;
    yk2=yk1;
    yk1=yk(k);
    uk3=uk2;
    uk2=uk1;
    uk1=uk(k);
end

na=length(den)-1; nb=length(num); %�����Ŀɵ�������������na��ʾ����am��ά��

ypk=zeros(na,1); ymk=zeros(na,1); yrk=zeros(nb-1,1); epsilonk=zeros(na,1); %��ֵ��ypk(i)��ʾyp(k-i)
% yr=ones(L,1); %�ο�����
yr=uk;%��������źŸ����ױ�ʶ�ɹ�Ҳ��׼ȷ��

G_1=eye(2*na+nb); lambda=1; %�����Գƾ���G(0)����

thetape_1=zeros(2*na+nb,1); %�ɵ�������ֵ��pe(0)
for k=1:L
    time(k)=k;
    ym(k)=yk(k); %�ɼ��ο�ģ���������������źŸ����ױ�ʶ�ɹ�Ҳ��׼ȷ��
%     ym(k)=seqGz(k);
    
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
% legend('a_p_1','a_p_2','a_p_3'); 
% axis([0 L -1 1.5]);
subplot(2,1,2);
plot(time,thetape(na+1:na+nb,:));
xlabel('k'); ylabel('�ɵ�ϵͳ����bp');
% legend('b_p_0','b_p_1'); 
% axis([0 L 0 4]);