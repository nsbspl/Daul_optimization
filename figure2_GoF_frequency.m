clear
close all
f_true=[0.05,   0.05,   0.3,    0.15,   0.11]; 
U_true=[0.7,    0.5,    0.25,   0.15,   0.1];
F_true=[20,     50,     200,    500,    1000];
D_true=[1700,   500,    200,    50,     20];
f=figure(); 
cmap=hot(12)
Tsyn=1e-6;
TYPE={'Hard Depression','Depression','Depression Facilitation','Facilitation','Hard Facilitation'}
for j=1:length(TYPE)
    s=subplot(1,1,1)
    x=csvread(['Steady_state_estimation_',TYPE{j},'_syn.csv']);
    f_(:,j)=x(1,:);
    U_(:,j)=x(2,:);
    F_(:,j)=x(3,:)/1000;
    D_(:,j)=x(4,:)/1000;
    F_DBS_=[1,2,5,10,20,30,50,100,200];
    for i=1:100
        f=x(1,i);
        U=x(2,i);
        F=x(3,i);
        D=x(4,i);
        for f_dbs=1:200
            I_inf(i,f_dbs)=infinity_current_Tsyn(f,U,F,D,Tsyn,f_dbs);
        end
    end
    color=cmap(j+2,:);
    
    
    p1=plot(I_inf(1,:),'--','Color',color); 
    hold on; 
%     p2=plot(mean(I_inf),'Color',[0 0 1],'LineWidth',2);
    I_inf_true=[];    
    for f_dbs=F_DBS_
        I_inf_true(end+1)=infinity_current_Tsyn(f_true(j),U_true(j),F_true(j),D_true(j),Tsyn,f_dbs);
    end
    plot(F_DBS_,I_inf_true,'.','Color',color,'MarkerSize',15)
    p3(j)=plot(nan,'--.','Color',color,'MarkerSize',15)
    
    xlabel('DBS frequency','FontSize',20)
    ylabel('Steady-state EPSC','FontSize',20)
%     title(TYPE(j),'VerticalAlignment','middle')
    
%     switch j
%         case 1
%             s=subplot(1,1,1);%(5,1,j);%(3,3,1);%(3,4,1:2)
%             ylabel('EPSC', 'FontSize',8)
%             set(s,'XTickLabel','','YTick',[0,.4,.8])
%             title('Hard Facilitation','VerticalAlignment','top')
%         case 2
%             s=subplot(1,1,1);%(5,1,j);%(3,3,4);%(3,4,3:4)
%             ylabel('EPSC', 'FontSize',8)
%             set(s,'XTickLabel','','YTick',[0,.4,.8])
%             title(TYPE(j),'VerticalAlignment','top')
%         case 3
%             s=subplot(1,1,1);%(5,1,j);%(3,3,7);%(3,4,6:7)
%             ylabel('EPSC', 'FontSize',8)
% %             xlabel('DBS frequency')
%             set(s,'YTick',[0,.4,.8])
%             set(s,'XTickLabel','','YTick',[0,.4,.8])
%             title('Depression/Faciliation','VerticalAlignment','top')
%         case 4
%             s=subplot(1,1,1);%(5,1,j);%(3,3,8);%(3,4,9:10)
% %             xlabel('DBS frequency')
%             ylabel('EPSC', 'FontSize',8)
%             set(s,'XTickLabel','')
%             set(s,'XTickLabel','','YTick',[0,.4,.8])
%             title(TYPE(j),'VerticalAlignment','top')
%         case 5
%             s=subplot(1,1,1);%(5,1,j);%(3,3,9);%(3,4,11:12)
%             
%             set(s,'YTickLabel','')
%             xlabel('DBS frequency')
%             ylabel('EPSC', 'FontSize',8)
%             title('Hard Facilitation','VerticalAlignment','top')
%     end
    
    set(s,'Box','off','YTick',[0:.2:.8],'XTick',F_DBS_,'XScale','log','FontSize',15)
%     
%     if j==2
%         h1 = plot(NaN,NaN,'-','Color',[0.7,.7,1]);
%         legend([h1, p3],{'estimation samples','true'})
%         
%     end
%     csvwrite(['C:\Users\Ali Reza\JupyterDir\Method paper\Transient_',TYPE{j},'_syn.csv'],[1:50;I_inf]);

end
colormap(cmap(3:7,:))
colorbar('Ticks',[0,1],'TickLabels',{'Dep.','Fac.'},'Position',[.86,.7,.03,.2],'AxisLocation','in')
% h1 = plot(NaN,NaN,'-','Color',[0.7,.7,1]);
% legend([h1,p2, p3],{'estimation samples','mean of estimations','true'})
% GoF_transient;
cmap=hot(12);
figure('Position',[300 100 500 500])
s=subplot(1,1,1)
violin([f_],'xlabel',{'','','','',''},'facecolor',cmap(3:7,:),'facealpha',.9,'edgecolor','','medc','','mc','','TRUE',f_true,'TRUEcolor','k','bw',[.01,.01,.002,.002,.01])
ylim([0 1])
title('f','FontSize',20)
colormap(cmap(3:7,:))
% colorbar('Ticks',[0,1],'TickLabels',{'Dep.','Fac.'},'FontSize',25,'Location','Southoutside','AxisLocation','out')
set(s,'YTick',[0 .5 1],'FontSize',20, 'Position',[0.1 0.2 .8 .7])

figure('Position',[300 100 500 500])
s=subplot(1,1,1)
violin([U_],'xlabel',{'','','','',''},'facecolor',cmap(3:7,:),'facealpha',.9,'edgecolor','','medc','','mc','','TRUE',U_true,'TRUEcolor','k','bw',[.01,.01,.002,.002,.01])
ylim([0 1])
title('U','FontSize',20)
colormap(cmap(3:7,:))
% colorbar('Ticks',[0,1],'TickLabels',{'Dep.','Fac.'},'FontSize',25,'Location','Southoutside','AxisLocation','out')
set(s,'YTick',[0 .5 1],'FontSize',20, 'Position',[0.1 0.2 .8 .7])

figure('Position',[300 100 500 500])
s=subplot(1,1,1)
violin([F_],'xlabel',{'','','','',''},'facecolor',cmap(3:7,:),'facealpha',.9,'edgecolor','','medc','','mc','','TRUE',F_true/1000,'TRUEcolor','k','bw',[.05,.05,.01,.01,.02])
ylim([0 2])
title('F','FontSize',20)
colormap(cmap(3:7,:))
colorbar('Ticks',[0,1],'TickLabels',{'Dep.','Fac.'},'FontSize',25,'Location','Southoutside','AxisLocation','out')
set(s,'YTick',[0,1 2],'FontSize',20, 'Position',[0.1 0.2 .8 .7])

figure('Position',[300 100 500 500])
s=subplot(1,1,1)
violin([D_],'xlabel',{'','','','',''},'facecolor',cmap(3:7,:),'facealpha',.9,'edgecolor','','medc','','mc','','TRUE',D_true/1000,'TRUEcolor','k','bw',[.02,.02,.02,.02,.02])
ylim([0 2])
title('D','FontSize',20)
colormap(cmap(3:7,:))
colorbar('Ticks',[0,1],'TickLabels',{'Dep.','Fac.'},'FontSize',25,'Location','Southoutside','AxisLocation','out')
set(s,'YTick',[0,1, 2],'FontSize',20, 'Position',[0.1 0.2 .8 .7])