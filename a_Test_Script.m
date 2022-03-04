function deviation=a_Test_Script(deviation)
if nargin==0
        ['No argument detected']
    deviation=1
end
['Values']
value_deviation=[0,1,-10,100]
['Test deviation']
deviation_name=str2double(deviation)+0
deviation=value_deviation(deviation_name)
%% Empty memory
if(isdeployed==false)
    addpath('simple_example')
    addpath('Auxillary_functions')
    addpath('uncprobs')
 else  % don't forget to change for cluster
    c = parcluster('local')
    pool = parpool(c.NumWorkers)
end
%% Problem parameters
type_prob=3; % 1= local, 2 More, 3 CUTEst
probs=[1];
%% Algorithm parameters
% based on algorithm
[algos param]=i_Algo_choice();
%% General parameters
% convergence criteria
tol=10^-6;
MaxIte=50000;
% first step
omega_start=1e-5;
% line search
linesearch=1; % 0 if no linesearch
mu=0.01;
eta=0.1;
%% saving parameters
[~,name,~]=fileparts(pwd);
fname = [ 'saved_result_' name '_' num2str(deviation_name) '.mat'];
%% initiate loop algo
par_loops=1:max(size(algos))*max(size(probs));
obj=zeros(1,max(size(algos))*max(size(probs)));
nit=zeros(1,max(size(algos))*max(size(probs)));
steps=zeros(1,max(size(algos))*max(size(probs)));
n=zeros(1,max(size(algos))*max(size(probs)));
L2norm=zeros(1,max(size(algos))*max(size(probs)));
f_call=zeros(1,max(size(algos))*max(size(probs)));
lin_probs=zeros(1,max(size(algos))*max(size(probs)));
lin_algo=cell(1,max(size(algos))*max(size(probs)));
parfor  loop=par_loops
    if(type_prob==3)
    prob = cutest_setup();
    prob_n=prob.n;
    prob_x=prob.x;
    [r1,c1]=size(prob_x);
    correction=deviation*ones(r1,c1);
    correction(1:2:end)=-deviation;
    prob_x=correction+prob_x;
    else
        prob_n=[];
        prob_x=[];
    end
    loop
    [ obj(loop), nit(loop), sol(:,loop), L2norm(loop), f_call(loop), lin_probs(loop), lin_algo{loop}, steps(loop), n(loop)] ...
        = g_Optimization_loop( algos, probs, type_prob, loop ,omega_start, ...
        tol ,MaxIte, linesearch, param, mu, eta, prob_n, prob_x);
    if(type_prob==3)
    cutest_terminate();
    end
    ['solution i:' num2str(loop) ' nit:' num2str(nit(loop)) ' obj:' num2str(obj(loop))]
end
[~,problem,~]=fileparts(pwd);
save(fname, 'obj', 'sol', 'nit' ,'L2norm','f_call','lin_probs','lin_algo', 'steps', 'problem','tol','MaxIte','omega_start','linesearch','param','mu','eta','n');  
end