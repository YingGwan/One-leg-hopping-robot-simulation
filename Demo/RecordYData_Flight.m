function q_record_2=RecordYData_Flight(T,Y,q_record)
global main_circle;
    size_origin=SizeOfVector(q_record);
    size_push=SizeOfVector(Y);
    
    for i=1:size_push
        for j=6:9
            q_record(size_origin+i,j)=Y(i,j-5);
        end
        q_record(size_origin+i,5)=T(i);
         q_record(size_origin+i,11)=main_circle;
    end
    q_record_2=q_record;
end