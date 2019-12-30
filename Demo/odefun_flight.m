function dx=odefun_flight(t,x)
dx=zeros(4,1);
%Replace with following values.

dx(1)=x(3);
dx(2)=x(4);
dx(3)= 0;
dx(4)=-10;
end