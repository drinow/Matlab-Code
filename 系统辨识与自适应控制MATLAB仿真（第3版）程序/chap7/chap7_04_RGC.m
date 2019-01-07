% ��ϵ�Ⱦ���
clear all; close all;

n = 1; % �����㷨�е�n
N = 15; % ���������ĸ���
rbar = 0.7; % ����Ԥ�������Խ�����Խϸ���ࣩ

% ���������������
x = [0.6  0.7
    0.1  0.4
    0.5  0.6
    0.3  0.4
    0.7  0.2
    0.6  0.6
    0.9  0.2
    0.7  0.6
    0.2  0.4
    0.6  0.5
    0.8  0.3
    0.2  0.5
    0.8  0.2
    0.2  0.3
    0.8  0.1];

% ����x��x֮���������
v = x;
for k = 1:N
    for j = k:N
        d(k,j) = norm(x(k,:)-x(j,:));
    end
end
dmax = max(max(d));

% ���������Step2-Step5
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

figure(1)
plot(x(:,1),x(:,end),'b*','LineWidth',1); hold on;
plot(c(:,1),c(:,end),'rO','LineWidth',2,'MarkerSize',10); hold off
axis([0 1 0 0.8]);
legend('ԭʼ����','��������','Location','northwest')
xlabel('ԭʼ����x_1');
ylabel('ԭʼ����x_2');