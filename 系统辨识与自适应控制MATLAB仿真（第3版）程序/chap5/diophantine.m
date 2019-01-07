function [F1,G]=diophantine(A,B,d,A0,Am)
%***********************************************************************
  %���ܣ�Diophanine���̵����
  %���ø�ʽ��[F1,G]=diophantine(A,B,d,A0,Am)
  %�������������ʽA��Bϵ�����������ӳ�d������ʽA0��Amϵ����������������
  %���������Diophanine���̵Ľ�F1��G����������
%***********************************************************************  
dB=[zeros(1,d) B];
na=length(A)-1; nd=length(dB)-1;
T1=conv(A0,Am); nt=length(T1); T=[T1';zeros(na+nd-nt,1)];

%�õ�Sylvester ����
AB=zeros(na+nd);
for i=1:na+1
    for j=1:nd
        AB(i+j-1,j)=A(i);
    end
end
for i=1:nd+1
    for j=1:na
        AB(i+j-1,j+nd)=dB(i);
    end
end
%�õ�F1,G
L=(AB)\T;
F1=[ L(1:nd)]';
G=[ L(nd+1:na+nd)]';