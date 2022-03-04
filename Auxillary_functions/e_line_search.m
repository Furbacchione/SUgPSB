function [ alpha, i ] = e_line_search( func, p, deltap, mu, eta, tol, delta)
%E_LINE_SEARCH Summary of this function goes here
%   Detailed explanation goes here

fcn=@(n,x) deal(func(x,1), func(x,2));

n=func(p,0);
x=p; 
[f,g]=fcn(n,x);
 s=deltap;
 stp=1;
 ftol=mu;
 gtol=eta;
 xtol=0.001;
 stpmin=0;
 stpmax=1000;
 maxfev=25;

[x,f,g,stp,info,nfev] ...
       = k_cvsrch(fcn,n,x,f,g,s,stp,ftol,gtol,xtol, ...
                 stpmin,stpmax,maxfev);
             
alpha=stp;
i=nfev;
             
end

