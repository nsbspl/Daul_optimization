function S=DBS_profile(f,U,F,D,T_syn,F_DBS,pulse_num)
    % DBS_profile(f,U,F,D,F_DBS,pulse_num)
    % F_DBS=50;
    % 
    % tau_Dep=K*500;
    % tau_Fac=a*tau_Dep;
    % 
    % U=0.15;
    %     i=0;
    %     TSPK_=[];
    %     S=[];
    %     A = 1;
    %     R = [];
    %     u = [];
    %     R_minus(1) = 1;  % R is X which is the prob. of existance of neurotransmitter
    %     u_minus(1) = U; % U is utilization prob.
    %     R_cont(1:2) = 1;
    %     u_cont(1:2) = 0;
    %     I_syn(1:2) = 0; %zeros(L,1);
    %     % tspk = [];% zeros(p.Net_size,1);
    %     Delta_syn = [];
    % 
    %     dT=1/F_DBS;
    %
    % while 1
    %    i=i+1;
    %    if i==1
    %        
    %        u_plus(1)=u_minus(1)*(1-f)+f;
    %        R_plus(1)=R_minus(1)*(1-u_minus(1));
    %        Delta_syn(1) =  A * R_minus(1) * u_plus(1) ;
    %        I_syn(1)=Delta_syn(1);
    %    else
    %        u_minus(i)=(u_plus(i-1)-U)*exp(- dT / F)+U;
    % %        u_minus(i)=u_plus(i-1)*exp(- dT / tau_Fac);
    %        u_plus(i) = u_minus(i)*(1-f) + f; %% u+
    %        R_minus(i)=(R_plus(i-1)-1)*exp(- dT / D )+1;
    %        R_plus(i) = R_minus(i) * (1-u_minus(i)) ; %% x-
    % 
    %        Delta_syn(i) =  A * R_minus(i) * u_plus(i) ;
    %        I_syn(i) = Delta_syn(i) + I_syn(i-1)*exp(- dT / T_syn) ;
    %    end
    %    TSPK_(end+1)=i*dT;
    %    S(end+1)=I_syn(i);
    %    
    %    if i>=pulse_num
    %        break
    %    end
    % end

    u=U*(1-f)+f;
    R=1;
    I_sparse=u*R;

    dT=1/F_DBS;
    for i=1:pulse_num-1
        [u,R,I_sparse(i+1)]=DBS_DTM(f,U,F,D,T_syn,u,R,I_sparse(i),dT);
    end
    S=I_sparse;
end
function [u_new,R_new,I]=DBS_DTM(f,U,F,D,syn,u_old,R_old,I,dT)

    R_new=1+(R_old*(1-u_old)-1)*exp(-dT/D);

    u_new=U+f*(1-U)+(1-f)*(u_old-U)*exp(-dT/F); %% TM decret
    % u_new=U+(u_old+f*(1-u_old)-U)R*exp(-dT/F); %% Costa  et al.
    I=I*exp(-dT/syn)+R_new*u_new;
end