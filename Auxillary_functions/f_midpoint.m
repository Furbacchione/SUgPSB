function [a,coef1]=f_midpoint(x,y,f_x,f_y,g_x,g_y)
% find mid point
A=[];
b=[];

if prod(size(f_x))~=0
    A=[A; x^3 x^2 x 1];
    b=[b;f_x];
end
if prod(size(f_y))~=0
    A=[A; y^3 y^2 y 1];
    b=[b;f_y];
end
if prod(size(g_x))~=0
    A=[A; 3*x^2 2*x 1 0];
    b=[b;g_x];
end
if prod(size(g_y))~=0
    A=[A; 3*y^2 2*y 1 0];
    b=[b;g_y];
end
[r,c]=size(A);
A=A(:,c-r+1:end);
pol=A\b;
extrema=roots(polyder(pol));
extrema=extrema(polyval(polyder(polyder(pol)),roots(polyder(pol)))>0);
% extrema=extrema(imag(extrema)==0);
% extrema(extrema<x)=[];
% extrema(extrema>y)=[];
if prod(size(extrema))~=0
    values=polyval(pol,extrema);
else
    values=[];
end
% values=[values;f_x;f_y];
points=extrema;% points=[extrema;x;y];
a=points(values==min(values));
coef1=pol(1);


