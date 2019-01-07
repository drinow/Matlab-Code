% ����ģ���������ʶ
clear all; close all;

[t,x] = ode45(@nonsys,[0 20],[1.0 1.0]); % ��΢�ַ���
y = sin(x(:,1)+x(:,2));
[N,n] = size(x); % NΪ���ݸ�����nΪϵͳ�����ά��

eta = 0.5; % ѧϰ����
E = 0.02; % ȫ������

% ����������������������ĺͿ�ȼ������ȵĳ�ֵ
M = 25; % ģ��������
for j = 1:M
    ak(j,1) = 0.5 + 0.5*floor(j/5);
    ak(j,2) = 0.5 + 0.25*mod(j,5); % ����������������
    for i = 1:n
        sigmak(j,i) = 0.5; % ���������������
    end
    deltak(j) = 0.5; % ��������������
    fk(j) = 0.1; hk(j) = 0.1;
    gammak(j) = fk(j)^2/(fk(j)^2+hk(j)^2); % ������
end
% ���������������������
x1span = [0.5,0.75,1.25,1.75,2.25,2.5]; 
x2span = [0.4,0.625,0.875,1.125,1.375,1.5]; 
for i1 = 1:5
    for i2 = 1:5
        j = (i1-1)*5 + i2;
        nj = 0;
        for k = 1:N
            if x(k,1)>=x1span(i1) & x(k,1)<= x1span(i1+1)
                if x(k,2)>=x2span(i2) & x(k,2)<= x2span(i2+1)
                    nj = nj + 1;
                    Mj(j,nj) = k;
                end
            end
        end
        bk(j) = 0;
        if nj == 0
            bk(j) = 0.5;
        else
            for i = 1:nj
                bk(j) = bk(j) + y(Mj(j,i));
            end
            bk(j) = bk(j)/nj;
        end
    end
end

eg = 10; % ��ʼ��ȫ�����
num = 0; % ��ʼ��ѵ������
mstep = 100; % ���ѵ������
tic
while (eg >= E) % ��ȫ��������ѵ������
% while(num < mstep) % ֱ���趨ѵ������
    num = num+1;
    es(num) = 0;
    for k = 1:N
        % �����������
        O1 = x(k,1:n);
        bdo = 0;do = 0;
        for j = 1:M
            O3(j) = 1;
            for i = 1:n
                O2(j,i) = exp(-((O1(i)-ak(j,i))/sigmak(j,i))^2);
                O3(j) = O3(j)*O2(j,i);
            end
            gn(j) = 1 - gammak(j) + gammak(j)/n;
            O4(j) = O3(j)^gn(j);
            bdo = bdo + bk(j)*deltak(j)*O4(j);
            do = do + deltak(j)*O4(j); % ��ʽ�е�C
        end
        ym(k) = bdo/do;
        e(k) = y(k) - ym(k); 
        es(num) = es(num) + e(k)^2/2; % �ۼ����ƽ��  
        
        % ѵ������
        for j = 1:M
            % ����������������ĺͿ�ȵ�ѵ��
            Delta5 = ym(k) - y(k);
            db(j) = Delta5*deltak(j)*O4(j)/do;
            ddelta(j) = Delta5*(bk(j)-ym(k))*O4(j)/do;
            b(j) = bk(j) - eta*db(j);
            delta(j) = deltak(j) - eta*ddelta(j);
            % �Բ����ȵ�ѵ��
            Delta4(j) = Delta5*(bk(j)-ym(k))*deltak(j)/do;
            dgamma(j) = (1/n-1)*Delta4(j)*O4(j)*log(O3(j));
            f(j) = fk(j) - eta*(2*fk(j)*hk(j)^2/(fk(j)^2+hk(j)^2)^2)*dgamma(j);
            h(j) = hk(j) + eta*(2*hk(j)*fk(j)^2/(fk(j)^2+hk(j)^2)^2)*dgamma(j);
            gamma(j) = f(j)^2/(f(j)^2+h(j)^2);
            % �����������������ĺͿ�ȵ�ѵ��
            for i = 1:n
                da(j,i) = 2*Delta5*(bk(j)-ym(k))*deltak(j)*gn(j)*O4(j)*(O1(i)-ak(j,i))/(sigmak(j,i)^2*do);
                dsigma(j,i) = 2*Delta5*(bk(j)-ym(k))*deltak(j)*gn(j)*O4(j)*(O1(i)-ak(j,i))^2/(sigmak(j,i)^3*do);
                a(j,i) = ak(j,i) - eta*da(j,i);
                sigma(j,i) = sigmak(j,i) - eta*dsigma(j,i);
            end
        end
        
        %��������
        ak = a; 
        sigmak = sigma;
        fk = f; hk = h;
        gammak = gamma;
        bk = b;
        deltak = delta;
    end
    eg = es(num);
end
toc
figure(1)
plot(t,y,'b',t,ym,'r--')
xlabel('ʱ��t���룩');
ylabel('ʵ�����/�������');
legend('ʵ�����', '�������','Location','southwest');
figure(2)
plot(1:num,es,'b')
xlabel('ѵ������������');
ylabel('ȫ����� E=0.001');