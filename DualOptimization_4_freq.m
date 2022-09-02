% close all
clear
close all

% f=0.25; 
% U=0.7;
% F=850;
% D=150;
%%
f=0.2;
U=0.4;
F=0.7;
D=0.25;
T_syn=.003;
% f=.05;
% U=.2;
% F=450;
% D=950;

x_true=[f,U,F,D];
f_true=f;
U_true=U;
D_true=D;
F_true=F;


pulse_num=100;
F_DBS_=[20,60,130];%[5,10,20,30,50,100,130,200];
for k=1:length(F_DBS_)
F_DBS=F_DBS_(k);
I_inf(k)=infinity_current_Tsyn(f,U,F,D,T_syn,F_DBS);
end

pulse_num=100;
I_REF=zeros(length(F_DBS_),pulse_num);
figure(1)
hold on
for k=1:length(F_DBS_)
    
    
    
   I_REF(k,:)=DBS_profile_recursive(f,U,F,D,T_syn,F_DBS_(k),pulse_num);
%    I_REF(k,:)=I_REF(k,:)/(f+U*(1-f));
   I_REF(k,:)=I_REF(k,:)+(.2*std(I_REF(k,1:50))*randn(1,pulse_num));
   I_inf(k)=mean(I_REF(k,50:100));
   subplot(length(F_DBS_),1,k);
   p(1)=plot(I_REF(k,:),'k','LineWidth',1);
   title(['F_{DBS}=',num2str(F_DBS_(k)),'Hz'])
   ylabel("EPSP")
%    xlabel('Stimulus Number')
end
xlabel('Stimulus Number')


I_=zeros(1,200);
for f_dbs=1:200
    I_(f_dbs)=infinity_current_Tsyn(f,U,F,D,T_syn,f_dbs);
end

MaxIterGrad=40;
MaxIterfmin=80;
MaxIter_total=3;
% plot(1:200,I_)
% title(['f=',num2str(f),', U=',num2str(U), ', F=',num2str(F),', D=',num2str(D)])
%%
rng(4);
for k=1:400
    k
    clear global
%     global f_global U_global F_global D_global E_global
    lb=[2e-2,1e-2,1e-2,1e-2];
    ub=[.8,.9,1,1];
%     lb=[-4,-4,-4,-4];
%     ub=[-1,0,1,1];
%     x=rand(1,4).*(ub-lb)+lb;
%     f_true(k)=x(1);
%     U_true(k)=x(2);
%     F_true(k)=x(3);
%     D_true(k)=x(4);
%     for freq=1:length(F_DBS_)
%        I_REF(freq,:)=DBS_profile_neurotransmitters(f,U,F,D,T_syn,F_DBS_(freq),pulse_num);
%        I_REF(freq,:)=I_REF(freq,:)/I_REF(freq,1)+.03*randn(1,pulse_num);
%        I_inf(freq)=mean(I_REF(freq,50:100));
%     end

    x=rand(1,4).*(ub-lb)+lb;
    x0=x;
    for i=1:MaxIter_total
        [fitresult, gof] = gradient_fit_normalized(F_DBS_, I_inf,x,T_syn, ub ,lb,MaxIterGrad,'Normal');

        x_std=[fitresult.f,fitresult.U,fitresult.F,fitresult.D];
        fun = @(x)100*Profile_Error_recurssive(x,I_REF(:,1:20),T_syn,F_DBS_); % assigning the errro function
        func= @(x)fine_tune_error(fun,x,x_std,.01);
        options = optimset('MaxFunEvals',MaxIterfmin,'Display','off');
        [x,fval]=fminsearchbnd(func,x_std,lb,ub,options);
    end
    [fitresult, gof] = gradient_fit_normalized(F_DBS_, I_inf,x0,T_syn, ub ,lb,800,'Normal');

%     options =  optimoptions('simulannealbnd','InitialTemperature',40,'TemperatureFcn',@temperaturefast)
%     [x,fval] = simulannealbnd(fun,x_std,lb,ub, options);
    
%     [x,fval] = bads(fun,x_std,lb,ub,lb,ub);

    f_std(k)=fitresult.f;
    F_std(k)=fitresult.F;
    D_std(k)=fitresult.D;
    U_std(k)=fitresult.U;
    
    f_dual(k)=x(1);
    U_dual(k)=x(2);
    F_dual(k)=x(3);
    D_dual(k)=x(4);
    
    fun = @(x)100*Profile_Error_recurssive(x,I_REF(:,1:100),T_syn,F_DBS_); % assigning the errro function
%     [x,fval] = bads(fun,x0,lb,ub,lb,ub);
    options = optimset('MaxFunEvals',MaxIter_total*MaxIterfmin/2);
    [x,fval]=fminsearchbnd(fun,x0,lb,ub,options);
    f_mse(k)=x(1);
    U_mse(k)=x(2);
    F_mse(k)=x(3);
    D_mse(k)=x(4);
       
end

%%

figure,plot3(f_mse,D_mse,F_mse,'.r');xlabel('f');ylabel('D');zlabel('F');
hold on;plot3(f_std,D_std,F_std,'.b');xlabel('f');ylabel('D');zlabel('F');
hold on;plot3(f_dual,D_dual,F_dual,'.g');xlabel('f');ylabel('D');zlabel('F');


%% parameters evolution
% figure
% for i=1:length(E_global)-3
%     figure(10)
%     hold off
%     plot3(D_global(i:i+1),F_global(i:i+1),E_global(i:i+1),'.-','LineWidth',2,'Color',[.7 .7 1])
%     hold on
%     plot3(D_global(i+1:i+2),F_global(i+1:i+2),E_global(i+1:i+2),'.-','LineWidth',2,'Color',[.5 .5 1])
%     plot3(D_global(i+2:i+3),F_global(i+2:i+3),E_global(i+2:i+3),'.-','LineWidth',2,'Color',[.3 .3 1])
%     axis([0 1000 0 1000 0 12])
%     title('Parameters evolution')
%     pause(.1)
%     
%     
% end
% D_mse=exp(D_mse);
% D_std=exp(D_std);
% D_dual=exp(D_dual);
% 
% F_mse=exp(F_mse);
% F_std=exp(F_std);
% F_dual=exp(F_dual);
% 
% f_mse=exp(f_mse);
% f_std=exp(f_std);
% f_dual=exp(f_dual);
% 
% U_mse=exp(U_mse);
% U_dual=exp(U_dual);

%%
std_color=[0.4 0.2 1];
mse_color=[.3 .8 .4];
dual_color=[1 .4 .4];
figure
subplot(2,2,3)
hold on
x_values = linspace(min([D_mse,D_std,D_dual])*.9,max([D_mse,D_std,D_dual])*1.1,1000);

pd = fitdist(D_std','Kernel','Kernel','normal');
y = pdf(pd,x_values);
y_std=y./max(y);
 
pd = fitdist(D_dual','Kernel','Kernel','normal');
y = pdf(pd,x_values);
y_dual=y./max(y);

pd = fitdist(D_mse','Kernel','Kernel','normal');
y = pdf(pd,x_values);
y_mse=y./max(y);

area(x_values,y_mse,'FaceColor',mse_color,'EdgeColor',mse_color,'FaceAlpha',0.5)
area(x_values,y_std,'FaceColor',std_color,'EdgeColor',std_color,'FaceAlpha',0.5)
area(x_values,y_dual,'FaceColor',dual_color,'EdgeColor',dual_color,'FaceAlpha',0.8)
plot((D_true)*[1 1],[0 1],'Color',[0,0,0],'LineWidth',1.5)
title('D')
xlim([0.2 .3])
% legend( 'MSE','Steady state','Dual','CORRECT','Location','northwest')


% figure
s=subplot(2,2,4)
hold on
x_values = linspace(min([F_mse,F_std,F_dual])*.9,max([F_mse,F_std,F_dual])*1.1,1000);

pd = fitdist(F_std','Kernel','Kernel','normal');
y = pdf(pd,x_values);
y_std=y./max(y);

pd = fitdist(F_dual','Kernel','Kernel','normal');
y = pdf(pd,x_values);
y_dual=y./max(y);

pd = fitdist(F_mse','Kernel','Kernel','normal');
y = pdf(pd,x_values);
y_mse=y./max(y);

area(x_values,y_mse,'FaceColor',mse_color,'EdgeColor',mse_color,'FaceAlpha',0.5)
area(x_values,y_std,'FaceColor',std_color,'EdgeColor',std_color,'FaceAlpha',0.5)
area(x_values,y_dual,'FaceColor',dual_color,'EdgeColor',dual_color,'FaceAlpha',0.8)
plot((F_true)*[1 1],[0 1],'Color',[0,0,0],'LineWidth',1.5)
title('F')
xlim([0 1])
set(s,'YTickLabel','')
% figure
subplot(2,2,1)
hold on
x_values = linspace(min([f_mse,f_std,f_dual])*.9,max([f_mse,f_std,f_dual])*1.1,1000);

pd = fitdist(f_std','Kernel','Kernel','normal');
y = pdf(pd,x_values);
y_std=y./max(y);

pd = fitdist(f_dual','Kernel','Kernel','normal');
y = pdf(pd,x_values);
y_dual=y./max(y);

pd = fitdist(f_mse','Kernel','Kernel','normal');
y = pdf(pd,x_values);
y_mse=y./max(y);

area(x_values,y_mse,'FaceColor',mse_color,'EdgeColor',mse_color,'FaceAlpha',0.5)
area(x_values,y_std,'FaceColor',std_color,'EdgeColor',std_color,'FaceAlpha',0.5)
area(x_values,y_dual,'FaceColor',dual_color,'EdgeColor',dual_color,'FaceAlpha',0.8)

plot((f_true)*[1 1],[0 1],'Color',[0,0,0],'LineWidth',1.5)
% legend('Steady state','MSE','Dual','CORRECT','Location','northwest')
title('f')
xlim([0 .4])

s=subplot(2,2,2)
hold on
x_values = linspace(min([U_std,U_mse,U_dual])*.9,max([U_std,U_mse,U_dual])*1.1,1000);

pd = fitdist(U_dual','Kernel','Kernel','normal','Width',.005);
y = pdf(pd,x_values);
y_dual=y./max(y);

pd = fitdist(U_mse','Kernel','Kernel','normal');
y = pdf(pd,x_values);
y_mse=y./max(y);

pd = fitdist(U_std','Kernel','Kernel','normal');
y = pdf(pd,x_values);
y_std=y./max(y);

area(x_values,y_mse,'FaceColor',mse_color,'EdgeColor',mse_color,'FaceAlpha',0.5)
area(x_values,y_dual,'FaceColor',dual_color,'EdgeColor',dual_color,'FaceAlpha',0.8)
area(x_values,y_std,'FaceColor',std_color,'EdgeColor',std_color,'FaceAlpha',0.5)
plot((U_true)*[1 1],[0 1],'Color',[0,0,0],'LineWidth',1.5)
xlim([0.1 .6])
legend('LMSE','Dual','Steady state','CORRECT','Location','northeast')
% legend('Steady state','MSE','Dual','CORRECT','Location','northwest')
title('U')
set(s,'YTickLabel','','XTick',[.1:.1:.6])

%%
figure(1); 
for k=1:length(F_DBS_)
   subplot(length(F_DBS_),1,k); hold on
   I_estim=DBS_profile_neurotransmitters((f_std(end)),(x0(2)),(F_std(end)),(D_std(end)),T_syn,F_DBS_(k),pulse_num);
   p(2)=plot(I_estim,'--','Color',std_color,'LineWidth',1);
   I_estim=DBS_profile_neurotransmitters((f_dual(end)),(U_dual(end)),(F_dual(end)),(D_dual(end)),T_syn,F_DBS_(k),pulse_num);
   p(3)=plot(I_estim,'--','Color',dual_color,'LineWidth',1);
   I_estim=DBS_profile_neurotransmitters((f_mse(end)),(U_mse(end)),(F_mse(end)),(D_mse(end)),T_syn,F_DBS_(k),pulse_num);
   p(4)=plot(I_estim,'--','Color',mse_color,'LineWidth',1);
   axis([[0.8 10 0 .8]]);
end
% legend(p,{'Synthetic','Steady-state','Dual','LMSE'})


% %%
% figure('Position',[100 100 900 400])
% F_DBS_=[5, 10 , 20 ,30 ,50, 100, 130 , 200];
% pulse_num=50;
% for k=[2,3,4,7,9]
%     f=f_std(k);
%     U=U_std(k);
%     F=F_std(k);
%     D=D_std(k);
%     for j=1:8
%         F_DBS=F_DBS_(j);
%         s=subplot(2,4,j);title(['F_{DBS}= ',num2str(F_DBS),'Hz'])
%         plot(DBS_profile(f,U,F,D,F_DBS,pulse_num));
%         xlim([0 50])
%         ylim([0 .6])
%         hold on
%         if j>4; xlabel('stimulation number');set(s,'XTick',[0:10:50]); else; set(s,'XTick',''); end
%         if j==1 || j==5; ylabel('EPSC');set(s,'YTick',[0:.2:.6]); else; set(s,'YTick',''); end
%     end
% end

        
        