function I=infinity_current(f,U,F,D,Tau_syn,F_dbs)
u_minus=(U*(1-exp(-1./(F_dbs*F)))+f*exp(-1./(F_dbs*F)))/(1-(1-f)*exp(-1./(F_dbs*F)));
Delta=(u_minus*(1-f)+f)*((1-exp(-1./(F_dbs*D)))/(1-(1-u_minus)*exp(-1./(F_dbs*D))));
% Tau_syn=3;
I=Delta/(1-exp(-1./(F_dbs*Tau_syn)));
%A=((U*(1-f)+f)/f)*



%I=(((U*(1-exp(-1./(x*F)))+f*exp(-1./(x*F)))/(1-(1-f)*exp(-1./(x*F))))*(1-f)+f)*((1-exp(-1./(x*D)))/(1-(1-((U*(1-exp(-1./(x*F)))+f*exp(-1./(x*F)))/(1-(1-f)*exp(-1./(x*F)))))*exp(-1./(x*D))));