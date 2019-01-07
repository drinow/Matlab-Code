% ����CFDL����ģ������ӦԤ�����
clear all; close all;

ny = 4; nu = 3; % ϵͳ�ṹ����

N = 1000; % ���泤��
uk = zeros(nu,1); % ���������ֵ��uk(i)��ʾu(k-i);
yk = zeros(ny,1); % ϵͳ�����ֵ
duk = 0; % ��������������ֵ           
yr(1) = 5*(-1)^round(0/200); % ���������ֵ

% ���ÿ���������
Np = 5;
Nu = 2;
np = 3;
phihk = 2*ones(np,1); phih0 = phihk(1);
thetak = ones(np,1); theta0 = thetak;
eta = 1;
mu = 2;
rho = 0.3;
lambda = 0.01;
delta = 1;
epsilon = 10^(-5);
M = 10;

for k = 1:N
    time(k) = k;
    
    % ϵͳ���
    if k <= 500
        y(k) = 2.5*yk(1)*yk(2)/(1+yk(1)^2+yk(2)^2) + 1.2*uk(1) + 1.4*uk(2) + 0.7*sin(0.5*(yk(1)+yk(2)))*cos(0.5*(yk(1)+yk(2)));
    else
        y(k) = -0.1*yk(1) - 0.2*yk(2) - 0.3*yk(4) + 0.1*uk(1) + 0.02*uk(2) + 0.03*uk(3);
    end
    
    % �������
    for i = 1:Np
        yr(k+i) = 5*(-1)^round((k+i)/200);
    end
    
    % phih(k)��������
    dy(k) = y(k) - yk(1);
    phih(k) = phihk(1) + eta*duk*(dy(k)-phihk(1)*duk)/(mu+duk^2);
    if abs(phih(k))<=epsilon | abs(duk)<=epsilon | sign(phih(k))~=sign(phih0)
        phih(k) = phih0;
    end
    
    % theta(k)��������
    theta(:,k) = thetak + phihk*(phih(k)-phihk'*thetak)/(delta+norm(phihk)^2);
    if norm(theta(:,k)) >= M
        theta(:,k) = theta0;
    end    
    
    % phih(k+j)��������
    for j = 1:Nu-1
        phih(k+j) = 0;
        for i = 1:np
            if j-i >= 0
                phih(k+j) = phih(k+j) + theta(i,k)*phih(k+j-i);
            else
                phih(k+j) = phih(k+j) + theta(i,k)*phihk(i-j);
            end
        end
        if abs(phih(k+j))<=epsilon | sign(phih(k+j))~=sign(phih0)
            phih(k+j) = phih0;
        end
    end
    
    % ���������
    Ah = [];
    for i = 0:Nu-1
        Ah = [Ah, phih(k+i)*[zeros(i,1); ones(Np-i,1)]];
    end
    E = ones(Np,1);
    Yr = yr(k+1:k+Np)';
    g = [1, zeros(1,Nu-1)]';
    u(k) = uk(1) + rho*g'*inv(Ah'*Ah+lambda*eye(Nu))*Ah'*(Yr - E*y(k));
    
    % ��������
    for i = np:-1:2
        phihk(i) = phihk(i-1);
    end
    phihk(1) = phih(k);
    
    thetak = theta(:,k);
    
    duk = u(k) - uk(1);
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
legend('y_r(k)','y(k)'); axis([0 N -6 8]);
figure(2)
plot(time,u,'b');
xlabel('k'); ylabel('��������'); %axis([0 N -60 60]);
figure(3)
plot(time,phih(1:N),'b');
xlabel('k'); ylabel('αƫ��������ֵ'); %axis([0 N 0 3]);
figure(4)
plot(time,theta);
xlabel('k'); ylabel('\bf\theta\rm����ֵ'); %axis([0 N -0.2 1]);
legend('\theta_1(k)����ֵ','\theta_2(k)����ֵ','\theta_3(k)����ֵ','Location','northwest');