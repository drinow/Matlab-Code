A=imread('tire.tif');                           %��ȡͼ��
B=imnoise(A,'salt & pepper',0.02);         %��ӽ�������
K=medfilt2(B);                             %��ֵ�˲�
figure %��ʾ
subplot(121),imshow(B);                  %��ʾ��ӽ����������ͼ��
subplot(122),imshow(K);                  %��ʾƽ�������ͼ��

 