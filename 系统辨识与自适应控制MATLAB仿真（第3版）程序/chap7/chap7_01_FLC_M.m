%������ϵͳģ���߼����ƣ�FLC��
clear all; close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%  ����FIS�ṹ  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = newfis('fuzcon_m'); %�½�FIS

%����������e��ec��uc�������������������Σ�
a = addvar(a, 'input', 'e', [-6 6]);
a = addmf(a, 'input', 1, 'NB', 'trimf', [-8 -6 -4]);
a = addmf(a, 'input', 1, 'NM', 'trimf', [-6 -4 -2]);
a = addmf(a, 'input', 1, 'NS', 'trimf', [-4 -2  0]);
a = addmf(a, 'input', 1, 'Z', 'trimf', [-2  0  2]);
a = addmf(a, 'input', 1, 'PS', 'trimf', [0   2  4]);
a = addmf(a, 'input', 1, 'PM', 'trimf', [2   4  6]);
a = addmf(a, 'input', 1, 'PB', 'trimf', [4   6  8]);

a = addvar(a, 'input', 'ec', [-6 6]);
a = addmf(a, 'input', 2, 'NB', 'trimf', [-8 -6 -4]);
a = addmf(a, 'input', 2, 'NM', 'trimf', [-6 -4 -2]);
a = addmf(a, 'input', 2, 'NS', 'trimf', [-4 -2  0]);
a = addmf(a, 'input', 2, 'Z', 'trimf', [-2  0  2]);
a = addmf(a, 'input', 2, 'PS', 'trimf', [0   2  4]);
a = addmf(a, 'input', 2, 'PM', 'trimf', [2   4  6]);
a = addmf(a, 'input', 2, 'PB', 'trimf', [4   6  8]);

a = addvar(a, 'output', 'uc', [-6 6]);
a = addmf(a, 'output', 1, 'NB', 'trimf', [-8 -6 -4]);
a = addmf(a, 'output', 1, 'NM', 'trimf', [-6 -4 -2]);
a = addmf(a, 'output', 1, 'NS', 'trimf', [-4 -2  0]);
a = addmf(a, 'output', 1, 'Z', 'trimf', [-2  0  2]);
a = addmf(a, 'output', 1, 'PS', 'trimf', [0   2  4]);
a = addmf(a, 'output', 1, 'PM', 'trimf', [2   4  6]);
a = addmf(a, 'output', 1, 'PB', 'trimf', [4   6  8]);

%���������
r0=[1 1 2 2 3 3 4
    1 2 2 3 3 4 5
    2 2 3 3 4 5 5
    2 3 3 4 5 5 6
    3 3 4 5 5 6 6
    3 4 5 5 6 6 7
    4 5 5 6 6 7 7]; %���ƹ����
for i = 1: 7
    for j = 1:7
        r1((i-1)*7+j,:) = [i, j, r0(i,j)];
    end
end
rulelist = [r1, ones(49,2)];
a = addrule(a, rulelist); %��ӹ���

%writefis(a,'fuzcon_m'); %�����õ�FIS���浽���̵ĵ�ǰĿ¼��
%a=readfis('fuzcon_m'); %�Ӵ��̵�ǰĿ¼��װ���ѽ��õ�FIS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%  ʵʱ����  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
ny=2; nu=3; d=2; Ts=1;  %ny��nu��dΪϵͳ�ṹ����,TsΪ��������

L=1500; %���泤��
uk=zeros(nu,1); %���������ֵ��uk(i)��ʾu(k-i);
yk=zeros(ny,1); %ϵͳ�����ֵ
ek1=0; %e(k-1)

ke=12; kec=12; kuc=0.005; %��������
for k=1:L
    time(k)=k*Ts;
    y(k)=uk(2)^3+uk(3)^3+(0.8+yk(1)^3)/(1+yk(1)^2+yk(2)^4); %�ɼ�ϵͳ�������
    
    yr(k)=0.25*sign(sin(0.002*pi*k))+0.75; %�ɼ������������
    e(k)=yr(k)-y(k);
    ec=(e(k)-ek1)/Ts;
    
    e1=ke*e(k); ec1=kec*ec; %ģ������������
    if e1>6
        e1=6;
    end
    if e1<-6
        e1=-6;
    end
    if ec1>6
        ec1=6;
    end
    if ec1<-6
        ec1=-6;
    end

    uc=kuc*evalfis([e1 ec1],a); %ִ��ģ���������
    u(k)=uk(1)+uc;
    
    %��������
    for i=nu:-1:2
        uk(i)=uk(i-1);
    end
    uk(1)=u(k);
    
    for i=ny:-1:2
        yk(i)=yk(i-1);
    end
    yk(1)=y(k);
    
    ek1 = e(k); 
end
figure(1)
plotmf(a, 'input', 1);
xlabel('e��ec��uc');
figure(2)
subplot(211)
plot(time,yr,'r--',time,y,'k');
xlabel('k'); ylabel('y_r(k)��y(k)');
legend('y_r(k)','y(k)'); axis([0 L 0.4 1.1]);
subplot(212)
plot(time,u,'k');
xlabel('k'); ylabel('u(k)'); axis([0 L -.8 .8]);