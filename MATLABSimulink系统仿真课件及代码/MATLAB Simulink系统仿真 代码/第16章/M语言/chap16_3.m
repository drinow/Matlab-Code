A=imread('rice.png');                %���벢��ʾͼ��
B=fspecial('Sobel');                        %��Sobel���ӽ��б�Ե��
fspecial('Sobel');
B=B';                                       %Sobel��ֱģ��
C=filter2(B,A);
figure
subplot(121),imshow(A);                  %��ʾ��ӽ����������ͼ��
subplot(122),imshow(C);                  %��ʾƽ�������ͼ��
