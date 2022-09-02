function h1=Evaluation_figure(D_true,D_estimated,config)

% config.k_mean_win=30;
% confidence_smoothenss=60;
% config.confidence_width=3;
D_range=linspace(1*min(D_true),1*max(D_true),2000);
% D_range=[D_range,max(D_true):D_range(2)-D_range(1):max(D_true)+(config.estimator_smoothness-2)*(D_range(2)-D_range(1))];
if config.plot_estimator || config.plot_confidence_interval
    for i=1:2000
        d_std_mean(i)=median(D_estimated(find(abs(D_true-D_range(i))<config.k_mean_win)));
        d_std_std(i)=std(D_estimated(find(abs(D_true-D_range(i))<config.k_mean_win)));
        n(i)=length(D_estimated(find(abs(D_true-D_range(i))<config.k_mean_win)));
    end
    d_std_mean=conv(d_std_mean,ones(1,config.estimator_smoothness)/config.estimator_smoothness,'valid');
    d_std_std=conv(d_std_std,ones(1,config.confidence_smoothness)/config.confidence_smoothness,'valid');

end

% figure
hold on
d_std_mean=[d_std_mean(1)*ones(1,config.estimator_smoothness/2),d_std_mean,d_std_mean(end)*ones(1,config.estimator_smoothness/2-1)]; %(~isnan(d_std_mean));
d_std_std=[d_std_std(1)*ones(1,config.confidence_smoothness/2),d_std_std,d_std_std(end)*ones(1,config.confidence_smoothness/2-1)]; %d_std_std(~isnan(d_std_std));
P=[(d_std_mean+config.confidence_width*d_std_std),flip(d_std_mean-config.confidence_width*d_std_std)];
pgon=polyshape([D_range,flip(D_range)],P);
plot(pgon,'FaceColor',config.color,'Edgecolor',config.color)
if config.plot_point;  plot(D_true,D_estimated,'.','color',config.color); end
if config.plot_estimator; plot(D_range,d_std_mean,'-','color',config.color,'LineWidth',2); end


axis(config.bounderies)
xlabel('Target')
ylabel('Estimation')
