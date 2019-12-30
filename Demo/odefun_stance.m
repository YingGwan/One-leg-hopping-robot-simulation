function dx=odefun_stance(t,x)
dx=zeros(4,1);
%Replace with following values.
q=x(1);
L=x(2);
q_d=x(3);
L_d=x(4);

if L_d<=0
Fleg=0;
else
%With thrust
Fleg=280;   
end
tuo_hip=0;

dx(1)=x(3);
dx(2)=x(4);
dx(3)=-(70*L*cos(q) - tuo_hip + 14*L*L_d*q_d)/(7*L^2);
%Without Damping.
% dx(4)= L*q_d^2 + Fleg/7 - 400*L - 10*sin(q) + 200;
%With Damping.
dx(4)=L*q_d^2 + Fleg/7 - 400*L - 10*sin(q) + 200 -5*L_d;
end