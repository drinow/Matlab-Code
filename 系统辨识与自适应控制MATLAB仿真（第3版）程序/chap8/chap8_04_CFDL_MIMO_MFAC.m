% ����CFDL��MIMO��ģ������Ӧ����
clear all; close all;

m = 2; % m����m���ϵͳ
ny = 1; nu = 1; % ϵͳ�ṹ����

N = 1500; % ���泤��
uk = zeros(m,nu); % ���������ֵ��uk(1,i)��ʾu1(k-i);
yk = zeros(m,ny); % ϵͳ�����ֵ
duk = zeros(m,1); % ��������������ֵ
xk = zeros(4,1); % ״̬��ֵ
yr(1,1) = 0.5 + 0.25*cos(0.25*pi*0/100) + 0.25*sin(0.5*pi*0/100); % �������
yr(2,1) = 0.5 + 0.25*sin(0.25*pi*0/100) + 0.25*sin(0.5*pi*0/100);

% ���ÿ���������
Phihk = [0.5  0.01; 0.01  0.5]; Phih0 = Phihk;
eta = 1;
mu = 1;
rho = 1;
lambda = 0.5;
b1 = 0.08;
b2 = 0.4;
alpha = 1.5;

for k = 1:N
    time(k) = k;
    
    % ϵͳ���
    a(k) = 1 + 0.1*sin(2*pi*k/1500);
    b(k) = 1 + 0.1*cos(2*pi*k/1500);
    x(1,k) = xk(1)^2/(1+xk(1)^2) + 0.3*xk(2);
    x(2,k) = xk(1)^2/(1+xk(2)^2+xk(3)^2+xk(4)^2) + a(k)*uk(1,1);
    x(3,k) = xk(3)^2/(1+xk(3)^2) + 0.2*xk(4);
    x(4,k) = xk(3)^2/(1+xk(1)^2+xk(2)^2+xk(4)^2) + b(k)*uk(2,1);
    y(1,k) = x(1,k);
    y(2,k) = x(3,k);
    
    % �������
    yr(1,k+1) = 0.5 + 0.25*cos(0.25*pi*k/100) + 0.25*sin(0.5*pi*k/100);
    yr(2,k+1) = 0.5 + 0.25*sin(0.25*pi*k/100) + 0.25*sin(0.5*pi*k/100);
    
    % ��������
    dy(:,k) = y(:,k) - yk(:,1); 
    Phih(:,:,k) = Phihk + eta*(dy(:,k)-Phihk*duk)*duk'/(mu+norm(duk)^2);
    for i = 1:m
        for j = 1:m
            if i==j
                if abs(Phih(i,j,k))<b2 | abs(Phih(i,j,k))>alpha*b2 | sign(Phih(i,j,k))~=sign(Phih0(i,j))
                    Phih(i,j,k) = Phih0(i,j);
                end
            else
                if abs(Phih(i,j,k))>b1 | sign(Phih(i,j,k))~=sign(Phih0(i,j))
                    Phih(i,j,k) = Phih0(i,j);
                end
            end
            phih((i-1)*m+j,k) = Phih(i,j,k);
        end
    end
    
    % ����������
    du(:,k) = rho*Phih(:,:,k)'*(yr(:,k+1)-y(:,k))/(lambda+norm(Phih(:,:,k))^2);
    u(:,k) = uk(:,1) + du(:,k);
    
    % ��������
    Phihk = Phih(:,:,k);
    xk = x(:,k);
    
    duk = du(:,k);
    for i = nu:-1:2
        uk(:,i) = uk(:,i-1);
    end
    uk(:,1) = u(:,k);
    
    for i = ny:-1:2
        yk(:,i) = yk(:,i-1);
    end
    yk(:,1) = y(:,k);
end
figure(1);
plot(time,yr(1,1:N),'r--',time,y(1,:),'b');
xlabel('k'); ylabel('�����������'); %axis([0 N 0 1.2]);
legend('y_{r1}(k)','y_1(k)');
figure(2);
plot(time,yr(2,1:N),'r--',time,y(2,:),'b');
xlabel('k'); ylabel('�����������'); %axis([0 N 0 1]);
legend('y_{r2}(k)','y_2(k)');
figure(3)
plot(time,u);
xlabel('k'); ylabel('��������'); %axis([0 N 0 2.5]);
legend('u_1(k)','u_2(k)');
figure(4)
plot(time,phih,'LineWidth',1.5);
xlabel('k'); ylabel('α�ſ˱Ⱦ������ֵ'); %axis([0 N 0 0.6]);
legend('\phi_{11}(k)����ֵ','\phi_{12}(k)����ֵ','\phi_{21}(k)����ֵ','\phi_{22}(k)����ֵ','Location','best');