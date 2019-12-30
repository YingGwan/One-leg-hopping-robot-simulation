%Hopping robot
%Designed By Team: YINGJUN TIAN & TIANYU ZHANG
%DATE: 12/26/2019
%Copyright Reserved
%%
%Model Parameter:

%[k,L0,m,g]->[2800,0.5,7,10]
%[kg,bg]->[None,None]
%Equations of motion:
%Q1=-(70*L*cos(q) - tuo_hip + 14*L*L_d*q_d)/(7*L^2) ->q
%Q2=     L*q_d^2 + Fleg/7 - 400*L - 10*sin(q) + 200 ->L

%With Damper:
%Q2=     L*q_d^2 + Fleg/7 - 400*L - 10*sin(q) + 200 -5*L_d

%%
clc;
close all;
clear;
global tuo_hip Fleg;
global angle_leg Xft;
global main_circle;
syms Zft Zft_d Xft q L q_d L_d L_dd;
syms Zft_dd q_dd;
syms Xb Zb;

syms kg bg k;
syms L0;
syms m g;

syms Xft;
syms Fleg;


syms tuo_hip;

angle_leg=95/180*pi;%Respect to horizontal axis, anti clock-wise.
clc;

Error_sum=0;
% MyInitDraw();
%%
global Forward_control;
Forward_control=Control();
global horizV_target;
%Using UI to get desired vel value;
Forward_control.x_der_target=horizV_target/Forward_control.coef;
% Forward_control.x_der_target=1.5/Forward_control.coef;
%%Testing parameters, not used.
% %Control leg angle parameters.             5      6     7    8
% angle_leg_target=[93 ;93.5;96.2;93.6;      96.15;93.58;96.1; 93.65;%8
%     %                    9       10   11    12   13    14    15   16
%                          96.05;93.52;96.1; 93.59;96.1; 93.34;96.3;93.30;
%     %                    17     18    19     20     21     22      23   24
%                          96.43;93.28;96.28; 93.36; 96.25 ;93.35; 96.4; 93.0;
%     %                    25     26    27     28     29     30      31    32                  
%                          96.8; 92.9; 96.6;  93.2; 96.36;  93.2;  96.68;  92.8; 
%     %                 33     34     35     36     37      38   39   40   !!41
%                       96.92; 92.6; 97.05;  92.7;  97.1;  92.2;97.65;92.20;96.2 ];angle_leg_target=angle_leg_target/180*pi;
% %%%%%%%%%%%%%%%%% 2   3   4   5   6   7  8   9


%Control leg angle parameters. 
angle_leg_target=[96 ;93.5;96.2];

%%
%Initial Value: Drop from 1 m.
%From height->1:falling down
h0=1;
Xb_d_init=0;
Zb_d_init=sqrt(2*10*h0);
L_d_init=Zb_d_init*sin(angle_leg)+Xb_d_init*cos(angle_leg);
q_d_init=(Zb_d_init*cos(angle_leg)-Xb_d_init*sin(angle_leg))/0.5;

%%
% %Animatioin
%%%%%Dynamic simulation
record=0;
q_record=0;
loopSum=40;%Parameter to determine mainloop sum.
for main_circle=1:loopSum
  if main_circle>1
    y0=[angle_leg,0.5,q_d_init,L_d_init];
    Xft=Xft_init;
    t_begin=q_record(size_i,5);t_end=t_begin+5;
  else
    y0=[angle_leg,0.5,q_d_init,L_d_init];
    Xft=5;
    t_begin=0;t_end=t_begin+5;
  end
disp("_______")
disp(main_circle)
Forward_control.time1=t_begin;
Forward_control.x_touchdown=Xft+0.5*cos(y0(1));

%Compression+Thrust->Stance dynamic
tspan=[t_begin,t_end];
op=odeset('Events',@eventfun_stance);
sol= ode45( @odefun_stance, tspan, y0 ,op);

%
T_ode45=size(sol.xe)
T_ode45=T_ode45(2);
T_ode=sol.xe(T_ode45);

T = linspace(tspan(1),T_ode,(T_ode-tspan(1))*100);

%equally divide time span into 100 parts
Y = deval(sol,T);
Y=Y';
T=T';
q_record=RecordYData_Stance(T,Y,q_record);%Add data to q_record.

Tlen=SizeOfVector(q_record);%Get matrix length.
Forward_control.time2=q_record(Tlen,5);
Forward_control.x_takeoff=Xft+q_record(Tlen,2)*cos(q_record(Tlen,1));


Forward_control.duration=Forward_control.time2-Forward_control.time1;
Forward_control.x_der=(Forward_control.x_takeoff-Forward_control.x_touchdown)/Forward_control.duration;
Forward_control.Xf0=Forward_control.x_der*Forward_control.duration/2;



%%
% %Stance->Take off transition
size_i=SizeOfVector(q_record);
L_d_ini=q_record(size_i,4);
L_ini=q_record(size_i,2);
q_d_ini=q_record(size_i,3);
q_ini=q_record(size_i,1);

Xb_d_ini=L_d_ini*cos(q_ini)-q_d_ini*L_ini*sin(q_ini);
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Forward_control.x_der=Xb_d_ini;
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Zb_d_ini=L_d_ini*sin(q_ini)+q_d_ini*L_ini*cos(q_ini);

Xb_ini=double(Xft+L_ini*cos(q_ini));
Zb_ini=L_ini*sin(q_ini);




%Forward Vel Control.

%Method 1:(Wrong)
% Forward_control.Xf=(Forward_control.x_takeoff-Forward_control.x_touchdown)/2+Forward_control.Kp*(Forward_control.x_der-Forward_control.x_der_target);
% Forward_control.leg_angle_control=asin(Forward_control.Xf/0.5);
% Forward_control.leg_angle_control=Forward_control.leg_angle_control+pi/2;
%Method 2:(Correct)
Forward_control.Xf=Forward_control.x_der*Forward_control.duration/2+Forward_control.Kp*(Forward_control.x_der-Forward_control.x_der_target);
Forward_control.leg_angle_control=asin(Forward_control.Xf/0.5);
Forward_control.leg_angle_control=Forward_control.leg_angle_control+pi/2;

% Forward Velocity Control strategy
%         Forward_control.Xf
%    ___    --------------
%            ~           |  
%              ~         |         
%     L0         ~       |    leg_angle_control=arcsin(Forward_control.Xf/L0)
%                  ~     |     If from horizontal axis, it is:
%                    ~   |     arcsin(Forward_control.Xf/L0)+pi/2
%    ___               ~ |



disp("Control angel:..")
disp(Forward_control.leg_angle_control/pi*180)
%%%%%
angle_leg=Forward_control.leg_angle_control;
if main_circle<2
    angle_leg=angle_leg_target(main_circle);
end
% 
% if main_circle>=2
%     angle_leg=Forward_control.leg_angle_control;
% end

draw_angle_leg(main_circle)=angle_leg;%¹À¼Æangle_leg



%%
%Flight Phase
size_i=SizeOfVector(q_record);
t_begin=q_record(size_i,5);t_end=t_begin+5;
tspan=[t_begin,t_end];
y0=[Xb_ini,Zb_ini,Xb_d_ini,Zb_d_ini];
op=odeset('Events',@eventfun_flight);
sol= ode45( @odefun_flight, tspan, y0 ,op);

T_ode45=size(sol.xe)
T_ode45=T_ode45(2);
T_ode=sol.xe(T_ode45);


if T_ode-tspan(1)<0.1
    T = linspace(tspan(1),T_ode,2);
else
    T = linspace(tspan(1),T_ode,(T_ode-tspan(1))*100);
end


%equally divide time span into 100 parts
Y = deval(sol,T);
Y=Y';
T=T';
q_record=RecordYData_Flight(T,Y,q_record);%Adding new data



%Transition:Flight->Stance 
size_i=SizeOfVector(q_record);
Xb_d_init=q_record(size_i,8);
Zb_d_init=q_record(size_i,9);
L_d_init=Zb_d_init*sin(angle_leg)+Xb_d_init*cos(angle_leg);
q_d_init=(Zb_d_init*cos(angle_leg)-Xb_d_init*sin(angle_leg))/0.5;
Xft_init=q_record(size_i,6)-0.5*cos(angle_leg);


%%
%Draw
if(mod(main_circle,loopSum)==0)
    q_record=SubFirstRow(q_record);
    DrawData=CalDrawData(q_record,draw_angle_leg);
    MyDraw(DrawData);
end
end
