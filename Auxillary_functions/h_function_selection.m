function [ n, func ] = h_function_selection( type_prob, prob, prob_n )
%H_FUNCTION_SELECTION Summary of this function goes here
%   Detailed explanation goes here
if type_prob==1
    % path of problem
%    addpath('simple_example')
    % initialisation for problem
    func=@(x,degree) simple_function(x,degree);
    n=simple_function(0,0);
elseif type_prob==2
    [n,m,y] = initf(prob);
    func=@(x,degree) more_function(x,degree, prob)
    
elseif type_prob==3
    func=@(x,degree) cutest_function(x,degree);
    n=prob_n;
   % n=cutest_function(0,0);
end


end

