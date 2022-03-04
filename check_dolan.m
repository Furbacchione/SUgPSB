clear
clc
close all

MaxIte=200;
n=1;
limit=0.01;
% keep=[1,2,1,1,1,1,7,8,9]; 1:9; %[n:n+12]; %, 51:75,101:125]; % which algos you want to keep
% kept=[1,7,8,9,2]; % 1-25: [1,2,3,11,15,17,20,24]; 51-75: [1,2,3,11,15,16,20,24];% which algo are kept for global graph
% %kept=[4:7];
% % 26-50: [1,2,3,11,12,16,18,22]; 126-150: [1,2,6,11,13,18,19,22];
algo_letters=[ num2cell('A':'Y') num2cell('a':'y') num2cell('A':'Y')];% Standard
% algo_letters={'','','','2','4','8','16','','','2','4','8','16'};% for Art
% algo_letters={'','','','2','4','8','16','',''};% for Art
% % algo_letters={'A','B','C','D','E'};
% % algos=1:5;
kept=1:5;
algo_names={'A','B','C','D','E'};
% 
% % kept_probs=[1:2]; % 6:10,11];
% 
% %%
%  load ('MyDolanSave.mat');
% 
% [r c1]=size(algos);
% [r c2]=size(probs);
% 
% nit=steps; %%% This line to get Grad call of full call
% 
% mat_probs= reshape(lin_probs,[c1,c2])';
% mat_algo= reshape(lin_algo,[c1,c2])';
% mat_nit= reshape(nit,[c1,c2])';
% mat_obj= reshape(obj,[c1,c2])';
% mat_steps=reshape(steps,[c1,c2])';
% 
% nit=[];
% obj=[];
% for i=1:c2
%     nit(mat_probs(i,1),:)=mat_nit(i,:);
%     obj(mat_probs(i,1),:)=mat_obj(i,:);
% end
% 
% algo_names=algos;
%  algo_names={'PSB','BFGS','DFP','SUgPSB','SUgPSB','SUgPSB','SUgPSB','gPSB Sym','gPSB MS'};%'PSB','BFGS'} % 'SUgPSB','SUgPSB','SUgPSB','SUgPSB','gPSB Sym','gPSB Sym','gPSB Sym','gPSB Sym','gPSB MS','gPSB MS','gPSB MS','gPSB MS'}
% % algo_names={'','','', 'SUgPSB (2)','SUgPSB (4)','SUgPSB (8)','SUgPSB (16)', '',''};
% algos=1:length(algos);
% 
% algos=algos(keep);
% nit=nit(:,keep);
% obj=obj(:,keep);
% 
% %% Stopping criteria
% % define parameters
% % tolx=10^-8; % 8 define tolerance on x
% % tolg=10^-6; %6 define tolerence on g
% % MaxIte=002; %5002
% 
% %% loop for testing
% 
% %%
% % algo_names{2}='PSB';
% % algo_names{4}='pPSB linear';
% % algo_names{6}='pPSB non linear';
% % algo_names{10}='SUpPSB';
% % algo_names{3}='IPSB';
% % algo_names{5}='IpPSB linear';
% % algo_names{7}='IpPSB non linear';
% % algo_names{11}='ISUpPSB';
% 
 line_type={'--',':','-.','-'};
% %%
% nit_good=nit(probs,:);
% obj_good=obj(probs,:);


% nit_good=[45 42 9 90 75;
%     13 14 40 3 14;
%     45 40 49 58 52;
%     12 25 50 75 45];
% obj_good=[1 1 2 1 1;
%     1 1 1 1 1;
%     5 5 5 5 5;
%     2 2 2 2 2];


[r c]=size(nit_good);
converged=ones(r,c);
converged(isnan(obj_good) | isinf(obj_good) | nit_good>MaxIte-1)=0;

for i=1:r
    lijn=obj_good(i,:);
    lijn=lijn(converged(i,:)==1);
    Minlist(i)=max([min(lijn)  10^-10]);
end
converged(obj_good>repmat((1+limit)*Minlist',1,c))=0;

r

for i=r:-1:1
    if sum(converged(i,:))==0
        nit_good(i,:)=[];
        obj_good(i,:)=[];
        converged(i,:)=[];
    end
end
[r c]=size(nit_good);
r


nit_good(converged==0)=MaxIte+1;
ratio=nit_good./repmat(min(nit_good')',1,c);
ratio(converged==0)=MaxIte;

tau=logspace(0,log10(MaxIte),2000);% [1:0.1:MaxIte];
[m1 m2]=size(tau); 

%MaxX=mean([max(ratio(ratio~=max(max(ratio)))),max(max(ratio))]);
MaxX=max(max(ratio))*0.95;

profile=zeros(m2,c);
k=0;
for i=tau
    i/max(tau)*100;
    k=k+1;
    for j=1:c
        profile(k,:)=sum(ratio<=i)/r;
    end
end

% profile(1:end-1,:)=profile(1:end-1,:)/max(max(profile(1:end-1,:)));


%

set(figure, 'color', 'white'); % sets the color to white
k=1;


for i=1:c
    stairs(tau,profile(:,i),'linestyle',line_type{mod(i,max(size(line_type)))+1},'LineWidth',1.5);
    hold on
    if i==1 | isequal(algo_names(i),algo_names(min(c,i+1)))==0
        x0=100;
y0=100;
width=550;
height=550;
set(gcf,'position',[x0,y0,width,height])
set(gca, 'XScale', 'log')
        ylim([0 1]);
        xlim([1 MaxX]);
       legend(strcat(algo_letters(k:i)),'location','northwest');
        k=i+1;
        title(algo_names(algos(i)));
        set(figure, 'color', 'white'); % sets the color to white
    end
end

x0=100;
y0=100;
width=550;
height=550;
set(gcf,'position',[x0,y0,width,height])
set(gca, 'XScale', 'log')
        ylim([0 1]);
        xlim([1 MaxX]);
        legend(strcat(algo_letters(k:i)),'location','northwest');
        k=i+1;
        title(algo_names(algos(i)));


%%       
% algo_distinct=unique(algo_names)
for i=1:length(algo_names)
    if i==1
        algos(i)=1;
    elseif isequal(algo_names(i),algo_names(i-1))
        algos(i)=algos(i-1);
    else
        algos(i)=algos(i-1)+1;
    end
end

line_type2{1}=':';
line_type2{2}='-.';
line_type2{3}='-';
line_type2{4}='-.';
line_type2{5}='-.';
line_type2{6}='-';
line_type2{7}='-';
line_type2{8}='--';
line_type2{9}='-.';

algos
kept

set(figure, 'color', 'white'); % sets the color to white
for i=kept
%    stairs(tau,profile(:,i),'linestyle',line_type2{algos(i)},'LineWidth',1.5);
    stairs(tau,profile(:,i),'linestyle',line_type2{i},'LineWidth',1.5);
 %   stairs(tau,profile(:,i),'linestyle',line_type2{mod(i,4)+1},'LineWidth',1.5);%
%    if only one algo shown
    hold on
end

        ylim([0 1]);
        xlim([1 MaxX]);
        x0=100;
y0=100;
width=550;
height=550
set(gcf,'position',[x0,y0,width,height])
set(gca, 'XScale', 'log')
        numlines=min(2,length(kept));
        MyLegend=strcat(algo_names(kept));%,' (',algo_letters(kept),')'); % strcat(algo_letters(kept),' (',algo_names(algos(kept)),')');
        columnlegend(numlines,MyLegend, 'location', 'northwest'); 
%        lgd=legend(strcat(algo_letters(kept),' (',algo_names(algos(kept)),')'),'location','northwest');
%        lgd.FontSize = 8;
      %  title('Best performing formulas');
        xlabel('Number function calls');
        ylabel('Fraction of problems solved')