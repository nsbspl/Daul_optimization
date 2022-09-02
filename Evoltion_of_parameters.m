clear
close all

f=.02;
U=.4;
F=.75;
D=.50;
T_syn=1e-6;
x_true=[f,U,F,D];
f_true=f;
U_true=U;
D_true=D;
F_true=F;

MaxIter=50;
options = optimset('MaxFunEvals',MaxIter);

pulse_num=100;
F_DBS_=[1,2,5,10,20,30,50,100,200];
for i=1:length(F_DBS_)
F_DBS=F_DBS_(i);
I_inf(i)=infinity_current(f,U,F,D,T_syn,F_DBS);
end

pulse_num=100;
I_REF=zeros(length(F_DBS_),pulse_num);
for i=1:length(F_DBS_)
   I_REF(i,:)=DBS_profile(f,U,F,D,T_syn,F_DBS_(i),pulse_num)+.05*randn(1,pulse_num);
end


I_=zeros(1,200);
for f_dbs=1:200
    I_(f_dbs)=infinity_current(f,U,F,D,T_syn,f_dbs);
end

lb=[1e-6,1e-6,.001,.001];
ub=[.1,.91,1,1];
E_MSE=[];
E_dual=[];
distances_dual=[];
distances_MSE=[];
mode='Normal';

for SEED=1:2
    clear global
    SEED
    global f_global U_global F_global D_global E_global
    
    rng(SEED)% set the random seed
    x0=rand(1,4).*(ub-lb)+lb; % x0 =[ 0.8963    0.8657  .802 .559 ] %
    [fitresult, gof] = gradient_fit_normalized(F_DBS_, I_inf,x0,T_syn ,ub, lb,MaxIter,mode,0)
    f_std(i)=fitresult.f;
    U_std(i)=fitresult.U;
    F_std(i)=fitresult.F;
    D_std(i)=fitresult.D;

    x_std=[f_std(i),U_std(i),F_std(i),D_std(i)];

    fun = @(x)1*Profile_Error(x,I_REF(:,1:60),T_syn,F_DBS_); % assigning the errro function
    func= @(x)fine_tune_error(fun,x,x_std,0);

    [x,fval]=fminsearchbnd(func,x_std,lb,ub,options);

    f_dual=f_global;
    U_dual=U_global;
    F_dual=F_global;
    D_dual=D_global;
%     E_dual=E_global;

    E_dual=AddAverage(E_dual,E_global,MaxIter,SEED);
    
    clear global
    global f_global U_global F_global D_global E_global
    [x,fval]=fminsearchbnd(fun,x0,lb,ub,options);
    
    f_MSE=f_global;
    U_MSE=U_global;
    F_MSE=F_global;
    D_MSE=D_global;
    X_dual=[f_true-f_dual;U_true-U_dual;F_true-F_dual;D_true-D_dual];
    X_MSE=[f_true-f_MSE;U_true-U_MSE;F_true-F_MSE;D_true-D_MSE];
    
    E_MSE=AddAverage(E_MSE,E_global,MaxIter,SEED);
    distances_dual=AddAverage(distances_dual,sqrt(sum(X_dual.^2)),MaxIter,SEED);
    distances_MSE=AddAverage(distances_MSE,sqrt(sum(X_MSE.^2)),MaxIter,SEED);
%     if SEED==1
%         E_MSE=[E_global,E_global(end).*ones(1,MaxIter-length(E_global))];
%         distances_dual=[sqrt(sum(X_dual.^2)),sqrt(sum(X_dual(end)^2)).*ones(1,MaxIter-length(D_dual))];
%         distances_MSE=[sqrt(sum(X_MSE.^2)),sqrt(sum(X_MSE(end)^2)).*ones(1,MaxIter-length(D_MSE))];
%     else
%         E_MSE=(SEED*E_MSE+[E_global,E_global(end).*ones(1,MaxIter-length(E_global))])./(SEED+1);
%         distances_dual=(distances_dual+[sqrt(sum(X_dual.^2)),sqrt(sum(X_dual(end)^2)).*ones(1,MaxIter-length(D_dual))])./(SEED+1);
%         distances_MSE=(distances_MSE+[sqrt(sum(X_MSE.^2)),sqrt(sum(X_MSE(end)^2)).*ones(1,MaxIter-length(D_MSE))])./(SEED+1);
%     end
        
    
end

%%

figure
plot(f_dual)
hold on
plot(f_MSE)
plot(f_true+0*f_MSE,'g')
title('f')
legend('daul','MSE','true')

figure
plot(U_dual)
hold on
plot(U_MSE)
plot(U_true+0*U_MSE,'g')
title('U')
legend('daul','MSE','true')

figure
plot(F_dual)
hold on
plot(F_MSE)
plot(F_true+0*F_MSE,'g')
title F
legend('daul','MSE','true')

figure
plot(D_dual)
hold on
plot(D_MSE)
plot(D_true+0*D_MSE,'g')
title D
legend('daul','MSE','true')

%%
Sample=min([1,50,100,250],length(E_dual));
% close all
Fig=figure('Position',[100, 100, 400, 220]);
s1=subplot(1,1,1);
plot(log(E_dual),'b')
hold on
plot(log(E_MSE),'r');

plot(Sample,log(E_dual(Sample)),'.b','MarkerSize',20)
plot(Sample,log(E_MSE(Sample)),'.r','MarkerSize',20)
set(s1,'XTickLabel','');
title log(Error)
xlim([0 300])

Fig=figure('Position',[500, 100, 400, 220]);
s2=subplot(1,1,1);
plot(distances_dual); hold on
plot(distances_MSE)
plot(Sample,distances_dual(Sample),'.b','MarkerSize',20)
plot(Sample,distances_MSE(Sample),'.r','MarkerSize',20)
title Distances
xlabel('Iteration')
xlim([0 300])
legend('dual','MSE')


%%
figure('Position',[100 100 700 400]);
n=0;
for i=Sample
    n=n+1;
    s=subplot(2,2,n);
    plot(I_REF(7,:),'k'); hold on
    plot(DBS_profile(f_dual(min(end,i)),U_dual(min(end,i)),F_dual(min(end,i)),D_dual(min(end,i)),T_syn,50,pulse_num),'b')
    plot(DBS_profile(F_MSE(min(end,i)),U_MSE(min(end,i)),F_MSE(min(end,i)),D_MSE(min(end,i)),T_syn,50,pulse_num),'r')
    xlim([0 40])
    ylim([-.1 .8])
    title(['Iteration ',num2str(i)])
    
    if n==1 || n==2
        set(s,'XTick','')
    else
        xlabel('stimulation number')
    end
    
    if n==2 || n==4
        set(s,'YTick','')
    else
        ylabel('EPSC')
    end
    
    if n==2
        legend('Reference','Dual','MSE')
    end
end

%%

function X=AddAverage(X,x,MaxIter,trial)
    % this function add a new trial to the average of the data
    
    if length(x)<MaxIter
        if trial==1
            X=[x,x(end)*ones(1,MaxIter-length(x))];
        else
            X=((trial-1)*X+[x,x(end)*ones(1,MaxIter-length(x))])./trial;
        end
    else
        if trial==1
            X=x(1:MaxIter);
        else
            X=((trial-1)*X+x(1:MaxIter))./trial;
        end
    end
end