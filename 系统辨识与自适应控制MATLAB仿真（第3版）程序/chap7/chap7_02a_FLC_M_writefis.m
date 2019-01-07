%������ϵͳģ���߼����ƣ�����FIS + writefis��
clear all; close all;

a = newfis('fuzcon_m'); %�½�FIS

%����������e��ec��uc�������������������Σ�
a = addvar(a, 'input', 'e', [-6 6]);
a = addmf(a, 'input', 1, 'NB', 'trimf', [-8 -6 -4]);
a = addmf(a, 'input', 1, 'NM', 'trimf', [-6 -4 -2]);
a = addmf(a, 'input', 1, 'NS', 'trimf', [-4 -2  0]);
a = addmf(a, 'input', 1, 'Z', 'trimf', [-2  0  2]);
a = addmf(a, 'input', 1, 'PS', 'trimf', [0   2  4]);
a = addmf(a, 'input', 1, 'PM', 'trimf', [2   4  6]);
a = addmf(a, 'input', 1, 'PB', 'trimf', [4   6  8]);

a = addvar(a, 'input', 'ec', [-6 6]);
a = addmf(a, 'input', 2, 'NB', 'trimf', [-8 -6 -4]);
a = addmf(a, 'input', 2, 'NM', 'trimf', [-6 -4 -2]);
a = addmf(a, 'input', 2, 'NS', 'trimf', [-4 -2  0]);
a = addmf(a, 'input', 2, 'Z', 'trimf', [-2  0  2]);
a = addmf(a, 'input', 2, 'PS', 'trimf', [0   2  4]);
a = addmf(a, 'input', 2, 'PM', 'trimf', [2   4  6]);
a = addmf(a, 'input', 2, 'PB', 'trimf', [4   6  8]);

a = addvar(a, 'output', 'uc', [-6 6]);
a = addmf(a, 'output', 1, 'NB', 'trimf', [-8 -6 -4]);
a = addmf(a, 'output', 1, 'NM', 'trimf', [-6 -4 -2]);
a = addmf(a, 'output', 1, 'NS', 'trimf', [-4 -2  0]);
a = addmf(a, 'output', 1, 'Z', 'trimf', [-2  0  2]);
a = addmf(a, 'output', 1, 'PS', 'trimf', [0   2  4]);
a = addmf(a, 'output', 1, 'PM', 'trimf', [2   4  6]);
a = addmf(a, 'output', 1, 'PB', 'trimf', [4   6  8]);

figure(1)
plotmf(a, 'input', 1); %����ָ��������������������
xlabel('e��ec��uc');

%���������
r0=[1 1 2 2 3 3 4
    1 2 2 3 3 4 5
    2 2 3 3 4 5 5
    2 3 3 4 5 5 6
    3 3 4 5 5 6 6
    3 4 5 5 6 6 7
    4 5 5 6 6 7 7]; %���ƹ����
for i = 1: 7
    for j = 1:7
        r1((i-1)*7+j,:) = [i, j, r0(i,j)];
    end
end
rulelist = [r1, ones(49,2)];
a = addrule(a, rulelist); %��ӹ���

writefis(a,'fuzcon_m'); %�����õ�FIS���浽���̵ĵ�ǰĿ¼��