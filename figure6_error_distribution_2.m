figure

hold on
x_values = linspace(min([D_mse,D_std,D_dual])*.9,max([D_mse,D_std,D_dual])*1.1,1000);

pd = fitdist(D_std','Kernel','Kernel','normal');
y = pdf(pd,x_values);
y_std=y./sum(y);
 
pd = fitdist(D_dual','Kernel','Kernel','normal');
y = pdf(pd,x_values);
y_dual=y./sum(y);

pd = fitdist(D_mse','Kernel','Kernel','normal');
y = pdf(pd,x_values);
y_mse=y./sum(y);

area(x_values,y_mse,'FaceColor',[1 .8 .4],'EdgeColor',[1 .4 .2],'FaceAlpha',0.5)
area(x_values,y_std,'FaceColor',[0.4 0.4 1],'EdgeColor',[.2 .2 1],'FaceAlpha',0.5)
area(x_values,y_dual,'FaceColor',[1 .4 .4],'EdgeColor',[1 .2 .2],'FaceAlpha',0.5)
plot(D_true*[1 1],[0 .01],'Color',[0,.7,0],'LineWidth',1.5)
title('D')
% legend( 'MSE','Steady state','Dual','CORRECT','Location','northwest')