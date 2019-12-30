function DrawData=CalDrawData(q_record,q_over)
wholesize=SizeOfVector(q_record);
DrawData=zeros(wholesize,5);
flag=1;

while (q_record(flag,5)~=0)||(q_record(flag,1)~=0)
    %当有数据的时候
    if(q_record(flag,1)<1e-4)
        %当在空中飞时
            DrawData(flag,1)=q_record(flag,6);
            DrawData(flag,2)=q_record(flag,6)-0.5*cos(q_over(q_record(flag,11)));
            DrawData(flag,3)=q_record(flag,7);
            DrawData(flag,4)=q_record(flag,7)-0.5*sin(q_over(q_record(flag,11)));
            DrawData(flag,5)=q_record(flag,5);
            %Calculate X_d
            if flag~=1
                DrawData(flag,6)=(DrawData(flag,1)-DrawData(flag-1,1))/(DrawData(flag,5)-DrawData(flag-1,5));
            else
                DrawData(flag,6)=(DrawData(flag,1)-0)/(DrawData(flag,5)-0);
            end
            DrawData(flag,7)=0.5;%弹簧长度 Used for plotting energy
            DrawData(flag,8)=q_record(flag,8);%Xb's derivate.
            DrawData(flag,9)=q_record(flag,9);%Zb's derivate.
            
            %Calculating energy
%             DrawData(flag,8)=7*10*DrawData(flag,3);
            DrawData(flag,12)=0.5*7*( DrawData(flag,8)^2+DrawData(flag,9)^2)+7*10*DrawData(flag,3);
    end
    
    if(q_record(flag,6)<1e-4)
        %当在地面上时
        DrawData(flag,1)=q_record(flag,10)+q_record(flag,2)*cos(q_record(flag,1));
        DrawData(flag,2)=q_record(flag,10);
        DrawData(flag,3)=q_record(flag,2)*sin(q_record(flag,1));
        DrawData(flag,4)=0;
        DrawData(flag,5)=q_record(flag,5);
        
            if flag~=1
                DrawData(flag,6)=(DrawData(flag,1)-DrawData(flag-1,1))/(DrawData(flag,5)-DrawData(flag-1,5));
            else
                DrawData(flag,6)=(DrawData(flag,1)-0)/(DrawData(flag,5)-0);
            end
            
        DrawData(flag,7)=q_record(flag,2);%弹簧长度 Used for plotting energy
        DrawData(flag,8)=0;
        DrawData(flag,9)=0;%Set Xb' and Zb's derivate=0.
        
        DrawData(flag,10)=q_record(flag,3);%q_d
        DrawData(flag,11)=q_record(flag,4);%L_d
        
        DrawData(flag,12)=0.5*7*( DrawData(flag,11)^2+ (  DrawData(flag,10)* DrawData(flag,7) )^2 )+...
            7*10*DrawData(flag,3)+0.5*2800*(0.5-DrawData(flag,7))^2;
    end
    flag=flag+1;
    if flag>wholesize
        break;
    end
end



end