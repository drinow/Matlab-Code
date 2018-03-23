function [xe,pk,p1]=kalmanfun(A,C,Q,R,xe,z,p)
%This function is to calculate the estimation state by Kalman filter.
%This function is to calculate the estimation state by Kalman filter.
%���������A�����̾���    C����������    Q��������������    R��������������
%          xe��ǰһ��״̬����ֵ     x(k-1|k-1)   
%           z����ǰ����ֵ           z(k)
%           p��ǰһ��״̬���Ʒ���   P(k-1|k-1)
%���������xe����ǰ��״̬����ֵ     x(k|k)   
%          pk����ǰһ��״̬���Ʒ��� P(k|k-1) 
%          p1����ǰ��״̬���Ʒ���   P(k|k)
   xe=A*xe;
   p1=A*p*A'+Q;
   K=p1*C'*inv(C*p1*C'+R);
   xe=xe+K*(z-C*xe);
   pk=(eye(size(p1))-l*C)*p1;