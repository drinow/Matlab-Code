A=imread('football.jpg');                                %��ȡ����ʾͼ��
B=size(A);                                             %ͼ���б�
C=zeros(B(1)+round(B(2)*tan(pi/6)),B(2),B(3));
for m=1:B(1)
     for n=1:B(2)
        C(m+round(n*tan(pi/6)),n,1:B(3))=A(m,n,1:B(3));
end
end
figure,imshow(uint8(C));                              %��ʾ�б��ͼ��
