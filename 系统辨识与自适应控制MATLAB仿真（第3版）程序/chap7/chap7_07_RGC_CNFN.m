% ���ڹ�ϵ�Ⱦ���Ĳ���ģ���������ʶ
clear all; close all;

[t,x] = ode45(@nonsys,[0 20],[1.0 1.0]); % ��΢�ַ���
y = sin(x(:,1)+x(:,2));
[N,n] = size(x); % NΪ���ݸ�����nΪϵͳ�����ά��

eta = 0.5; % ѧϰ����
E = 0.02; % ȫ������

rbar = 0.932; % ����Ԥ�������Խ�����Խϸ���ࣩ

% ����x��x֮���������
x = [x, y]; % �����������
v = x;
for k = 1:N
    for j = k:N
        d(k,j) = norm(x(k,:)-x(j,:));
    end
end
dmax = max(max(d));

% ��������������㷨��Step2-Step5
w = zeros(size(v));
cstep = 0; % �����������
while (1)
    for k = 1:N
        rvsum = 0;
        rsum = 0;
        for j = 1:N
            r(k,j) = 1-norm(v(k,:)-v(j,:))/dmax; 
            if r(k,j) < rbar
                r(k,j) = 0;
            end
            rvsum = rvsum + r(k,j)*v(j,:);
            rsum = rsum + r(k,j);
        end
        w(k,:) = rvsum/rsum;
    end
    cstep = cstep + 1;
    wvsum = sum(sum(roundn(w,-10)==roundn(v,-10)));
    if wvsum == N*(n+1)
        break;
    else
        v = w;
    end
end

% ��v��ȡ����������
M = 1; % MΪ������
c(1,:) = v(1,:); % cΪ���������
for k = 2:N
    for j = 1:M
        vsum(j) = sum(roundn(v(k,:),-10)==roundn(c(j,:),-10));
    end
    if max(vsum) ~= n+1 
        M = M + 1;
        c(M,:) = v(k,:);
    end
end
ak = c(:,1:n); % ���������������ĵĳ�ֵ
bk = c(:,n+1); % ��������������ĵĳ�ֵ

% ���ݾ���������ԭʼ���ݹ���
nn = zeros(M,1);
for k = 1:N
    for j = 1:M
        if sum(abs(v(k,:)-c(j,:))) < 10^(-10)
            nn(j) = nn(j) + 1;
            xx(nn(j),:,j) = x(k,:);
            break;
        end
    end
end

% ���������������������ȵĳ�ֵ
mx(1,:) = 0.1*ones(1,n+1);
for j = 1:M
    if nn(j) ~= 1
        mx(j,:) = max(abs(xx(1:nn(j),:,j)-ones(nn(j),1)*c(j,:)));
    else
        mx(j,:) = mean(mx);
    end
    sigmak(j,:) = 2*mx(j,1:n);
    deltak(j,1) = 2*mx(j,end);
end
% �����ǳ�С�������������
for j = 1:M
    for i = 1:n
        if sigmak(j,i) < 0.1
            sigmak(j,i) = mean(sigmak(:,i));
        end
    end
    if deltak(j) < 0.1
        deltak(j) = mean(deltak);
    end
end

% ���ò����ȵĳ�ֵ
for j = 1:M
    fk(j) = 0.1; hk(j) = 0.1;
    gammak(j) = fk(j)^2/(fk(j)^2+hk(j)^2); % ������
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
        O1 = x(k,:);
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
plot(t,y,'k',t,ym,'k--')
xlabel('ʱ��t���룩');
ylabel('ʵ�����/�������');
legend('ʵ�����', '�������','Location','southwest');
figure(2)
plot(1:num,es,'k')
xlabel('ѵ������������');
ylabel('ȫ����� E=0.02');