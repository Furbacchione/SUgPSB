clear
clc
n=20;
s=eye(n);
S=s;
y=s; 
Y=S;
S(end, 1:4:end)=1000;
S(end, end-6:1:end-4)=1000;
direct=1;
BH=eye(n);
param=[18 3 3 2]';


param1=param(1,:);
param2=param(2,:);
param3=param(3,:);
param4=param(4,:);


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
    [~, ~, Sinv, Yinv,ia]= c2_adapted_QR(Sinv, Yinv, 1e-1);
    S=fliplr(Sinv);
    Y=fliplr(Yinv);
    
    
        % computing W or V
    if (direct==1)
        wv=y(:,end)-BH(:,:,end)*s(:,end);
        WV=Y-BH(:,:,end)*S;
    elseif (direct==0)
        wv=s(:,end)-BH(:,:,end)*y(:,end);
        WV=S-BH(:,:,end)*Y;
    else error('Nor direct, nor indirect algorithm')
    end
    
    
    
if ~exist('BH','var')
    BH=0;
    S=0;
    Y=0;
    WV=0;
    s=0;
    y=0;
    wv=0;
    param=zeros(4,1);
end
Sp=(S'*S)^-1*S';
Yp=(Y'*Y)^-1*Y';



        %% controle
%          BH_save=BH;
%          BH(:,:,end+1)=BH(:,:,end)...
%             -BH(:,:,end)*S*Sp...
%             -BH(:,:,end)'*S*Sp...
%             +2*Y*Sp...
%             +Sp'*S'*BH(:,:,end)*S*Sp...
%             -Sp'*S'*Y*Sp...
%             -s(:,end)*s(:,end)'*Y*Sp/(s(:,end)'*s(:,end))...
%             +s(:,end)*y(:,end)'*S*Sp/(s(:,end)'*s(:,end));
%          BH_control=(BH(:,:,end)+BH(:,:,end)')/2;
%          BH=BH_save;
        %% 
        if param2>0
     %       disp('Update');
            So=S_ori;
            Yo=Y_ori;
            Ssave=S;
            S={};
            Y={};
            Sp={};
            Yp={};
            i=param2;
            [r c]=size(So);
            S{1}=So(:,end-min(max(1,i),c)+1:end);
            Y{1}=Yo(:,end-min(max(1,i),c)+1:end);
            [~, col]=size(S{1});
            ib=ia(ia<=col);
            S{1}=fliplr(S{1}(:,end+1-ib));
            Y{1}=fliplr(Y{1}(:,end+1-ib));
            %S{1}=So(:,1:min(max(1,i),c));
            %Y{1}=Yo(:,1:min(max(1,i),c));
    %        disp('List');
            Sp{1}=(S{1}'*S{1})^-1*S{1}';
            Yp{1}=(Y{1}'*Y{1})^-1*Y{1}';
            j=2;
            while i<c
               % S{j}=So(:,i+1:min(i+param3,end))
               % Y{j}=Yo(:,i+1:min(i+param3,end));
                S{j}=So(:,max(1,end-i-param3+1):end);
                Y{j}=Yo(:,max(1,end-i-param3+1):end);
                [~, col]=size(S{j});
                ib=ia(ia<=col);
                S{j}=fliplr(S{j}(:,end+1-ib));
                Y{j}=fliplr(Y{j}(:,end+1-ib));
                Sp{j}=(S{j}'*S{j})^-1*S{j}';
                Yp{j}=(Y{j}'*Y{j})^-1*Y{j}';
                i=i+param3;
                j=j+1;
            end
            %% dans un script à part
            % sortir le calcul de l'inverse de la boucle précédente
            % utiliser ia pour ne garder que les bonnes colonnes
            % si aucune colonne gardée, gérer l'exception
            % revérifier les indexes 
            [~, ccc]=size(S{end})
            BH(:,:,end+1)=BH(:,:,end)...
                -BH(:,:,end)*S{end}*Sp{end}...
                - Sp{end}'*S{end}'*BH(:,:,end)...
                + Sp{end}'*S{end}'*BH(:,:,end)*S{end}*Sp{end}...
                +2*Y{end}*Sp{end}...
                - Sp{end}'*S{end}'*Y{end}*Sp{end}; 
            if j>=3
                for r=1:j-2
         %           disp('calcul');
                    r
                    [~, ccc]=size(S{end-r+1})
                    [~, ccc]=size(S{end-r})
                    BH(:,:,end)=BH(:,:,end)...
                        + Sp{end-r+1}'*S{end-r+1}'*Y{end-r}*Sp{end-r}...
                        - Sp{end-r}'*S{end-r}'*Y{end-r+1}*Sp{end-r+1};
                    

                end
            end          
            BH(:,:,end)=(BH(:,:,end)+BH(:,:,end)')/2;
            
            
            
        else 
            BH(:,:,end+1)=BH(:,:,end);
        end
        
%         for i=[ia']
%             X=fliplr(S_ori);
%             Z=fliplr(Y_ori);
%             norm(BH(:,:,end)*X(:,i)-Z(:,i))
%         end 
        
        
        [~, tot]=size(S)
       for i=1:tot
           S{i}
           RR(i)=norm(BH(:,:,end)*S_ori(:,i*3-2:3*i)-Y_ori(:,i*3-2:3*i));
       end
        
 RR-RR(end-1)