% ����FFDL����ģ������Ӧ����
clear all; close all;

ny = 3; nu = 3; % ϵͳ�ṹ����

N = 800; % ���泤��
Ly = 1; Lu = 1; % ϵͳα����
uk = zeros(nu,1); % ���������ֵ��uk(i)��ʾu(k-i);
yk = zeros(ny,1); % ϵͳ�����ֵ
dyk = zeros(Ly,1); % ϵͳ���������ֵ
duk = zeros(Lu,1); % ��������������ֵ
yr(1) = 2*sin(0/50) + cos(0/20); % ���������ֵ

% ���ÿ���������
Phihk = ones(Ly+Lu,1); Phih0 = Phihk;
eta = 0.2;
mu = 1;
rho = 0.7*ones(Ly+Lu,1);
lambda = 0.001;
epsilon = 10^(-5);

for k = 1:N
    time(k) = k;
    
    % ϵͳ���
    if k <= 400
        y(k) = 0.55*yk(1) + 0.46*yk(2) + 0.07*yk(3) + 0.1*uk(1) + 0.02*uk(2) + 0.03*uk(3);
    else
        y(k) = -0.1*yk(1) - 0.2*yk(2) - 0.3*yk(3) + 0.1*uk(1) + 0.02*uk(2) + 0.03*uk(3);
    end
    
    % �������
    yr(k+1) = 2*sin(k/50) + cos(k/20);
    
    % ��������
    dy(k) = y(k) - yk(1);
    dHk = [dyk; duk];
    Phih(:,k) = Phihk + eta*dHk*(dy(k)-Phihk'*dHk)/(mu+norm(dHk)^2);
    if norm(Phih(:,k))<=epsilon | norm(dHk)<=epsilon | sign(Phih(Ly+1,k))~=sign(Phih0(Ly+1))
        Phih(:,k) = Phih0;
    end
    
    % ����������
    sumrpdy = 0;
    for i = 1:Ly
        if i == 1
            sumrpdy = sumrpdy + rho(i)*Phih(i,k)*dy(k);
        else
            sumrpdy = sumrpdy + rho(i)*Phih(i,k)*dyk(i-1);
        end
    end
    sumrpdu = 0;
    for i = Ly+2:Ly+Lu
        sumrpdu = sumrpdu + rho(i)*Phih(i,k)*duk(-Ly+i-1);
    end
    du(k) = Phih(Ly+1,k)*(rho(Ly+1)*(yr(k+1)-y(k)) - sumrpdy - sumrpdu)/(lambda+Phih(Ly+1,k)^2);
    u(k) = uk(1) + du(k);
    
    % ��������
    Phihk = Phih(:,k);
    
    for i = Ly:-1:2
        dyk(i) = dyk(i-1);
    end
    if Ly >= 1
        dyk(1) = dy(k);
    end
    
    for i = Lu:-1:2
        duk(i) = duk(i-1);
    end
    duk(1) = du(k);
    
    for i = nu:-1:2
        uk(i) = uk(i-1);
    end
    uk(1) = u(k);
    
    for i = ny:-1:2
        yk(i) = yk(i-1);
    end
    yk(1) = y(k);
end
figure(1);
plot(time,yr(1:N),'r--',time,y,'b');
xlabel('k'); ylabel('�����������');
legend('y_r(k)','y(k)'); %axis([0 N -3 4]);
figure(2)
plot(time,u,'b');
xlabel('k'); ylabel('��������'); %axis([0 N -40 40]);
figure(3)
plot(time,Phih);
xlabel('k'); ylabel('α�ݶȹ���ֵ'); %axis([0 N 0 1.2]);
legend('\phi_1(k)����ֵ','\phi_2(k)����ֵ');