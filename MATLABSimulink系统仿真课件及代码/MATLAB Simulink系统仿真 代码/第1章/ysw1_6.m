clc,clear,close all
t=0:0.1:1.5;
Vx=2*t;
Vy=2*t.^2;
Vz=6*t.^3-t.^2;
x=t.^2;
y=(2/3)*t.^3;
z=(6/4)*t.^4-(1/3)*t.^3;  %���ٶȵõ�����
plot3(x,y,z,'r.-'),       %�����й켣
hold on             
%����ֵ�ݶȣ�Ҳ�������¼�����ֵ�ٶ�ʸ������ֻ��Ϊ�˱�̵ķ��㣬���Ǳ����
Vx=gradient(x);
Vy=gradient(y);
Vz=gradient(z);
quiver3(x,y,z,Vx,Vy,Vz),  %���ٶ�ʸ��ͼ
grid on       % դ��
xlabel('x')
ylabel('y')
zlabel('z')

