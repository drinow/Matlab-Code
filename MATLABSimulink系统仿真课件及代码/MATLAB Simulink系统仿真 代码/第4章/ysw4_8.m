clc,clear,close all
bdclose all
new_system('ysw4_9'); % �½�һ��ysw4_9ϵͳ

%%
clc,clear,close all
bdclose all
open_system('ysw4_4') % ��simulink�ⴰ��

%%
clc,clear,close all
bdclose all
open_system('ysw4_7') % ��simulink�ⴰ��
save_system('ysw4_7','ysw4_10')

%%
clc,clear,close all
bdclose all
open_system('ysw4_10') % ��simulink�ⴰ��
add_line('ysw4_10','Sine Wave/1','Scope/1')
delete_line('ysw4_10','Sine Wave/1','Scope/1')



