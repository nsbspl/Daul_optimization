%% Target-Estimation plot for evaluating the accuracy of the methods
addpath 'C:\Users\Ali Reza\OneDrive - UHN\Tsodyke codes\VimNeurons\STP_parameter_inferring_Method1\Dual Optimizations'
% clear
% close all
% load Target_estimation_data.mat

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
config.color='g';
Evaluation_figure(f_true,f_std,config)

config.plot_point=false;
config.color='b';
Evaluation_figure(f_true,f_mse,config)

config.plot_point=false;
config.color='r';
Evaluation_figure(f_true,f_dual,config)

title f
xlabel('')
% legend(p,{'Steady-state','MSE','Dual'})
% set(s,'XTickLabel','')

%% U

% config.k_mean_win=0.05;
% config.confidence_smoothness=200;
% config.estimator_smoothness=20;
% config.confidence_width=1;
% config.plot_estimator=true;
% config.plot_confidence_interval=true;
% config.bounderies=[0 1 0 1];
% figure('Position',[100 100 400 300])
% s=subplot(1,1,1)
% config.plot_point=false;
% config.color='g';
% Evaluation_figure(U_true,U_std,config)
% 
% config.plot_point=false;
% config.color='b';
% Evaluation_figure(U_true,U_mse,config)
% 
% config.plot_point=false;
% config.color='r';
% Evaluation_figure(U_true,U_dual,config)
% title U
% p(1)=plot(nan,'g');
% p(2)=plot(nan,'b');
% p(3)=plot(nan,'r');
% legend(p,{'Steady-state','MSE','Dual'})
% xlabel('')
% ylabel('')
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
config.plot_point=false;
config.color='g';
Evaluation_figure(F_true,F_std,config)

config.plot_point=false;
config.color='b';
Evaluation_figure(F_true,F_mse,config)

config.plot_point=false;
config.color='r';
Evaluation_figure(F_true,F_dual,config)
title F
% legend(p,{'Steady-state','MSE','Dual'})
%% D

config.k_mean_win=50;
config.confidence_smoothness=200;
config.estimator_smoothness=20;
config.confidence_width=1;
config.plot_estimator=true;
config.plot_confidence_interval=true;
config.bounderies=[0 2000 0 2000];
figure('Position',[100 100 400 300])
config.plot_point=false;
config.color='g';
Evaluation_figure(D_true,D_std,config)

config.plot_point=false;
config.color='b';
Evaluation_figure(D_true,D_mse,config)

config.plot_point=false;
config.color='r';
Evaluation_figure(D_true,D_dual,config)
title D
ylabel('')
% set(s,'XTickLabel','','YTickLabel','')