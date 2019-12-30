function []=MyDraw(DrawData)
global Forward_control;
global h_axes body leg min_x max_x;
global dt time x y xd yd ;
global hip_torque leg_angle body_angle leg_angled body_angled;
global leg_state foot_x foot_y leg_lengthd leg_length rest_leg_length;
flag=1;

wholesize=size(DrawData);
wholesize=wholesize(1);


%Plot Horizontal velocity

figure(1);
plot(DrawData(:,5),DrawData(:,6));hold on;
plot([0,42],[Forward_control.x_der_target*0.38,Forward_control.x_der_target*0.38]);hold off;
ylabel("Vel (m/s)")
xlabel("Time (s)")
title("Horizontal Vel")
ylim([-2 5]);
xlim([0 42]);


set(gcf,'position',[150 50 500 400]);
hold off;

%Vertical displacement
figure(3)
plot(DrawData(:,5),DrawData(:,3));
% plot([0,42],[0.5,0.5]);hold off;
ylabel("Displacement (m)")
xlabel("Time (s)")
title("Vertical Displacement")
ylim([-1 3]);
xlim([0 42]);
set(gcf,'position',[700 50 500 400]);
hold off;

%Total Energy
figure(4)
plot(DrawData(:,5),DrawData(:,12));
% plot([0,42],[0.5,0.5]);hold off;
ylabel("Energy (J)")
xlabel("Time (s)")
title("Total Energy")
xlim([0 42]);
ylim([75 145]);
set(gcf,'position',[1250 50 500 400]);
hold off;


%Animation
figure(2)
hold on;
p=plot([DrawData(flag,1);DrawData(flag,2)],[DrawData(flag,3); DrawData(flag,4)],'-ko','linewidth',2,'markeredgecolor','r','markerfacecolor','0.49,1,0.65','markersize',3);

r = plot([DrawData(flag,1)-0.25; DrawData(flag,1)-0.25; DrawData(flag,1)+0.25; DrawData(flag,1)+0.25; DrawData(flag,1)-0.25],...
    [DrawData(flag,3)-0.05; DrawData(flag,3)+0.05; DrawData(flag,3)+0.05; DrawData(flag,3)-0.05; DrawData(flag,3)-0.05], '-b', 'LineWidth', 1.5);

ground=plot([DrawData(flag,2)-5;DrawData(flag,2)+5],[0;0],'-ko','linewidth',2);
xlim([4 9]);
ylim([-0.5 5]);
xlabel("X(m)")
ylabel("Z(m)")
axis equal;
hold off;


 figure(2)
for flag=2:1:wholesize
    %当有数据的时候 
        figure(2)
        hold on;
        set(p,'XData',[DrawData(flag,1);DrawData(flag,2)],'YData',[DrawData(flag,3); DrawData(flag,4)]);
        
        set(r,'XData',[DrawData(flag,1)-0.25; DrawData(flag,1)-0.25; DrawData(flag,1)+0.25; DrawData(flag,1)+0.25; DrawData(flag,1)-0.25],...
            'YData',[DrawData(flag,3)-0.05; DrawData(flag,3)+0.05; DrawData(flag,3)+0.05; DrawData(flag,3)-0.05; DrawData(flag,3)-0.05]);
        
        set(ground,'XData',[DrawData(flag,2)-5;DrawData(flag,2)+5],'YData',[0;0]);
       
        
        title(["Time: ",num2str(DrawData(flag,5))]);
        hold off;
        flag=flag+1;
        pause(0.002);
        
end
% set(body,'Parent',h_axes,'Xdata',[x - bdx x + bdx], ...
% 'Ydata',[y - bdy y + bdy],0'visible','on');


end