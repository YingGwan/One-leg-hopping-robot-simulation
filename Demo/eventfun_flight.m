function [value,isterminal,direction] = eventfun_flight(t,z)
global angle_leg;
value=z(2)-0.5*sin(angle_leg); %����ʱ�䣬����ֵΪ0��ʱ��ʱ��ᴥ�� z(1) z(2) z(3) z(4)
%��Ϊ1ʱ�ᣬ����ʱ���ֹͣ���������0ʱ������Ӱ�칤��
isterminal=1;
direction=-1; %����������1ʱ��������������-1���½���������0��˫�򴥷�
end