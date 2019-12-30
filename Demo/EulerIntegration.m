function q_new = EulerIntegration(time,sita_d,q)

q_new=zeros(4,1);%Create space for euler integrations
for i=1:4
    q_new(i)=sita_d(i)*time+q(i);
end
end