%% Target-Estimation plot for evaluating the accuracy of the methods
addpath 'C:\Users\Ali Reza\OneDrive - UHN\Tsodyke codes\VimNeurons\STP_parameter_inferring_Method1\Dual Optimizations'
if ~exist('D_dual')
    clear
    close all
    load Target_estimation_data.mat
    display('New data has been loaded')
end
std_color=[0.4 0.2 1];
mse_color=[.3 .8 .4];
dual_color=[1 .4 .4];
%% f
config.k_mean_win=0.05;
config.confidence_smoothness=200;
config.estimator_smoothness=20;
config.confidence_width=1;
config.plot_estimator=true;
config.plot_confidence_interval=true;
config.bounderies=[0 1 0 1];
figure('Position',[100 100 400 300])
s=subplot(1,1,1);
config.plot_point=false;
config.color=std_color;
Evaluation_figure(f_true,f_std,config)

config.plot_point=false;
config.color=mse_color;
Evaluation_figure(f_true,f_mse,config)

config.plot_point=false;
config.color=dual_color;
Evaluation_figure(f_true,f_dual,config)

title f
xlabel('')
% set(s,'XTickLabel','')

%% U
if exist('U_dual')
    config.k_mean_win=0.05;
    config.confidence_smoothness=200;
    config.estimator_smoothness=20;
    config.confidence_width=1;
    config.plot_estimator=true;
    config.plot_confidence_interval=true;
    config.bounderies=[0 1 0 1];
    figure('Position',[100 100 400 300])
    s=subplot(1,1,1)
    config.plot_point=false;
    config.color=std_color;
    Evaluation_figure(U_true,U_std,config)

    config.plot_point=false;
    config.color=mse_color;
    Evaluation_figure(U_true,U_mse,config)

    config.plot_point=false;
    config.color=dual_color;
    Evaluation_figure(U_true,U_dual,config)
    title U
    p(1)=area(nan,'FaceColor',std_color,'FaceAlpha',.4);
    p(2)=area(nan,'FaceColor',mse_color,'FaceAlpha',.4);
    p(3)=area(nan,'FaceColor',dual_color,'FaceAlpha',.4);
    legend(p,{'Steady-state','LMSE','Dual'})
    xlabel('')
    ylabel('')
end
% set(s,'XTickLabel','','YTickLabel','')
%% F

config.k_mean_win=50;
config.confidence_smoothness=200;
config.estimator_smoothness=20;
config.confidence_width=1;
config.plot_estimator=true;
config.plot_confidence_interval=true;
config.bounderies=[0 2000 0 2000];
figure('Position',[100 100 400 300])
s=subplot(1,1,1);
config.plot_point=false;
config.color=std_color;
Evaluation_figure(F_true,F_std,config)

config.plot_point=false;
config.color=mse_color;
Evaluation_figure(F_true,F_mse,config)

config.plot_point=false;
config.color=dual_color;
Evaluation_figure(F_true,F_dual,config)
set(s,'YTickLabel',[0:.5:2],'XTickLabel',[0:.5:2])
title F
ylabel('')
%% D

config.k_mean_win=50;
config.confidence_smoothness=200;
config.estimator_smoothness=20;
config.confidence_width=1;
config.plot_estimator=true;
config.plot_confidence_interval=true;
config.bounderies=[0 2000 0 2000];
figure('Position',[100 100 400 300])
s=subplot(1,1,1);
config.plot_point=false;
config.color=std_color;
Evaluation_figure(D_true,D_std,config)

config.plot_point=false;
config.color=mse_color;
Evaluation_figure(D_true,D_mse,config)

config.plot_point=false;
config.color=dual_color;
Evaluation_figure(D_true,D_dual,config)
set(s,'YTickLabel',[0:.5:2],'XTickLabel',[0:.5:2])
title D

    p(1)=area(nan,'FaceColor',std_color,'FaceAlpha',.4);
    p(2)=area(nan,'FaceColor',mse_color,'FaceAlpha',.4);
    p(3)=area(nan,'FaceColor',dual_color,'FaceAlpha',.4);
%     legend(p,{'Steady-state','MSE','Dual'})
% set(s,'XTickLabel','','YTickLabel','')