classdef Control
    properties
       
        Ts=0;
        Xd_d=0.5;
        desire_angle=0; %rad
       
      
    end
    
    properties
        
        xita1=0;
        xita2=0;
        
        
        
        x_d=0;
        
         kx_d=0.29;%Pֵ
       
    end
    
    
    properties
        %Used for forward speed control.
        time1=0;
        time2=0;
        x_touchdown=0;
        x_takeoff=0;
        
        %Duration
        duration=0;
        
        %actual speed in stance phase
        x_der=0;
        
        %Xf0
        Xf0=0;
        
        %P
        Kp=0.009;%0.0009
        
        %forward vel target
        x_der_target=0;%target vel
        coef=0.38; %0.48
        
        %Xf
        Xf=0;
        
        %target leg_angle
        leg_angle_control=0;
    end
    methods

        
    end
    
    
end