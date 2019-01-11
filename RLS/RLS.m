%FTF���ٺ����˲��㷨
clc;
clear all;
close all;
%************************���ɷ����ź�**************************************
Fs = 10000;                                                     %���ò���Ƶ��
t = 0:1/Fs:3.5;  
t = t';
Size_t = size(t,1);
F1 = 2;
F2 = 10;
F3 = 20;
F4 = 1000;
Signal = sin(2*pi*F1*t) + 0.5*sin(2*pi*F2*t) + 0.25*sin(2*pi*F3*t); %�����ź�
% Signal=log(t+1);
noise_amp = 1;                                           %���������ı�׼��
noise1 = noise_amp*randn(Size_t,1);                        %���ɸ�˹������
noise2 = noise_amp*randn(Size_t,1);
noise3 = 5*sin(2*pi*F4*t);

noise = noise2;
Signal_noise = Signal + 0.2*noise;                           %�����˹������
Signal_noise(2:end) = Signal_noise(2:end) + 0.15*noise(1:end-1);
Signal_noise(3:end) = Signal_noise(3:end) + 0.1*noise(1:end-2);

subplot(2,1,1);
plot(t,Signal);
title('ԭʼ�ź�');
subplot(2,1,2);
plot(t,Signal_noise);
title('��������������ź�');
%*************************************************************************
N = 3;                     %����FIR�˲�������
Signal_Len = Size_t;       %�����ź����ݵĸ���
lambda = 1;                %������������
delta = 0.01;    
y_out = zeros(Signal_Len,1);
Eta_out = zeros(Signal_Len,1);
w_out = zeros(Signal_Len,N);
for i = 1:Signal_Len
    if i==1
        w_f_last = zeros(N,1);
        w_b_last = zeros(N,1);
        w_last = zeros(N,1);
        Phi_last = zeros(N,1);
        gamma_last = 1;
        xi_f_last = delta;
        xi_b_last = delta;
        x_N_1 = zeros(N+1,1);
    end
    %��������
    if i<= N
        x_N_1(1:i) = noise(i:-1:1,1);
    else        
        x_N_1 = noise(i:-1:(i-N),1);
    end    
    d = Signal_noise(i);
    %�㷨����
    e_f = x_N_1' * [1;-w_f_last];                                          %(1)
    epsilon_f = e_f * gamma_last;                                          %(2)
    xi_f = lambda * xi_f_last + e_f * epsilon_f;                           %(3)
    w_f = w_f_last + Phi_last * epsilon_f;                                 %(4)
    Phi_N_1 = [0;Phi_last] + e_f/(lambda * xi_f_last)*[1;-w_f_last];       %(5)
    Phi_N_1_N_1 = Phi_N_1(end);
    gamma_N_1 = (lambda * xi_f_last)/xi_f * gamma_last;                    %(6)
    e_b = lambda * xi_b_last * Phi_N_1_N_1;                                %(7)
    gamma = 1/(1/gamma_N_1 - Phi_N_1_N_1*e_b);                             %(8)
    epsilon_b = e_b * gamma;                                               %(9)
    xi_b = lambda * xi_b_last + epsilon_b * e_b;                           %(10)
    Phi = Phi_N_1 - Phi_N_1_N_1 * [-w_b_last;1];                           %(11)
    Phi = Phi(1:end-1);                                                    
    w_b = w_b_last + Phi * epsilon_b;                                      %(12)
    x = x_N_1(1:N);
    y = w_last'* x;                                                  
    e = d - y;                                                             %(13)
    epsilon = e * gamma;                                                   %(14)
    w = w_last + Phi * epsilon;                                            %(15)
    %��������
    xi_f_last = xi_f;
    w_f_last = w_f;
    gamma_last = gamma;
    xi_b_last = xi_b;
    Phi_last = Phi;
    w_b_last = w_b;
    w_last = w;
    %�˲�����洢
    y_out(i) = y;
    Eta_out(i) = e;
    w_out(i,:) = w';
end
figure;
subplot(2,1,1);
plot(y_out);
title('�˲������');
subplot(2,1,2);
plot(Eta_out);
title('������');

figure;
plot(t(1:Signal_Len),w_out(:,1),'r',t(1:Signal_Len),w_out(:,fix(N/2)+1),'b',t(1:Signal_Len),w_out(:,N),'y');
title('����Ӧ�˲���ϵ��');