function [wv, WV, BH, deltap]=l_direction_calculation(algo, BH, S, Y, s, y, param, K, direct, n, i, p, run, S_ori, Y_ori, ia)
if ~exist('run','var')
    run=0;
end
    % computing W or V
    if (direct==1)
        wv=y(:,end)-BH(:,:,end)*s(:,end);
        WV=Y-BH(:,:,end)*S;
    elseif (direct==0)
        wv=s(:,end)-BH(:,:,end)*y(:,end);
        WV=S-BH(:,:,end)*Y;
    else error('Nor direct, nor indirect algorithm')
    end
    %%% update of Hessian
    [ direct, BH ] = d_Update_Hessian( algo, BH, S, Y, WV, s, y, wv, param,  S_ori, Y_ori, ia);
    if (BH(:,:,end))'-BH(:,:,end)~=BH(:,:,end)*0
        ['BH is not symmetric at iteration']
        norm((BH(:,:,end))'-BH(:,:,end))/norm(BH(:,:,end));
        [algo i, run]
    end
    %%% value on new point
    if (direct==1)
        [deltap, flag]=gmres(BH(:,:,end),-K(:,end));
    elseif (direct==0)
        deltap=-BH(:,:,end)*K(:,end);
    else error('Nor direct, nor indirect algorithm')
    end
    if K(:,end)'*deltap>0 %not a descent direction =>reinitialisation   
       BH(:,:,end)=[];
        BH_back=BH(:,:,end);
        BH(:,:,end)=eye(n);
        if run==0
        [wv, WV, BH, deltap]=l_direction_calculation(algo, BH, S, Y, s, y, param, K, direct,n, i,p, 1, S_ori, Y_ori, ia);
        elseif run==1
%         [i, run]
        S=s(:,end);
        Y=y(:,end);
        [wv, WV, BH, deltap]=l_direction_calculation(algo, BH, S, Y, s, y, param, K, direct,n, i, p, 2, S_ori, Y_ori, ia);
        else 
         deltap= -K(:,end);
         BH(:,:,end+1)=eye(n);
%         ['ici:'];
%         [K(:,end)'*deltap];
        end
        BH(:,:,end-1)=BH_back;
    end