function [ obj, nit, sol, L2norm, f_call, lin_probs, lin_algo, steps, n] = ...
    g_Optimization_loop(algos, probs, type_prob, ii, omega_start,tol ,MaxIte, linesearch, param, ...
    mu, eta, prob_n, prob_x)
%G_OPTIMIZATION_LOOP Loop for optimization
%   Detailed explanation goes here
%% define prob and algo
param=param(:,ii);
param1=param(1,:);
k=mod(ii-1,max(size(algos)))+1;
nprob=probs(floor((ii-1)/max(size(algos)))+1);
algo=algos(k);
% load problem
[ n, func ] = h_function_selection( type_prob, nprob, prob_n);
% initial point
% p0=ones(n,1); %% When no initial point available
p0=prob_x; %% Change for CUTEST
BH=eye(n); %% hessian or inverse hessian
%% initialisation
% first point
algo=char(algo);
direct=d_Update_Hessian( algo); % parameter to define if algorithm is direct (1) or indirect (0)
i=1;
f=func(p0,1);
K=func(p0,2);
[ p ] = b_First_step( direct, p0, BH, K ,omega_start)
i=i+1;
[f(i)]=[func(p(:,end),1)]
Kstop=[func(p(:,end),2)]
K(:,i)=Kstop;
stop_crit=norm(Kstop);
%% Optimization loop
y=[];
s=[];
steps=0;
stop_crit;
ls_step=0;
while (stop_crit>tol && i<MaxIte && (i==2 || min(p(:,end)~=p(:,end-1))))
    stop_crit
    %%% Computing matrices
    y(:,end+1)=K(:,end)-K(:,end-1);
    s(:,end+1)=p(:,end)-p(:,end-1);
    S=s(:,max(1,end-n+1):end);
    Y=y(:,max(1,end-n+1):end);
   % take only last param1 steps
    S=S(:,max(end-param1+1,1):end);
    Y=Y(:,max(end-param1+1,1):end);
    S_ori=S;
    Y_ori=Y;
    % Exclude old step if aligned with more recent one
    Sinv=fliplr(S);
    Yinv=fliplr(Y);
    if(det(Sinv'*Sinv)==0)
        1
    end
    [~, ~, Yinv, Sinv,ia]= c2_adapted_QR(Yinv, Sinv, 1e-5);
    S=fliplr(Sinv);
    Y=fliplr(Yinv);
% calculation of the direction
    [~, ~, BH, deltap]=l_direction_calculation(algo, BH, S, Y, s, y, param, K, direct, n, i, p(:,end),0, S_ori, Y_ori, ia);
    if linesearch==1
        [ alpha, ls_step ] = e_line_search( func, p(:,end), deltap, mu, eta, tol);
    else
        alpha=1;
        ls_step=1;
    end
    alpha;
   % p=[p(:,end) p(:,end)+deltap*alpha];
    p=[p p(:,end)+deltap*alpha];
    p(:,end);
    i=i+1
    steps=steps+ls_step;
    [f]=[func(p(:,end),1)];
    f(:,end);
    Kstop=func(p(:,end),2);
    K=[K(:,end),Kstop];
    stop_crit=norm(Kstop);
    y=y(:,max(1,end-param1):end);
    s=s(:,max(1,end-param1):end);
  %  [algo ' ' num2str(i)]
    
    [~,name,~]=fileparts(pwd);
% fname = [ 'saved_result_' num2str(key) '.mat'];
fname = [ 'temporaty_saved_result_' name '.mat'];
% save(fname, 's', 'y', 'BH' ,'K','p','f');  
end
%% save data
obj=f(end);
%   [r c]=size(p);
f_call=sum(ls_step);
nit=i;
sol=p(:,end);
L2norm=norm(K(:,end));
lin_probs=nprob;
lin_algo=algo;
end

