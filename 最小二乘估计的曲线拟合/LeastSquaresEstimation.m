clc;
clear;
close all
subplot(4,1,1)
t=0:0.01:9.99;
m=(t-5).*(t-5)+10;%��������
v=2;%����
s3=m+sqrt(v)*randn(1,1000);%��������������
plot(t,s3)
ea=[0;0;0];           %��ǰ����ֵ
M=diag([1 1 1])*1000;     %MΪһ��ĳ�ֵ
estiamte=[];        %���й���ֵ
W=1/v;              %Ȩֵ����ȡ�����

xlabel('Press Any Key To Continue!')
pause
for i=1:1000   
    h=[t(i)*t(i) t(i) 1]; %��������(����ֵ��at^2+bt+c=0; ���Ǻ�����α�ʾ��
    M=inv(inv(M)+h'*h);
    ea=ea+M*h'*W*(s3(i)-h*ea);%�¹���ֵ=�ɹ���ֵ+����*��Ϣ

    estiamte=[estiamte,ea]; %��¼����ֵ�ı仯

    subplot(4,1,1)
    hold on
    lastP1=plot(t,ea(1)*t.*t+ea(2)*t+ea(3),'r'); %���Ƶ����������
    xx=ones(round(ea(1)*t(1000)*t(1000)+ea(2)*t(1000)+ea(3)),1)*i*0.01; %�������߽�����
    yy=1:round(ea(1)*t(1000)*t(1000)+ea(2)*t(1000)+ea(3));
    lastPx=plot(xx,yy,'g');
    str=['ʣ��',num2str(1000-i),'����'];
    xlabel(str)
    hold off

    subplot(4,1,2)
    lastP2=plot(estiamte(1,:)); %����aϵ���ı仯����
    subplot(4,1,3)
    lastP3=plot(estiamte(2,:)); %����bϵ���ı仯����
    subplot(4,1,4)
    lastP4=plot(estiamte(3,:)); %����cϵ���ı仯����
    pause(0.01);
    if(i<1000)
        delete(lastP1)
        delete(lastPx)
    end
end
subplot(4,1,1)
xlabel('t')
ylabel('�������')
subplot(4,1,2)
ylabel('ϵ��a')
subplot(4,1,3)
ylabel('ϵ��b')
subplot(4,1,4)
xlabel('points')
ylabel('ϵ��c')