function [algos, probs, lin_algo, lin_probs, nit, obj, steps, probs_name, Psize]=u_load_all_matrices(limit)

% limit: exclude problem with size<limit
%clear
%clc
% all_f_call=[]
% all_L2norm=[]
all_lin_algo={};
all_lin_probs=[];
probs_name=[];
all_nit=[];
all_obj=[];
all_algos=[];
all_probs=[];
all_steps=[];
all_size=[];
all_param=[];
% all_sol=[]
% Specify the folder where the files live.
myFolder = '211014_BROYDN3DLS';
% Check to make sure that folder actually exists.  Warn user if it doesn't.
if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end
% Get a list of all files in the folder with the desired file name pattern.
filePattern = fullfile(myFolder, 'saved_result_*.mat'); % Change to whatever pattern you need.
theFiles = dir(filePattern);
for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(myFolder, baseFileName);
    fprintf(1, 'Now reading %s\n', fullFileName);
    % Now do whatever you want with this file name,
    load(fullFileName);
    ProbSize=size(sol,1);
    if ProbSize>=limit
        
        % all_f_call=[all_f_call, f_call]
        % all_L2norm=[all_L2norm, L2norm]
        all_algos=[all_algos; lin_algo];
        all_probs=[all_probs; repmat(k,  1,length(lin_probs)) ];
        all_lin_algo=[all_lin_algo, lin_algo];
        all_lin_probs=[all_lin_probs, repmat(k,  1,length(lin_probs)) ];
        all_nit=[all_nit, nit];
        all_obj=[all_obj, obj];
        all_steps=[all_steps, steps];
        all_size=[all_size, ProbSize];
        all_param(:,:,end+1)=[param];
        probs_name=[probs_name; repmat({strrep(strrep(fullFileName,'MySave\saved_result_',''),'.mat','')},  1,length(lin_probs)) ];
        % all_sol=[all_sol, sol]
    end
end

lin_algo=all_lin_algo;
lin_probs=all_lin_probs;
nit=all_nit;
obj=all_obj;
algos=all_algos;
probs=all_probs;
steps=all_steps;
param=all_param;
algos=algos(1,:);
probs=probs(:,1)';
Psize=all_size;

save('MyDolanSave.mat','lin_algo','lin_probs','nit','obj','algos','probs', 'probs_name','steps', 'Psize','param')
end