% close all
clear
figure;
f_true=[0.05,   0.05,   0.3,    0.15,   0.11]; 
U_true=[0.7,    0.5,    0.25,   0.15,   0.1];
F_true=[20,     50,     200,    500,    1000];
D_true=[1700,   500,    200,    50,     20];

for N=1:5
    
    f=f_true(N);
    U=U_true(N);
    D=D_true(N);
    F=F_true(N);
    x_true=[f,U,F,D];

    pulse_num=100;
    F_DBS_=[1,2,5,10,20,30,50,100,200];
    for i=1:length(F_DBS_)
        F_DBS=F_DBS_(i);
        I_inf(i)=infinity_current(f,U,F,D,F_DBS);
    end

    pulse_num=100;
    I_REF=zeros(length(F_DBS_),pulse_num);
    for i=1:length(F_DBS_)
       I_REF(i,:)=DBS_profile(f,U,F,D,F_DBS_(i),pulse_num);
    end


    I_=zeros(1,200);
    for f_dbs=1:200
        I_(f_dbs)=infinity_current(f,U,F,D,f_dbs);
    end
    % plot(1:200,I_)
    % title(['f=',num2str(f),', U=',num2str(U), ', F=',num2str(F),', D=',num2str(D)])

    for i=1:100
        clear global
%         global f_global U_global F_global D_global E_global
        lb=[1e-6,1e-6,10,10];
        ub=[1,1,1000,1000];
        x0=rand(1,4).*(ub-lb)+lb;
        [fitresult, gof] = gradient_fit(F_DBS_, I_inf,x0);
        f_std(i)=fitresult.f;
        U_std(i)=fitresult.U;
        F_std(i)=fitresult.F*1000;
        D_std(i)=fitresult.D*1000;

        x_std=[f_std(i),U_std(i),F_std(i),D_std(i)];
    end
    if N==1
        csvwrite('C:\Users\Ali Reza\JupyterDir\Method paper\Steady_state_estimation_SuperDepression_syn.csv',[1:length(f_std);f_std;U_std;F_std;D_std])
    elseif N==2
        csvwrite('C:\Users\Ali Reza\JupyterDir\Method paper\Steady_state_estimation_Depression_syn.csv',[1:length(f_std);f_std;U_std;F_std;D_std])
    elseif N==3
        csvwrite('C:\Users\Ali Reza\JupyterDir\Method paper\Steady_state_estimation_Psudo_syn.csv',[1:length(f_std);f_std;U_std;F_std;D_std])
    elseif N==4
        csvwrite('C:\Users\Ali Reza\JupyterDir\Method paper\Steady_state_estimation_Facilitation_syn.csv',[1:length(f_std);f_std;U_std;F_std;D_std])
    elseif N==5
        csvwrite('C:\Users\Ali Reza\JupyterDir\Method paper\Steady_state_estimation_SuperFacilitation_syn.csv',[1:length(f_std);f_std;U_std;F_std;D_std])
    end
end