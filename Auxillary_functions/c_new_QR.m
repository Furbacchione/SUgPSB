function [Q, R, V, W]= new_QR(V, W, epsilon)
% C_NEW_QR control if steps are not aligned in order to avoid singularities in Hessian.
% Delete old step if needed

[a,eta]=size(V);
R=[];
Q=[];
i=1;

R(i,i)=norm(V(:,1));
Q=V(:,1)/R(i,i);
for i=2:eta
    v=V(:,i);
    for j=1:i-1
        R(j,i)=Q(:,j)'*v;
        v=v-R(j,i)*Q(:,j);
    end
    [norm(v) norm(V(:,i))];
    if norm(v)<epsilon*(norm(V(:,i)))
        V(:,i)=[];
        W(:,i)=[];
        [Q, R, V, W]= c_new_QR(V, W, epsilon);
        break
    else
        R(i,i)=norm(v);
        Q(:,i)=v/R(i,i);
    end
end
end