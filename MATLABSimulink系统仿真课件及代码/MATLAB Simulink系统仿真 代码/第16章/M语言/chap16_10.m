A=imread('cell.tif');                     %��ȡ����ʾͼ��
SE=strel('disk',4,4);                            %����ģ��
B=imdilate(A,SE);                             %��ģ������
C=imerode(A,SE);                             %��ģ�帯ʴ
figure
subplot(131),imshow(A);
subplot(132),imshow(B);
subplot(133),imshow(C);
