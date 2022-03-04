function [ direct, BH ] = d_Update_Hessian( algo, BH, S, Y, WV, s, y, wv, param, S_ori, Y_ori, ia)
%D_UPDATE_HESSIAN Compute new value of Hessian or inverse Hessian base on
%chosen algorithm
% define if algo is direct on indirect
%% Given 0 as variable is no BH is given (will only return direct)
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
param1=param(1,:);
param2=param(2,:);
param3=param(3,:);
param4=param(4,:);
Sl=S(:,1:end-1);
Slp=(Sl'*Sl)^-1*Sl';
Sp=(S'*S)^-1*S';
Yp=(Y'*Y)^-1*Y';

%% Compute ew value based on parameters
switch algo
    case 'SR1'
        direct=1;
        BH(:,:,end+1)=BH(:,:,end)+wv(:,end)*wv(:,end)'/(wv(:,end)'*s(:,end));
    case 'gPSB_S1'
        direct=1;
        M=S'*Y-Y'*S;
        L=tril(M);
        dY=-S*(S'*S)^-1*L;
        BH(:,:,end+1)=BH(:,:,end)-BH(:,:,end)*S*Sp-Sp'*S'*BH(:,:,end)+Sp'*S'*BH(:,:,end)*S*Sp...
            +Sp'*(Y+dY)'+(Y+dY)*Sp-Sp'*(Y+dY)'*S*Sp;
    case 'MPSS'
        direct=1; 
     [r_S2 c_S2]=size(Sl);
        ci=(eye(r_S2)-Sl*Slp)*s(:,end);
        wi=y(:,end)-BH(:,:,end)*s(:,end);
        BH(:,:,end+1)=BH(:,:,end)+(wi*ci'+ci*wi')/(ci'*s(:,end))...
            -s(:,end)'*wi*ci*ci'/(ci'*s(:,end))^2;
    case 'BFGS'
        direct=1;
        BH(:,:,end+1)=BH(:,:,end)+y(:,end)*y(:,end)'/(y(:,end)'*s(:,end))-BH(:,:,end)*s(:,end)*s(:,end)'*BH(:,:,end)'/(s(:,end)'*BH(:,:,end)*s(:,end));
    case 'DFP'
        direct=0;
        BH(:,:,end+1)=BH(:,:,end)...
            -s(:,end)*y(:,end)'*BH(:,:,end)/(s(:,end)'*y(:,end))...
            -BH(:,:,end)'*y(:,end)*s(:,end)'/(s(:,end)'*y(:,end))...
            +s(:,end)*y(:,end)'*BH(:,:,end)*y(:,end)*s(:,end)'/(s(:,end)'*y(:,end))^2 ...
            +s(:,end)*s(:,end)'/(s(:,end)'*y(:,end));
    case 'PSB'
        direct=1;
        BH(:,:,end+1)=BH(:,:,end)...
            +wv(:,end)*s(:,end)'/(s(:,end)'*s(:,end))...
            +s(:,end)*wv(:,end)'/(s(:,end)'*s(:,end))...
            -wv(:,end)'*s(:,end)/(s(:,end)'*s(:,end))^2*s(:,end)*s(:,end)';
    case 'IPSB'
        direct=0;
        BH(:,:,end+1)=BH(:,:,end)...
            +wv(:,end)*y(:,end)'/(y(:,end)'*y(:,end))...
            +y(:,end)*wv(:,end)'/(y(:,end)'*y(:,end))...
            -wv(:,end)'*y(:,end)/(y(:,end)'*y(:,end))^2*y(:,end)*y(:,end)';
    case 'pPSB_normal'
        direct=1;
        [r_S2 c_S2]=size(S);
        C_omega=param2;
        if (c_S2==1)
            Omega=1*C_omega;
        else
            Omega=C_omega*diag(10.^(-param3*[c_S2-1:-1:0]));
        end
        X1=inv(2*ones(c_S2)+Omega^(1/2)*S'*S*Omega^(1/2));
        A_Lyap=(ones(c_S2)+Omega^(1/2)*S'*S*Omega^(1/2));
        Q_Lyap=Omega^(1/2)*S'*WV*Omega^(1/2)*X1+X1*Omega^(1/2)*WV'*S*Omega^(1/2);
        try
            X2=lyap(A_Lyap,Q_Lyap);
            BH(:,:,end+1)=BH(:,:,end)+WV*(2*Omega^(-1)+S'*S)^(-1)*S'...
                +S*(2*Omega^(-1)+S'*S)^(-1)*WV'+S*Omega^(1/2)*X2*Omega^(1/2)*S';
        catch
            BH(:,:,end+1)=BH(:,:,end)*Inf;
        end
    case 'IpPSB_normal'
        direct=0;
        [r_S2 c_S2]=size(Y);
        C_omega=param2;
        if (c_S2==1)
            Omega=C_omega*1;
        else
            Omega=C_omega*diag(10.^(-param3*[c_S2-1:-1:0]));
        end
        X1=inv(2*ones(c_S2)+Omega^(1/2)*Y'*Y*Omega^(1/2));
        A_Lyap=(ones(c_S2)+Omega^(1/2)*Y'*Y*Omega^(1/2));
        Q_Lyap=Omega^(1/2)*Y'*WV*Omega^(1/2)*X1+X1*Omega^(1/2)*WV'*Y*Omega^(1/2);
        try
            X2=lyap(A_Lyap,Q_Lyap);
            BH(:,:,end+1)=BH(:,:,end)+WV*(2*Omega^(-1)+Y'*Y)^(-1)*Y'...
                +Y*(2*Omega^(-1)+Y'*Y)^(-1)*WV'+Y*Omega^(1/2)*X2*Omega^(1/2)*Y';
        catch
            HB(:,:,end+1)=BH(:,:,end)*Inf;
        end
    case 'pPSB_mod'
        direct=1;
        [r_S2 c_S2]=size(S);
        C_omega=param2;
        if (c_S2==1)
            Omega=1*C_omega;
        else
            Omega=C_omega*diag(10.^(-param3*[c_S2-1:-1:0])); %
        end
        Omega(end,end)=Omega(end,end)*param4;
        X1=inv(2*ones(c_S2)+Omega^(1/2)*S'*S*Omega^(1/2));
        A_Lyap=(ones(c_S2)+Omega^(1/2)*S'*S*Omega^(1/2));
        Q_Lyap=Omega^(1/2)*S'*WV*Omega^(1/2)*X1+X1*Omega^(1/2)*WV'*S*Omega^(1/2);
        try
            X2=lyap(A_Lyap,Q_Lyap);
            BH(:,:,end+1)=BH(:,:,end)+WV*(2*Omega^(-1)+S'*S)^(-1)*S'...
                +S*(2*Omega^(-1)+S'*S)^(-1)*WV'+S*Omega^(1/2)*X2*Omega^(1/2)*S';
        catch
            BH(:,:,end+1)=BH(:,:,end)*Inf;
        end
    case 'IpPSB_mod'
        direct=0;
        [r_S2 c_S2]=size(Y);
        C_omega=param2;
        if (c_S2==1)
            Omega=C_omega*1;
        else
            Omega=C_omega*diag(10.^(-param3*[c_S2-1:-1:0]));
        end
        Omega(end,end)=Omega(end,end)*param4;
        X1=inv(2*ones(c_S2)+Omega^(1/2)*Y'*Y*Omega^(1/2));
        A_Lyap=(ones(c_S2)+Omega^(1/2)*Y'*Y*Omega^(1/2));
        Q_Lyap=Omega^(1/2)*Y'*WV*Omega^(1/2)*X1+X1*Omega^(1/2)*WV'*Y*Omega^(1/2);
        try
            X2=lyap(A_Lyap,Q_Lyap);
            BH(:,:,end+1)=BH(:,:,end)+WV*(2*Omega^(-1)+Y'*Y)^(-1)*Y'...
                +Y*(2*Omega^(-1)+Y'*Y)^(-1)*WV'+Y*Omega^(1/2)*X2*Omega^(1/2)*Y';
        catch
            BH(:,:,end+1)=BH(:,:,end)*Inf;
        end
    case 'SUpPSB'
        direct=1;
        [r_S2 c_S2]=size(S);
        c_S2=c_S2;
        C_omega=param2;
        Omega=C_omega*diag(10.^(-param3*[c_S2-1:-1:0]));
        B_bar=(BH(:,:,end)+BH(:,:,end)')/2;
        w_bar=y(:,end)-B_bar*s(:,end);
        T1=(s(:,end)*w_bar' +w_bar*s(:,end)')/(s(:,end)'*s(:,end));
        T2=zeros(r_S2);
        T3=zeros(r_S2);
        T4=zeros(r_S2);
        T5=zeros(r_S2);
        T6=-(w_bar'*s(:,end)+s(:,end)'*w_bar)/(2*(s(:,end)'*s(:,end))^2)*s(:,end)*s(:,end)';
        T7=zeros(r_S2);
        T9=zeros(r_S2); 
        for ii=1:c_S2-1
            T2=T2+Omega(ii)*(Y(:,ii)*S(:,ii)'+S(:,ii)*Y(:,ii)')/2;
            T3=T3-Omega(ii)*(s(:,end)'*S(:,ii)*s(:,end)*Y(:,ii)'...
                +S(:,ii)'*s(:,end)*Y(:,ii)*s(:,end)')/(2*s(:,end)'*s(:,end));
            T4=T4+Omega(ii)*((1*y(:,end)'*S(:,ii)-s(:,end)'*Y(:,ii))*s(:,end)*S(:,ii)' ...
                +(1*S(:,ii)'*y(:,end)-Y(:,ii)'*s(:,end))*S(:,ii)*s(:,end)')/(2*s(:,end)'*s(:,end)); % 2 changed into 1
            T5=T5-Omega(ii)*(s(:,end)'*S(:,ii)*S(:,ii)'*y(:,end)...
                -s(:,end)'*Y(:,ii)*S(:,ii)'*s(:,end))...
                /(s(:,end)'*s(:,end))^2*s(:,end)*s(:,end)';
            T7=T7+Omega(ii)*S(:,ii)*S(:,ii)'/2;
            T9=T9-Omega(ii)*(s(:,end)*S(:,ii)'*(s(:,end)'*s(:,end)))/(2*(s(:,end)'*s(:,end))); % add
        end
        X_SUpPSB=B_bar +T1+T2+T3+T4+T5+T6;
        T8=eye(r_S2)/2+T7+T9;
        try
            X2=lyap(T8,-X_SUpPSB);
            BH(:,:,end+1)=X2;
        catch
            BH(:,:,end+1)=BH(:,:,end)*Inf;
        end
    case 'ISUpPSB'
        direct=0;
        [r_Y2 c_Y2]=size(Y);
        c_Y2=c_Y2;
        C_omega=param2;
        Omega=C_omega*diag(10.^(-param3*[c_Y2-1:-1:0]));
        BH_bar=(BH(:,:,end)+BH(:,:,end)')/2;
        v_bar=s(:,end)-BH_bar*y(:,end);
        T1=(y(:,end)*v_bar' +v_bar*y(:,end)')/(y(:,end)'*y(:,end));
        T2=zeros(r_Y2);
        T3=zeros(r_Y2);
        T4=zeros(r_Y2);
        T5=zeros(r_Y2);
        T6=-(v_bar'*y(:,end)+y(:,end)'*v_bar)/(2*(y(:,end)'*y(:,end))^2)*y(:,end)*y(:,end)';
        T7=zeros(r_Y2);
        T9=zeros(r_Y2); %add
        for ii=1:c_Y2-1
            T2=T2+Omega(ii)*(S(:,ii)*Y(:,ii)'+Y(:,ii)*S(:,ii)')/2;
            T3=T3-Omega(ii)*(y(:,end)'*Y(:,ii)*y(:,end)*S(:,ii)'...
                +Y(:,ii)'*y(:,end)*S(:,ii)*y(:,end)')/(2*y(:,end)'*y(:,end));
            T4=T4+Omega(ii)*((1*s(:,end)'*Y(:,ii)-y(:,end)'*S(:,ii))*y(:,end)*Y(:,ii)' ...
                +(1*Y(:,ii)'*s(:,end)-S(:,ii)'*y(:,end))*Y(:,ii)*y(:,end)')/(2*y(:,end)'*y(:,end)); % 2 changed into 1
            T5=T5-Omega(ii)*(y(:,end)'*Y(:,ii)*Y(:,ii)'*s(:,end)...
                -y(:,end)'*S(:,ii)*Y(:,ii)'*y(:,end))...
                /(y(:,end)'*y(:,end))^2*y(:,end)*y(:,end)';
            T7=T7+Omega(ii)*Y(:,ii)*Y(:,ii)'/2;
            T9=T9-Omega(ii)*(y(:,end)*Y(:,ii)'*(y(:,end)'*y(:,end)))/(2*(y(:,end)'*y(:,end))); % add
        end
        X_SUpPSB=BH_bar +T1+T2+T3+T4+T5+T6;
        T8=eye(r_Y2)/2+T7+T9;
        try
            X2=lyap(T8,-X_SUpPSB);
            BH(:,:,end+1)=X2;
        catch
            BH(:,:,end+1)=BH(:,:,end)*Inf;
        end
    case 'gPSBs'
        direct=1;
        BH(:,:,end+1)=BH(:,:,end)... 
            -BH(:,:,end)*S*Sp...
        -BH(:,:,end)'*S*Sp...
            +2*Y*Sp...
        +Sp'*S'*BH(:,:,end)*S*Sp...
            -Sp'*S'*Y*Sp;
        BH(:,:,end)=(BH(:,:,end)+BH(:,:,end)')/2;    
   case 'gPSBm'
        direct=1;
        BH(:,:,end+1)=BH(:,:,end)...
            -BH(:,:,end)*S*Sp...
        -BH(:,:,end)'*S*Sp...
        +Sp'*S'*BH(:,:,end)*S*Sp;
        BH(:,:,end)=(BH(:,:,end)+BH(:,:,end)')/2+(Y*Sp)'+Y*Sp-(Sp'*S'*Y*Sp)'/2;    
    case 'SUgPSBs'
        direct=1;
        BH(:,:,end+1)=BH(:,:,end)...
            -BH(:,:,end)*S*Sp...
        -BH(:,:,end)'*S*Sp...
            +2*Y*Sp...
        +Sp'*S'*BH(:,:,end)*S*Sp...
            -Sp'*S'*Y*Sp...
            -s(:,end)*s(:,end)'*Y*Sp/(s(:,end)'*s(:,end))...
            +s(:,end)*y(:,end)'*S*Sp/(s(:,end)'*s(:,end));
        BH(:,:,end)=(BH(:,:,end)+BH(:,:,end)')/2;
     case 'SGOMS'
        direct=1;
       if param2>0
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
            Sp{1}=(S{1}'*S{1})^-1*S{1}';
            Yp{1}=(Y{1}'*Y{1})^-1*Y{1}';
            j=2;
            while i<c
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
            BH(:,:,end+1)=BH(:,:,end)...
                -BH(:,:,end)*S{end}*Sp{end}...
                - Sp{end}'*S{end}'*BH(:,:,end)...
                + Sp{end}'*S{end}'*BH(:,:,end)*S{end}*Sp{end}...
                +2*Y{end}*Sp{end}...
                - Sp{end}'*S{end}'*Y{end}*Sp{end}; 
            if j>=3
                for r=1:j-2
                    BH(:,:,end)=BH(:,:,end)...
                        + Sp{end-r+1}'*S{end-r+1}'*Y{end-r}*Sp{end-r}...
                        - Sp{end-r}'*S{end-r}'*Y{end-r+1}*Sp{end-r+1};
                end
            end          
            BH(:,:,end)=(BH(:,:,end)+BH(:,:,end)')/2;         
        else 
            BH(:,:,end+1)=BH(:,:,end);
        end
    otherwise
        error('Unknown method');
end
BH=BH(:,:,end-1:end);
end

