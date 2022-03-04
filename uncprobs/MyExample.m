% Rosenbrock function 
% ------------------- 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [fvec,J]=MyExample(n,m,x,option)
% Problem no. 42
% Dimensions -> n=5, m=3              
% Standard starting point -> x=ones(15,1)'  
% Minima -> ???              
%                                     
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [fvec,J] = MyExample(n,m,x,option)  
fib=fibonacci(5)/100;
if (option==1 | option==3)
        
  %      fvec = [  sum((x(1)-fib(1)).^2)+(1-exp(-sum((x(3)-fib(3)).^2)))
  %                sum((x(2)-fib(2)).^2)+exp(sum((x(4)-fib(4)).^2))-1
  %                sum((x(3)-fib(3)).^2)+sin(sum((x(5)-fib(5)).^2))] ; 
  fvec=[sum((x(1:2)-fib(1:2)).^2)
                  sum((x(2:4)-fib(2:4)).^2)
                  sum((x(3:5)-fib(3:5)).^2)] ; 
end;        
if (option==2 | option==3)
   %     J    = [  2*(x(1)-fib(1))  0 exp(-sum((x(3) - fib(3)).^2))*2*(x(3) - fib(3)) 0 0
   %                 0 2*(x(2)-fib(2)) 0 exp(-sum((x(4) - fib(4)).^2))*2*(x(4) - fib(4)) 0
   %               0 0  2*(x(3)-fib(3)) 0 cos(sum(x(5)-fib(5)).^2)*2*(x(5)-fib(5)) ] ;
   J=[  2*(x(1)-fib(1))  2*(x(2)-fib(2)) 0 0 0
       0  2*(x(2)-fib(2))  2*(x(3)-fib(3))  2*(x(4)-fib(4)) 0
  0 0  2*(x(3)-fib(3))  2*(x(4)-fib(4))  2*(x(5)-fib(5)) ];

end;
%
