%��С����ֱ����У������
clear all; close all;

a=[1 -1.7 0.7]; b=[1 0.5]; c=[1 0.2]; d=4; %�������
na=length(a)-1; nb=length(b)-1; nc=length(c)-1; %na��nb��ncΪ����ʽA��B��C�״�
nf=nb+d-1; ng=na-1; %nf��ngΪ����ʽF��G�Ľ״�

L=400; %���Ʋ���
uk=zeros(d+nf,1); %�����ֵ��uk(i)��ʾu(k-i);
yk=zeros(d+ng,1); %�����ֵ
yek=zeros(nc,1); %�������Ԥ����Ƴ�ֵ
yrk=zeros(nc,1); %���������ֵ
xik=zeros(nc,1); %��������ֵ
yr=10*[ones(L/4,1);-ones(L/4,1);ones(L/4,1);-ones(L/4+d,1)]; %�������
xi=sqrt(0.1)*randn(L,1); %����������

%���ƹ��Ƴ�ֵ
thetaek=zeros(na+nb+d+nc,d);
P=10^6*eye(na+nb+d+nc);
for k=1:L
    time(k)=k;
    y(k)=-a(2:na+1)*yk(1:na)+b*uk(d:d+nb)+c*[xi(k);xik]; %�ɼ��������
        
    %����������С���˷�
    phie=[yk(d:d+ng);uk(d:d+nf);-yek(1:nc)];
    K=P*phie/(1+phie'*P*phie);
    thetae(:,k)=thetaek(:,1)+K*(y(k)-phie'*thetaek(:,1));
    P=(eye(na+nb+d+nc)-K*phie')*P;
    
    ye=phie'*thetaek(:,d); %Ԥ������Ĺ���ֵ������Ϊthetae(:,k-d)��
    %ye=yr(k); %Ԥ������Ĺ���ֵ��ȡyr(k)
        
    %��ȡ��ʶ����
    ge=thetae(1:ng+1,k)'; fe=thetae(ng+2:ng+nf+2,k)'; ce=[1 thetae(ng+nf+3:ng+nf+2+nc,k)'];
    if abs(ce(2))>0.9
        ce(2)=sign(ce(2))*0.9;
    end
    if fe(1)<0.1  %��f0���½�Ϊ0.1
        fe(1)=0.1;
    end
    
    u(k)=(-fe(2:nf+1)*uk(1:nf)+ce*[yr(k+d:-1:k+d-min(d,nc));yrk(1:nc-d)]-ge*[y(k);yk(1:na-1)])/fe(1); %������
    
    %��������
    for i=d:-1:2
        thetaek(:,i)=thetaek(:,i-1);
    end
    thetaek(:,1)=thetae(:,k);
    
    for i=d+nf:-1:2
        uk(i)=uk(i-1);
    end
    uk(1)=u(k);
    
    for i=d+ng:-1:2
        yk(i)=yk(i-1);
    end
    yk(1)=y(k); 
    
    for i=nc:-1:2
        yek(i)=yek(i-1);
        yrk(i)=yrk(i-1);
        xik(i)=xik(i-1);
    end
    if nc>0
        yek(1)=ye;
        yrk(1)=yr(k);
        xik(1)=xi(k);
    end
end
figure(1);
subplot(2,1,1);
plot(time,yr(1:L),'r:',time,y);
xlabel('k'); ylabel('y_r(k)��y(k)');
legend('y_r(k)','y(k)'); axis([0 L -20 20]);
subplot(2,1,2);
plot(time,u);
xlabel('k'); ylabel('u(k)'); axis([0 L -40 40]);
figure(2)
subplot(211)
plot([1:L],thetae(1:ng+1,:),[1:L],thetae(ng+nf+3:ng+2+nf+nc,:));
xlabel('k'); ylabel('��������g��c');
legend('g_0','g_1','c_1'); axis([0 L -3 4]);
subplot(212)
plot([1:L],thetae(ng+2:ng+2+nf,:));
xlabel('k'); ylabel('��������f');
legend('f_0','f_1','f_2','f_3','f_4'); axis([0 L 0 4]);