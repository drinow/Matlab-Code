%�ಽDiophantine���̵����
clear all;

a=[1  -3  3.1  -1.1]; b=[1 2]; c=[1];
na=length(a)-1; nb=length(b)-1; nc=length(c)-1; %A��B��C�Ľ״�
N=2; %Ԥ�ⲽ��

[E,F,G]=multidiophantine(a,b,c,N) %���ú���multidiophantine�������MATLAB����ڣ�