global h_axes body leg min_x max_x
global dt time x y xd yd 
global hip_torque leg_angle body_angle leg_angled body_angled
global leg_state foot_x foot_y leg_lengthd leg_length rest_leg_length

scrsz = get(0,'ScreenSize');
animation = figure(1);

min_x = -1.0; % display size in robot units
max_x = 1.0;

color0 = [0 0 0];
color1 = [1 0 0];
color2 = [0 0 1];
color3 = [0 1 0];
color4 = [1 0 1];
color5 = [1 1 0];

set(animation,'name','My Robot','Position',[20 100 500 500]);
h_axes = axes('Parent',animation,'Units','Pixels','Position',[0 0 500 500],'Ylim',[0 (max_x - min_x)],'Xlim',[min_x max_x]);

body = line('Parent',h_axes,'Color',color0,'Visible','off','LineWidth',10);
leg = line('Parent',h_axes,'Color',color1,'Visible','off','LineWidth',10);

set(h_axes,'visible','on');
