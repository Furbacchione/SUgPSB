function [ sol ] = simple_function( x, degree )
%SIMPLE_FUNCTION Summary of this function goes here
%   Detailed explanation goes here
 a=[1:2]';
if (degree==1)
    y=sum((x-a).^2)+4*sin(x(1))+6*cos(x(2));
%    y=sum((x-a).^2);
    sol=y;
elseif (degree==2)
    grad=[2*(x-a)];
    grad(1)=grad(1)+4*cos(x(1)); 
    grad(2)=grad(2)-6*sin(x(2));
    sol=grad;
elseif (degree==0);
    sol=length(a);
else error('function or gradient call not defined')
end

end

