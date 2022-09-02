function h1=Evaluation_figure_normalized(D_true,D_estimated,k_mean_win,smoothenss,confidence_width)
% Evaluation_figure(True,Estimation,k_mean_win,confidence_smoothenss,confidence_width)
% k_mean_win=30;
% confidence_smoothenss=60;
% confidence_width=3;

for i=1:1000
    d_std_mean(i)=median(D_estimated(find(abs(D_true-i/1000)<k_mean_win)));
    d_std_std(i)=std(D_estimated(find(abs(D_true-i/1000)<k_mean_win)));
    n(i)=length(D_estimated(find(abs(D_true-i/1000)<k_mean_win)));
end

for i=smoothenss:2000-smoothenss
    d_std_mean(i)=mean(d_std_mean(max(1+i-smoothenss):min(i+smoothenss-1)));
end

for i=smoothenss:2000-smoothenss
    d_std_std(i)=mean(d_std_std(max(1+i-smoothenss):min(i+smoothenss-1)));
end

figure 
hold on
h1=area((1:1000)./1000,d_std_mean+confidence_width*d_std_std);
h1.FaceColor = [0 0.25 0.75];
h1.FaceAlpha=.3;
h1.LineWidth=.3
h1.EdgeColor='b'

h2=area((1:1000)./1000,d_std_mean-confidence_width*d_std_std);
h2.FaceColor = 'white';
h1.LineWidth=.3
h1.EdgeColor='b'

plot(D_true,D_estimated,'.','Color',[0 0.25 0.75])


plot(1:2000,d_std_mean,'b-','LineWidth',2)

% axis([0 2000 0 2000])
xlabel('Target')
ylabel('Estimation')
