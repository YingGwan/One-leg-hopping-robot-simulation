function q_record_2=RecordYData_Stance(T,Y,q_record)
global Xft;
global main_circle;
    size_origin=SizeOfVector(q_record);
    size_push=SizeOfVector(Y);
    
    for i=1:size_push
        for j=1:4
            q_record(size_origin+i,j)=Y(i,j);
        end
        q_record(size_origin+i,5)=T(i);
        q_record(size_origin+i,10)=Xft;
        q_record(size_origin+i,11)=main_circle;
    end
    q_record_2=q_record;
end