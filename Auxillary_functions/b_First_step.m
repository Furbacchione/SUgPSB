function [ p ] = b_First_step( direct, initial_point, matrix, K ,omega_start)
%B_FIRST_STEP Compute the first step of the optimization
if ~exist('omega_start','var')
    omega_start=1e-5;
end
if (direct==1)
    [deltap, flag]=gmres(matrix,-K);
elseif (direct==0)
    deltap=-matrix*K;
else error('Parameter Direct not defined')
end
p=initial_point;
omega=omega_start*norm(deltap);
p(:,2)=(1-omega)*p+omega*deltap;
end

