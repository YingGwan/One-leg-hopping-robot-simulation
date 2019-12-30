function [value,isterminal,direction] = eventfun_flight(t,z)
global angle_leg;
value=z(2)-0.5*sin(angle_leg); %触发时间，当其值为0的时候，时间会触发 z(1) z(2) z(3) z(4)
%设为1时会，触发时间会停止求解器，设0时触发不影响工作
isterminal=1;
direction=-1; %触发方向设1时是上升触发，设-1是下降触发，设0是双向触发
end