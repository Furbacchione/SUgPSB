function [ sol ] = cutest_function( x, degree )
%SIMPLE_FUNCTION Summary of this function goes here
%   Detailed explanation goes here

if (degree==1)
    [sol] = cutest_obj(x);
elseif (degree==2)
    [sol] = cutest_grad(x);
elseif (degree==0)
    [sol, ~]=cutest_dims();
else error('function or gradient call not defined')
end
 
end

