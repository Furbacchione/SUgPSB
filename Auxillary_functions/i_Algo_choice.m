function [algos param]=i_Algo_choice()

n=4;
algos={};

param=[];

% algos(end+1)={'SR1'}; [param(end+1,:)]=j_Algo_param([1], n);

% algos(end+1)={'PSB'}; [param(end+1,:)]=j_Algo_param([1], n);
% algos(end+1)={'BFGS'}; [param(end+1,:)]=j_Algo_param([1], n);
% algos(end+1)={'gPSB_S1'}; [param(end+1,:)]=j_Algo_param([2], n);
% algos(end+1)={'gPSB_S1'}; [param(end+1,:)]=j_Algo_param([4], n);
% algos(end+1)={'gPSB_S1'}; [param(end+1,:)]=j_Algo_param([8], n);
% algos(end+1)={'gPSB_S1'}; [param(end+1,:)]=j_Algo_param([16], n);
% algos(end+1)={'MPSS'}; [param(end+1,:)]=j_Algo_param([2], n);
% algos(end+1)={'MPSS'}; [param(end+1,:)]=j_Algo_param([4], n);
% algos(end+1)={'MPSS'}; [param(end+1,:)]=j_Algo_param([8], n);
% algos(end+1)={'MPSS'}; [param(end+1,:)]=j_Algo_param([16], n);
% algos(end+1)={'DFP'}; [param(end+1,:)]=j_Algo_param([1], n);

% algos(end+1)={'IPSB'}; [param(end+1,:)]=j_Algo_param([1], n);
% % 
% algos(end+1)={'pPSB_normal'}; [param(end+1,:)]=j_Algo_param([1 1 3], n);
% algos(end+1)={'pPSB_normal'}; [param(end+1,:)]=j_Algo_param([1 1000 3], n);
% algos(end+1)={'pPSB_normal'}; [param(end+1,:)]=j_Algo_param([4 1000 1], n);
% algos(end+1)={'pPSB_normal'}; [param(end+1,:)]=j_Algo_param([4 1000 2], n);
% algos(end+1)={'pPSB_normal'}; [param(end+1,:)]=j_Algo_param([8 1000 1], n);
% algos(end+1)={'pPSB_normal'}; [param(end+1,:)]=j_Algo_param([8 1000 2], n);
% algos(end+1)={'pPSB_normal'}; [param(end+1,:)]=j_Algo_param([16 1000 1], n);
% algos(end+1)={'pPSB_normal'}; [param(end+1,:)]=j_Algo_param([16 1000 2], n);
% % % 
% % algos(end+1)={'IpPSB_normal'}; [param(end+1,:)]=j_Algo_param([1 1 3], n);
% % algos(end+1)={'IpPSB_normal'}; [param(end+1,:)]=j_Algo_param([1 1000 3], n);
% % algos(end+1)={'IpPSB_normal'}; [param(end+1,:)]=j_Algo_param([4 1000 1], n);
% % algos(end+1)={'IpPSB_normal'}; [param(end+1,:)]=j_Algo_param([4 1000 2], n);
% % algos(end+1)={'IpPSB_normal'}; [param(end+1,:)]=j_Algo_param([8 1000 1], n);
% % algos(end+1)={'IpPSB_normal'}; [param(end+1,:)]=j_Algo_param([8 1000 2], n);
% % algos(end+1)={'IpPSB_normal'}; [param(end+1,:)]=j_Algo_param([16 1000 1], n);
% % algos(end+1)={'IpPSB_normal'}; [param(end+1,:)]=j_Algo_param([16 1000 2], n);
% % % 
% algos(end+1)={'pPSB_mod'}; [param(end+1,:)]=j_Algo_param([4 1000 1 1000], n);
% algos(end+1)={'pPSB_mod'}; [param(end+1,:)]=j_Algo_param([4 1000 1 1000000], n);
%  algos(end+1)={'pPSB_mod'}; [param(end+1,:)]=j_Algo_param([4 1000 3 1000], n);
% algos(end+1)={'pPSB_mod'}; [param(end+1,:)]=j_Algo_param([4 1000 3 1000000], n);
% algos(end+1)={'pPSB_mod'}; [param(end+1,:)]=j_Algo_param([8 1000 1 1000], n);
% algos(end+1)={'pPSB_mod'}; [param(end+1,:)]=j_Algo_param([8 1000 1 1000000], n);
% % % 
% % algos(end+1)={'IpPSB_mod'}; [param(end+1,:)]=j_Algo_param([4 1000 1 1000], n);
% % algos(end+1)={'IpPSB_mod'}; [param(end+1,:)]=j_Algo_param([4 1000 1 1000000], n);
% % algos(end+1)={'IpPSB_mod'}; [param(end+1,:)]=j_Algo_param([4 1000 3 1000], n);
% % algos(end+1)={'IpPSB_mod'}; [param(end+1,:)]=j_Algo_param([4 1000 3 1000000], n);
% % algos(end+1)={'IpPSB_mod'}; [param(end+1,:)]=j_Algo_param([8 1000 1 1000], n);
% % algos(end+1)={'IpPSB_mod'}; [param(end+1,:)]=j_Algo_param([8 1000 1 1000000], n);
% % 
% algos(end+1)={'SUpPSB'}; [param(end+1,:)]=j_Algo_param([4 1000 1], n);
% algos(end+1)={'SUpPSB'}; [param(end+1,:)]=j_Algo_param([4 1000 2], n);
% algos(end+1)={'SUpPSB'}; [param(end+1,:)]=j_Algo_param([8 0.001 2], n);
% algos(end+1)={'SUpPSB'}; [param(end+1,:)]=j_Algo_param([8 1 2], n);
% algos(end+1)={'SUpPSB'}; [param(end+1,:)]=j_Algo_param([8 1 3], n);
% algos(end+1)={'SUpPSB'}; [param(end+1,:)]=j_Algo_param([8 1000 2], n);
% algos(end+1)={'SUpPSB'}; [param(end+1,:)]=j_Algo_param([16 0.001 2], n);
% algos(end+1)={'SUpPSB'}; [param(end+1,:)]=j_Algo_param([16 1 2], n);
% algos(end+1)={'SUpPSB'}; [param(end+1,:)]=j_Algo_param([16 1 3], n);
% algos(end+1)={'SUpPSB'}; [param(end+1,:)]=j_Algo_param([16 1000 2], n);
% % % 
% % algos(end+1)={'ISUpPSB'}; [param(end+1,:)]=j_Algo_param([4 1000 1], n);
% % algos(end+1)={'ISUpPSB'}; [param(end+1,:)]=j_Algo_param([4 1000 2], n);
% % algos(end+1)={'ISUpPSB'}; [param(end+1,:)]=j_Algo_param([8 0.001 2], n);
% % algos(end+1)={'ISUpPSB'}; [param(end+1,:)]=j_Algo_param([8 1 2], n);
% % algos(end+1)={'ISUpPSB'}; [param(end+1,:)]=j_Algo_param([8 1 3], n);
% % algos(end+1)={'ISUpPSB'}; [param(end+1,:)]=j_Algo_param([8 1000 2], n);
% % algos(end+1)={'ISUpPSB'}; [param(end+1,:)]=j_Algo_param([16 0.001 2], n);
% % algos(end+1)={'ISUpPSB'}; [param(end+1,:)]=j_Algo_param([16 1 2], n);
% % algos(end+1)={'ISUpPSB'}; [param(end+1,:)]=j_Algo_param([16 1 3], n);
% % algos(end+1)={'ISUpPSB'}; [param(end+1,:)]=j_Algo_param([16 1000 2], n);

%  algos(end+1)={'SUgPSBs'}; [param(end+1,:)]=j_Algo_param([2], n);
%  algos(end+1)={'SUgPSBs'}; [param(end+1,:)]=j_Algo_param([4], n);
 algos(end+1)={'SUgPSBs'}; [param(end+1,:)]=j_Algo_param([8], n);
 algos(end+1)={'SUgPSBs'}; [param(end+1,:)]=j_Algo_param([16], n);
  algos(end+1)={'SUgPSBs'}; [param(end+1,:)]=j_Algo_param([32], n);
% algos(end+1)={'SUgPSBs'}; [param(end+1,:)]=j_Algo_param([64], n);
% algos(end+1)={'SUgPSBs'}; [param(end+1,:)]=j_Algo_param([256], n);
 
%  algos(end+1)={'gPSBs'}; [param(end+1,:)]=j_Algo_param([4], n);
%  algos(end+1)={'gPSBs'}; [param(end+1,:)]=j_Algo_param([16], n);
% algos(end+1)={'gPSBs'}; [param(end+1,:)]=j_Algo_param([64], n);
% algos(end+1)={'gPSBs'}; [param(end+1,:)]=j_Algo_param([256], n);
 
%  algos(end+1)={'gPSBm'}; [param(end+1,:)]=j_Algo_param([4], n);
%  algos(end+1)={'gPSBm'}; [param(end+1,:)]=j_Algo_param([16], n);
% algos(end+1)={'gPSBm'}; [param(end+1,:)]=j_Algo_param([64], n);
% algos(end+1)={'gPSBm'}; [param(end+1,:)]=j_Algo_param([256], n);

% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([7 1 2], n);
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([1 1 1], n);
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([2 2 2], n); 
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([2 1 2], n); 
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([4 4 4], n); 
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([4 4 2], n); % should have been 4 2 2
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([4 1 1], n);
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([4 1 2], n);
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([4 1 4], n);
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([8 8 8], n);
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([8 4 4 ], n);
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([8 2 2 ], n);
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([8 1 1], n);
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([8 1 2], n);
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([8 1 4], n);
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([8 1 8], n);
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([16 1 8], n);
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([16 1 4], n);
% algos(end+1)={'SGOMS'}; [param(end+1,:)]=j_Algo_param([16 1 1], n);

param=param';
end

