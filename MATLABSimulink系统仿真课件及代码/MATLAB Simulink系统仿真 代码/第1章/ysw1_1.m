% ����
clc
clear
close all
 A={[1:5];'ysw swjtu yu sheng wei'}
 
B=cell(1,3);									%�����յ�Ԫ������
B{1,1}=[1:5];B{1,2}=ones(2);B{1,5}='swjtu ysw ';	%ΪԪ����Ԫ�ظ�ֵ
celldisp(B)									%��ʾԪ������B
%%
clc,clear,close all
A.b1=111;								        %ֱ�Ӹ�ֵ
A.b2=ones(3);
A.b3='Matlab 2014a';
B=struct('b1',1,'b2',ones(2),'b3','Matlab 2014a by SWJTU YSW')		%ʹ��struct������ֵ

%%
clc,clear,close all
format long
x1 = 2^-3
x2 = 2^30 

%%

clc,clear,close all
pi
format long
pi
format short
pi
format rat
pi
digits(10);
vpa(pi)
vpa(pi,15)

%%
clc,clear,close all
syms a b
y=a
y1 = a+1
y2 = y1-2

%%
clc,clear,close all
a = 'pi'
b=double(a)
b1=str2num(a)
c=11*a
d=11*b
d=11*b1



