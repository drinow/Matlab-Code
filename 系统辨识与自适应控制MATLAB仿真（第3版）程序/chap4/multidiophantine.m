function [E,F,G]=multidiophantine(a,b,c,N)
%********************************************************
  %���ܣ��ಽDiophanine���̵����
  %���ø�ʽ��[E,F,G]=sindiophantine(a,b,c,N)��ע��d=1��
  %�������������ʽA��B��Cϵ��������Ԥ�ⲽ������4����
  %���������Diophanine���̵Ľ�E��F��G����3����
%********************************************************
na=length(a)-1; nb=length(b)-1; nc=length(c)-1; %A��B��C�Ľ״�

%E��F��G�ĳ�ֵ
E=zeros(N); E(1,1)=1; F(1,:)=conv(b,E(1,:)); 
if na>=nc
    G(1,:)=[c(2:nc+1) zeros(1,na-nc)]-a(2:na+1); %��c(nc+2)=c(nc+3)=...=0
else
    G(1,:)=c(2:nc+1)-[a(2:na+1) zeros(1,nc-na)]; %��a(na+2)=a(na+3)=...=0
end

%��E��G��F
for j=2:N
    for i=1:j-1
        E(j,i)=E(j-1,i);
    end
    E(j,j)=G(j-1,1);
    for i=2:na
        G(j,i-1)=G(j-1,i)-G(j-1,1)*a(i);
    end
    G(j,na)=-G(j-1,1)*a(na+1);
    F(j,:)=conv(b,E(j,:));
end