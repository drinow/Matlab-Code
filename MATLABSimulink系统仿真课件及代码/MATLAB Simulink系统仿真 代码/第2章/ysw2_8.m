clc,clear,close all
open_system('ysw2_9.slx');
add_block('built-in/Step','ysw2_9/Step','position',[20,100,40,120]) %��ӽ�Ծ�ź�ģ��
add_block('built-in/Sum','ysw2_9/Sum','position',[60,100,80,120])  	%���Sumģ��
%��Ӵ��ݺ���ģ��
add_block('built-in/Transfer Fcn','ysw2_9/Fcn1','position',[120,90,200,130])  
%���ʾ����ģ��
add_block('built-in/Scope','ysw2_9/Scope','position',[240,100,260,120])
add_line('ysw2_9','Step/1','Sum/1')  							 %�������
add_line('ysw2_9','Sum/1','Fcn1/1')
add_line('ysw2_9','Fcn1/1','Scope/1')
add_line('ysw2_9','Fcn1/1','Sum/2')

%%
delete_block('ysw2_9/Scope')

%%
clc,clear,close all
open_system('ysw2_9.slx');
f1=simget('ysw2_9')

%%
clc,clear,close all
open_system('ysw2_9.slx');
set_param('ysw2_9','StopTime','15')  				%���ò���ֹͣʱ��
set_param('ysw2_9/Step','time','0')  				%���ý�Ծ�ź�����ʱ��
set_param('ysw2_9/Sum','Inputs','+-')  			%����Sumģ���źŵķ���
set_param('ysw2_9/Fcn1','Denominator','[1 0.6 0]')  	%���ô��ݺ�����ĸ

[t,x,y]=sim('ysw2_9',[0,15]); 
plot(t,x(:,2))


