function S=DBS_profile_neurotransmitters(f,U,F,D,syn,F_DBS,pulse_num)
% DBS_profile(f,U,F,D,F_DBS,pulse_num)
% F_DBS=50;
% 
% tau_Dep=K*500;
% tau_Fac=a*tau_Dep;
% 
% U=0.15;
tau_syn=syn;
i=0;
TSPK_=[];
S=[];
A = 1;
R = [];
u = [];
R_minus(1) = 1;  % R is X which is the prob. of existance of neurotransmitter
u_minus(1) = U; % U is utilization prob.
R_cont(1:2) = 1;
u_cont(1:2) = U;
I_syn(1:2) = 0; %zeros(L,1);
% tspk = [];% zeros(p.Net_size,1);
Delta_syn = [];

dT=1/F_DBS;
    
while 1
   i=i+1;
   if i==1
       
       u_plus(1)=u_minus(1)*(1-f)+f;
       R_plus(1)=R_minus(1)*(1-u_minus(1));
       Delta_syn(1) =  A * R_minus(1) * u_plus(1) ;
       I_syn(1)=Delta_syn(1);
   else
       u_minus(i)=(u_plus(i-1)-U)*exp(- dT / F)+U;
%        u_minus(i)=u_plus(i-1)*exp(- dT / tau_Fac);
       u_plus(i) = u_minus(i)*(1-f) + f; %% u+
       R_minus(i)=(R_plus(i-1)-1)*exp(- dT / D )+1;
       R_plus(i) = R_minus(i) * (1-u_minus(i)) ; %% x-

       Delta_syn(i) =  A * R_minus(i) * u_plus(i) ;
       I_syn(i) = Delta_syn(i) + I_syn(i-1)*exp(- dT / tau_syn) ;
   end
   TSPK_(end+1)=i*dT;
   S(end+1)=I_syn(i);
   
   if i>=pulse_num
       break
   end
end
Up=u_plus(end);
Rm=R_minus(end);
% Ref(F_DBS/10,:)=S;