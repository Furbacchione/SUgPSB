function [ sol ] = more_function( x, degree, nprob )
%SIMPLE_FUNCTION Summary of this function goes here
%   Detailed explanation goes here
    [n,m,y] = initf(nprob);
if (degree==1)
    [sol] = objfcn(n,m,x,nprob);
elseif (degree==2)
    [sol] = grdfcn(n,m,x,nprob);
elseif (degree==0)
    [sol]=n;
else error('function or gradient call not defined')
end
 
end