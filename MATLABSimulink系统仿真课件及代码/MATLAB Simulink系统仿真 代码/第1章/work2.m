% �ڶ���
clc,clear,close all
p1 = conv([1,0,1],conv([1,3],[1,1]));
p2 = [1,2,1];
[q,r] = deconv(p1,p2)
disp(['�̶���ʽΪ��',poly2str(q,'t')])
disp(['�����ʽΪ��',poly2str(r,'t')])


