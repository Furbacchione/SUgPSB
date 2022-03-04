function [ alpha, i ] = e_line_search( func, p, deltap, mu, eta, tol, delta)
% E_LINE_SEARCH Apply line search
%   http://www.ii.uib.no/~lennart/drgrad/More1994.pdf
% https://core.ac.uk/download/pdf/14916847.pdf
% for bissection http://www.cas.mcmaster.ca/~cs4te3/notes/LineSearchMethods.pdf
%% internal parameters
if ~exist('delta','var')
    delta=0.66;
end
a_l=0;
a_t=1;
a_u=1000;
min_interval=0.001;
%% initialization
i=1;
I(i)=abs(a_u-a_l);

norm_phi=@(a) norm(func(p+a*deltap,2));
phi=@(a) func(p+a*deltap,1);
dphi=@(a) func(p+a*deltap,2)'*deltap;
psi=@(a) func(p+a*deltap,1)-func(p,1)-mu*a*func(p,2)'*deltap;
dpsi=@(a) func(p+a*deltap,2)'*deltap-mu*func(p,2)'*deltap;

if (dpsi(a_l)>0) % if method gives a wrong direction, go in other direction
    a_t=-a_t;
    a_u=-a_u;
end

% %% graph to help debugging
% MyAlpha=a_l:-0.02:a_u;
% for j=1:max(size(MyAlpha))
%     MyPhi(j)=phi(MyAlpha(j));
%     MyPsi(j)=phi(0)+mu*dphi(0)*MyAlpha(j);
% end
% figure
% plot(MyAlpha, MyPhi)
% hold on
% plot(MyAlpha, MyPsi)
% plot([a_t,a_t], [0, max(MyPsi)])
% 
% cond1=phi(a_t)-(phi(0)+mu*dphi(0)*a_t)
% cond2=abs(dphi(a_t))-eta*abs(dphi(0))
%% starting loop
% min(abs(a_u-a_t),abs(a_l-a_t))>min_interval
% phi(a_t)>phi(0)+mu*dphi(0)*a_t
% abs(dphi(a_t))>eta*abs(dphi(0))
while min(abs(a_u-a_t),abs(a_l-a_t))>min_interval &  (phi(a_t)>phi(0)+mu*dphi(0)*a_t | abs(dphi(a_t))>eta*abs(dphi(0)) & norm_phi(a_t)>=tol )
% % %     if i>=3 && I(i)/I(i-2)>delta*I(i-2)
% % %         f_l=phi(a_l);
% % %         f_t=phi((a_l+a_u)/2);
% % %         f_u=phi(a_u);
% % %         if f_t*f_l<0
% % %             a_l_n=(a_l+a_u)/2;
% % %             a_u_n=a_u;
% % %         else
% % %             a_u_n=(a_l+a_u)/2;
% % %             a_l_n=a_l;
% % %         end
% % %         a_t_n=(a_u_n+a_l_n)/2;
% % %     else
        
        %% computing values
        % could be better if not computed each time
        if (psi(a_t)<=0 && dphi(a_t)>=0)
            f_l=phi(a_l);
            g_l=dphi(a_l);
            f_t=phi(a_t);
            g_t=dphi(a_t);
            f_u=phi(a_u);
            g_u=dphi(a_u);
            [a_l a_t a_u; f_l f_t f_u; g_l g_t g_u; norm_phi(a_l) norm_phi(a_t) norm_phi(a_u)]
        else
            f_l=psi(a_l);
            g_l=dpsi(a_l);
            f_t=psi(a_t);
            g_t=dpsi(a_t);
            f_u=psi(a_u);
            g_u=dpsi(a_u);
        end
        
        %% Defining interval
        if f_t>f_l
            a_l_n=a_l;
            a_u_n=a_t;
        elseif g_t*(a_l-a_t)>0
            a_l_n=a_t;
            a_u_n=a_u;
        else
            a_l_n=a_t;
            a_u_n=a_l;
        end
        %% Defining help values
        [a_c,coef1]=f_midpoint(a_l,a_t,f_l,f_t,g_l,g_t)
        a_q=f_midpoint(a_l,a_t,f_l,f_t,g_l,[]);
        a_s=f_midpoint(a_l,a_t,f_l,[],g_l,g_t);
        a_v=f_midpoint(a_u,a_t,f_u,f_t,g_u,g_t);
        %% new a_t
        if f_t>f_l
            if abs(a_c-a_l)<abs(a_q-a_l)
                a_t_n=a_c;
            else
                a_t_n=(a_q+a_c)/2;
            end
        elseif f_t<=f_l & g_t*g_l<0
            if abs(a_c-a_t)>=abs(a_s-a_t)
                a_t_n=a_c;
            else
                a_t_n=a_s;
            end
        elseif f_t<=f_l & g_t*g_l>=0 & abs(g_t)<=abs(g_l)
            if coef1*(a_t-a_l)>0 && abs(a_c-a_l)>abs(a_t-a_l) % if conic tend to infinity in direction of the step and a_c beyond a_t
                if abs(a_c-a_t)<abs(a_s-a_t)
                    a_t_n=a_c;
                else
                    a_t_n=a_s;
                end
            else
                a_t_n=a_s;
            end
            if a_t>a_l
                a_t_n=min(a_t+delta*(a_u-a_t),a_t_n);
            else
                a_t_n=max(a_t+delta*(a_u-a_t),a_t_n);
            end
        else
            a_t_n=a_v;
        end
        
% % %     end
    i=i+1;
    a_l=a_l_n;
    a_t=a_t_n;
    a_u=a_u_n;
    % just for test
    a_l_n=[];
    a_t_n=[];
    a_u_n=[];
    
%         %% graph to help debugging
%             figure
%             MyPhi=[];
%             MyPsi=[];
%             MyAlpha=min(a_l,a_u):0.02:max(a_u,a_l);
%         for j=1:max(size(MyAlpha))
%             MyPhi(j)=phi(MyAlpha(j));
%             MyPsi(j)=phi(0)+mu*dphi(0)*MyAlpha(j);
%         end
%         plot(MyAlpha, MyPhi)
%         hold on
%         plot(MyAlpha, MyPsi)
%         plot([a_t,a_t], [0, max(MyPsi)])
%     
%             cond1=phi(a_t)-(phi(0)+mu*dphi(0)*a_t)
%             cond2=abs(dphi(a_t))-eta*abs(dphi(0))
    %% Interval calculation
    I(i)=abs(a_u-a_l);
end
i=i-1;
alpha=a_t;
end