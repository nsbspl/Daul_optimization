%% Target-Estimation plot for evaluating the accuracy of the methods
clear
f_true=.15;
U_true=.4;
F_true=.050;
D_true=.750;
T_syn=5/1000;
F_DBS_=[5, 10 ,20, 30 , 50 , 100 , 130 , 200];

for i=1:length(F_DBS_)
F_DBS=F_DBS_(i);
I_inf(i)=infinity_current(f_true,U_true,F_true,D_true,T_syn,F_DBS);
end

pulse_num=100;
I_REF=zeros(length(F_DBS_),pulse_num);
for i=1:length(F_DBS_)
   I_REF(i,:)=DBS_profile_neurotransmitters(f_true,U_true,F_true,D_true,.00001,F_DBS_(i),pulse_num);
end

for i=1:100
    lb=[1e-6,1e-6,.010,.01];
    ub=[1,1,1,1];
    x0=rand(1,4).*(ub-lb)+lb;
    [fitresult, gof] = gradient_fit(F_DBS_, I_inf,x0,ub,lb);
    f_std(i)=fitresult.f;
    U_std(i)=fitresult.U;
    F_std(i)=fitresult.F;
    D_std(i)=fitresult.D;
    fval_std(i)=gof;
    x_std=[f_std(i),U_std(i),F_std(i),D_std(i)];

    fun = @(x)100*Profile_Error(x,I_REF(:,1:40),T_syn,F_DBS_); % assigning the errro function
    func= @(x)fine_tune_error(fun,x,x_std,.5);
    
    options = optimset('Display','off','MaxFunEvals',200);
    [x,fval]=fminsearchbnd(func,x_std,lb,ub,options);
    
%     options =  optimoptions('simulannealbnd','InitialTemperature',40,'TemperatureFcn',@temperaturefast)
%     [x,fval] = simulannealbnd(fun,x_std,lb,ub, options);
    
%     [x,fval] = bads(fun,x_std,lb,ub,lb,ub);
    f_dual(i)=x(1);
    U_dual(i)=x(2);
    F_dual(i)=x(3);
    D_dual(i)=x(4);
    fval_dual(i)=fval;
%     
%     [x,fval] = bads(fun,x0,lb,ub,lb,ub);
    [x,fval]=fminsearchbnd(fun,x0,lb,ub,options);
    f_mse(i)=x(1);
    U_mse(i)=x(2);
    F_mse(i)=x(3);
    D_mse(i)=x(4);
    fval_mse(i)=fval;
    
end 
    