%function main()
close  all

% �����źŵĲ��� 
t=0:0.1:99;
xs=10*sin(0.5*t);
figure;
subplot(2,1,1);
plot(t,xs);grid;
ylabel('��ֵ');
title('it{�����������ź�}');

% �����źŵĲ���
randn('state',sum(100*clock));
xn=randn(1,size(t,2));
subplot(2,1,2);
plot(t,xn);grid;
ylabel('��ֵ');
xlabel('ʱ��');
title('it{��������ź�}');

% �ź��˲�
xn = xs+xn;
xn = xn.' ;   % �����ź�����
dn = xs.' ;   % Ԥ�ڽ������
M  = 10   ;   % �˲����Ľ���

rho_max = max(eig(xn*xn.'));   % �����ź���ؾ�����������ֵ
mu = rand()*(1/rho_max)   ;    % �������� 0 < mu < 1/rho

[yn,W,en] = LMS(xn,dn,M,mu);

% �����˲��������ź�
figure;
subplot(2,1,1);
plot(t,xn);grid;
ylabel('��ֵ');
xlabel('ʱ��');
title('it{�˲��������ź�}');

% ��������Ӧ�˲�������ź�
subplot(2,1,2);
plot(t,yn);grid;
ylabel('��ֵ');
xlabel('ʱ��');
title('it{����Ӧ�˲�������ź�}');

% ��������Ӧ�˲�������ź�,Ԥ������źź����ߵ����
figure 
plot(t,yn,'b',t,dn,'g',t,dn-yn,'r');grid;
axis([0 100 -12 12]);
legend('����Ӧ�˲������','Ԥ�����','���');
ylabel('��ֵ');
xlabel('ʱ��');
Str=num2str(M);
title(['it{����Ӧ�˲���}' ' ����M=' Str]);

%--------------------------------------------------
% mu = rand()*(1/rho_max);    % ��һ�������������¼����Խ��бȽ�
M  = 20;                    % ��һ���˲����Ľ������¼����Խ��бȽ�
[yn,W,en] = LMS(xn,dn,M,mu);

figure 
plot(t,yn,'b',t,dn,'g',t,dn-yn,'r');grid;
axis([0 100 -12 12]);
legend('����Ӧ�˲������','Ԥ�����','���');
ylabel('��ֵ');
xlabel('ʱ��');
Str=num2str(M);
title(['it{����Ӧ�˲���}' ' ����M=' Str]);
% title(['it{����Ӧ�˲���}' ' mu=' Str_mu]);