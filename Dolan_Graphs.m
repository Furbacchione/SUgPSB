clear
clc
close all

MaxIte=50000;
n=1;
limit=0.01;
keep=[1:3]; [1:28]; % 1:9; %[n:n+12]; %, 51:75,101:125]; % which algos you want to keep
% kept=[1,7,8,9,2]; % 1-25: [1,2,3,11,15,17,20,24]; 51-75: [1,2,3,11,15,16,20,24];% which algo are kept for global graph
 kept=[1, 2, 3]; [1,2, 10, 26:28];
% 26-50: [1,2,3,11,12,16,18,22]; 126-150: [1,2,6,11,13,18,19,22];
algo_letters=[ num2cell('A':'Y') num2cell('a':'y') num2cell('A':'Y')];% Standard
%algo_letters={'','','','2','4','8','16','','','2','4','8','16'};% for Art
%algo_letters={'','1','1','2','2','4','4','4','4','4','8','8','8','8','8','8','8','16','16','16'};% for Art
% algo_letters={ 'PSB', 'BFGS',  'gPSB'  ,  'gPSB' ,   'gPSB'  ,  'gPSB'  ,  'MPSS (2)'  ,  'MPSS (4)'  ,  'MPSS (8)',...
 %   'MPSS (16)' , 'A (1, 1, -)', 'B (2, 2, -)', 'C (2, 1, 2)', 'D (4, 4,
 %   -)', 'E (4, 2, 2)', 'F (4, 1, 1)', 'G (4, 1, 2)', 'H (4, 1, 4)', 'I (8, 8, -)', 'J (8, 4, 4)', 'K (8, 2, 2)', 'L (8, 1, 1)', 'M (8, 1, 2)', 'N (8, 1, 4)', 'O (8, 1, 8)', 'P (16, 1, 8)', 'Q (16, 1, 4)', 'R (16, 1, 1)'    }; 0
%algo_letters={ 'PSB', 'BFGS',  'gPSB' , 'R (16, 1, 1)'    }; 

%,  num2cell('A':'Y') num2cell('a':'y') num2cell('A':'Y')];


%%
 load ('MyDolanSave.mat');

[r c1]=size(algos);
[r c2]=size(probs);

nit=steps; %%% This line to get Grad call of full call

mat_probs= reshape(lin_probs,[c1,c2])';
mat_algo= reshape(lin_algo,[c1,c2])';
mat_nit= reshape(nit,[c1,c2])';
mat_obj= reshape(obj,[c1,c2])';
mat_steps=reshape(steps,[c1,c2])';

nit=[];
obj=[];
for i=1:c2
    nit(mat_probs(i,1),:)=mat_nit(i,:);
    obj(mat_probs(i,1),:)=mat_obj(i,:);
end

algo_names=algos;
% algo_names={'PSB','BFGS','DFP','SUgPSB','SUgPSB','SUgPSB','SUgPSB','gPSB Sym','gPSB MS'};%'PSB','BFGS'} % 'SUgPSB','SUgPSB','SUgPSB','SUgPSB','gPSB Sym','gPSB Sym','gPSB Sym','gPSB Sym','gPSB MS','gPSB MS','gPSB MS','gPSB MS'}
% algo_names={'','','', 'SUgPSB (2)','SUgPSB (4)','SUgPSB (8)','SUgPSB (16)', '',''};
% algo_names={'','','', 'SUgPSB (2)','SUgPSB (4)','SUgPSB (8)','SUgPSB (16)', '','', 'SUgPSB (2)','SUgPSB (4)','SUgPSB (8)','SUgPSB (16)', '','', 'SUgPSB (2)','SUgPSB (4)','SUgPSB (8)','SUgPSB (16)', '',''};
%  Columns 1 through 9

%algo_names={'PSB'  ,  'BFGS'   , 'gPSB'  ,  'gPSB' ,   'gPSB'  ,  'gPSB'  ,  'MPSS'  ,  'MPSS'  ,  'MPSS',...
%    'MPSS'  ,  'SGOMS'  ,  'SGOMS'  ,  'SGOMS'  ,  'SGOMS'   , 'SGOMS'  ,  'SGOMS'  ,  'SGOMS'  ,  'SGOMS',...
%    'SGOMS'  ,  'SGOMS'  ,  'SGOMS'  ,  'SGOMS'   , 'SGOMS' ,   'SGOMS'  ,  'SGOMS'  ,  'SGOMS'  ,  'SGOMS',...
 %   'SGOMS'}


algos=1:length(algos);

algos=algos(keep);
nit=nit(:,keep);
obj=obj(:,keep);

%% Stopping criteria
% define parameters
% tolx=10^-8; % 8 define tolerance on x
% tolg=10^-6; %6 define tolerence on g
% MaxIte=002; %5002

%% loop for testing

%%
% algo_names{2}='PSB';
% algo_names{4}='pPSB linear';
% algo_names{6}='pPSB non linear';
% algo_names{10}='SUpPSB';
% algo_names{3}='IPSB';
% algo_names{5}='IpPSB linear';
% algo_names{7}='IpPSB non linear';
% algo_names{11}='ISUpPSB';

line_type={'--',':','-.','-','--',':','-.','-','--',':','-.','-','--',':','-.','-'};
%%
nit_good=nit(probs,:);
obj_good=obj(probs,:);
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

%tau=round(logspace(0,log10(MaxIte),2000));% [1:0.1:MaxIte];
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

line_type2{1}=':';%
line_type2{2}='-';%
line_type2{3}='-';
line_type2{4}='-.';
line_type2{5}='-.';
line_type2{6}='-';
line_type2{7}='-';
line_type2{8}='--';
line_type2{9}='-.';
line_type2{10}='-.';%
line_type2{11}=':';
line_type2{12}='-.';
line_type2{13}='--';%
line_type2{14}='--';
line_type2{15}=':';
line_type2{16}='-';
line_type2{17}='-.';
line_type2{18}='--';%
line_type2{19}='-.';
line_type2{20}='--';
line_type2{21}=':';
line_type2{22}='--';
line_type2{23}=':';
line_type2{24}='-';
line_type2{25}=':';
line_type2{26}=':';
line_type2{27}='--';%
line_type2{28}='-.';
line_type2{29}='--';
line_type2{30}='-.';

algos
kept

algo_names=algo_letters;


set(figure, 'color', 'white'); % sets the color to white
for i=kept
%    stairs(tau,profile(:,i),'linestyle',line_type2{algos(i)},'LineWidth',1.5);
    stairs(tau,profile(:,i),'linestyle',line_type2{i},'LineWidth',1.5);
 %   stairs(tau,profile(:,i),'linestyle',line_type2{mod(i,4)+1},'LineWidth',1.5);%
%    if only one algo shown
    hold on
end

        ylim([0 1]); ylim([0.4 0.65])
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
        xlabel('\tau in function of number of gradient function calls');
        ylabel('Fraction of problems solved')