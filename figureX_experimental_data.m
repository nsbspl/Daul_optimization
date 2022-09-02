clear
clc
close all 
addpath experimental_data

ch=7;
%%

[D si]=abfload('SD_GA_10Hz_23.11.15_2_ch3.abf');
[h w d]=size(D);
x=reshape(D,[h d]);
% figure; 
% plot(mean(x'))
% xlim([4e4,6.3e4])
% ylim([-100 500])
figure
title('10Hz-ch3')
for j=1:10
    clear EPSC_10
    Postsynaptic_current=x(4e4:6.5e4,j);
    [vals, locs]=findpeaks(Postsynaptic_current,'MinPeakHeight',250,'MinPeakDistance',900);
%     figure; plot(Postsynaptic_current); hold on; plot(locs,vals,'.','MarkerSize',20)
    
    for i=1:length(locs)
        EPSC_10(:,i)=Postsynaptic_current(locs(i):locs(i)+500);
    end
%     EPSC(:,length(locs))=Postsynaptic_current(locs(i+1):locs(i+1)+1000);

    EPSC_10=EPSC_10(25:400,:);
    
%     figure
%     plot(y)
    
%     hold on
%     plot(max(EPSC_10),'k')
    [peak_EPSC_10(:,j),peak_locs]=max(EPSC_10);
    figure('Position',[100 100 900 400]); 
    subplot(2,1,1); plot(Postsynaptic_current); hold on; plot(locs,vals,'.','MarkerSize',20)
    plot((locs+[25:400]-1)',EPSC_10,'r','LineWidth',1)
    plot(locs+peak_locs'+25-2, peak_EPSC_10(:,j),'.k','MarkerSize',10)
    ylim([-10 500])
    xlim([1000 1e4])
    
    subplot(2,1,2); plot(Postsynaptic_current); hold on; plot(locs,vals,'.','MarkerSize',20)
    plot((locs+[25:400]-1)',EPSC_10,'r','LineWidth',1)
    plot(locs+peak_locs'+25-2, peak_EPSC_10(:,j),'.k','MarkerSize',10)
    ylim([-10 500])
    xlim([1.1e4 2e4])
end
figure;
plot(mean(peak_EPSC_10'),'r','LineWidth',2)
plot(mean(peak_EPSC_10')-std(peak_EPSC_10'),'--r','LineWidth',1)
plot(mean(peak_EPSC_10')+std(peak_EPSC_10'),'--r','LineWidth',1)
xlim([1 10])


%%
if ch==7
    [D si]=abfload('SD_GA_10Hz_23.11.15_2_ch7.abf');
    [h w d]=size(D);
    x=reshape(D,[h d]);
    % figure; 
    % plot(mean(x'))
    % xlim([4e4,6.3e4])
    % ylim([-100 500])
    figure
    title('10Hz-ch7')
    for j=1:10
        clear EPSC_10
        Postsynaptic_current=x(4e4:6.5e4,j);
        [vals, locs]=findpeaks(Postsynaptic_current,'MinPeakHeight',250,'MinPeakDistance',900)
%         figure; plot(Postsynaptic_current); hold on; plot(locs,vals,'.','MarkerSize',20)
        for i=1:length(locs)
            EPSC_10(:,i)=Postsynaptic_current(locs(i):locs(i)+500);
        end
    %     EPSC(:,length(locs))=Postsynaptic_current(locs(i+1):locs(i+1)+1000);

        EPSC_10=EPSC_10(5:400,:);
    %     figure
    %     plot(y)

        hold on
        plot(max(EPSC_10),'k')
        peak_EPSC_10(:,j)=max(EPSC_10);
    end
    plot(mean(peak_EPSC_10'),'r','LineWidth',2)
    plot(mean(peak_EPSC_10')-std(peak_EPSC_10'),'--r','LineWidth',1)
    plot(mean(peak_EPSC_10')+std(peak_EPSC_10'),'--r','LineWidth',1)
    xlim([1 10])
end

%%
[D si]=abfload('SD_GA_20Hz_23.11.15_2_ch3.abf');
[h w d]=size(D);
x=reshape(D,[h d]);
% figure; 
% plot(mean(x'))
% xlim([4e4,6.3e4])
% ylim([-100 500])
figure
title('20Hz-ch3')
for j=1:10
    clear EPSC_20
    Postsynaptic_current=x(4e4:6.5e4,j);
    [vals, locs]=findpeaks(Postsynaptic_current,'MinPeakHeight',250,'MinPeakDistance',900)
%     figure; plot(Postsynaptic_current); hold on; plot(locs,vals,'.','MarkerSize',20)
    for i=1:length(locs)
        EPSC_20(:,i)=Postsynaptic_current(locs(i):locs(i)+500);
    end
%     EPSC(:,length(locs))=Postsynaptic_current(locs(i+1):locs(i+1)+1000);

    EPSC_20=EPSC_20(25:400,:);
%     figure
%     plot(y)
    
    hold on
    plot(max(EPSC_20),'k')
    peak_EPSC_20(:,j)=max(EPSC_20);
end
plot(mean(peak_EPSC_20'),'r','LineWidth',2)
plot(mean(peak_EPSC_20')-std(peak_EPSC_20'),'--r','LineWidth',1)
plot(mean(peak_EPSC_20')+std(peak_EPSC_20'),'--r','LineWidth',1)
xlim([1 20])
%%
if ch==7
    [D si]=abfload('SD_GA_20Hz_23.11.15_2_ch7.abf');
    [h w d]=size(D);
    x=reshape(D,[h d]);
    % figure; 
    % plot(mean(x'))
    % xlim([4e4,6.3e4])
    % ylim([-100 500])
    figure
    title('20Hz-ch7')
    for j=1:10
        clear EPSC_20
        Postsynaptic_current=x(4e4:6.5e4,j);
        [vals, locs]=findpeaks(Postsynaptic_current,'MinPeakHeight',250,'MinPeakDistance',900)
    %     figure; plot(Postsynaptic_current); hold on; plot(locs,vals,'.','MarkerSize',20)
        for i=1:length(locs)
            EPSC_20(:,i)=Postsynaptic_current(locs(i):locs(i)+500);
        end
    %     EPSC(:,length(locs))=Postsynaptic_current(locs(i+1):locs(i+1)+1000);

        EPSC_20=EPSC_20(25:400,:);
    %     figure
    %     plot(y)

        hold on
        plot(max(EPSC_20),'k')
        peak_EPSC_20(:,j)=max(EPSC_20);
    end
    plot(mean(peak_EPSC_20'),'r','LineWidth',2)
    plot(mean(peak_EPSC_20')-std(peak_EPSC_20'),'--r','LineWidth',1)
    plot(mean(peak_EPSC_20')+std(peak_EPSC_20'),'--r','LineWidth',1)
    xlim([1 20])
end
%%

[D si]=abfload('SD_GA_130Hz_23.11.15_2_ch3.abf');
[h w d]=size(D);
x=reshape(D,[h d]);
% figure; 
% plot(mean(x'))
% xlim([4e4,6.3e4])
% ylim([-100 500])
figure
title('130Hz-ch3')
for j=1:10
    clear EPSC_130
    Postsynaptic_current=x(4e4:6.5e4,j);
    [vals, locs]=findpeaks(Postsynaptic_current,'MinPeakHeight',500,'MinPeakDistance',150)
%     figure; plot(Postsynaptic_current); hold on; plot(locs,vals,'.','MarkerSize',20)
    for i=1:length(locs)
        EPSC_130(:,i)=Postsynaptic_current(locs(i):locs(i)+150);
    end
%     EPSC(:,length(locs))=Postsynaptic_current(locs(i+1):locs(i+1)+1000);

    EPSC_130=EPSC_130(20:150,:);
%     figure
%     plot(y)
    
    hold on
    plot(max(EPSC_130),'k','LineWidth',.5)
    peak_EPSC_130(:,j)=max(EPSC_130);
end
plot(mean(peak_EPSC_130'),'r','LineWidth',2)
plot(mean(peak_EPSC_130')-std(peak_EPSC_130'),'--r','LineWidth',1)
plot(mean(peak_EPSC_130')+std(peak_EPSC_130'),'--r','LineWidth',1)
% xlim([1 20])
%%
if ch==7
    [D si]=abfload('SD_GA_130Hz_23.11.15_2_ch7.abf');
    [h w d]=size(D);
    x=reshape(D,[h d]);
    % figure; 
    % plot(mean(x'))
    % xlim([4e4,6.3e4])
    % ylim([-100 500])
    figure
    title('130Hz-ch7')
    for j=1:10
        clear EPSC_130
        Postsynaptic_current=x(4e4:6.5e4,j);
        [vals, locs]=findpeaks(Postsynaptic_current,'MinPeakHeight',300,'MinPeakDistance',150)
    %     figure; plot(Postsynaptic_current); hold on; plot(locs,vals,'.','MarkerSize',20)
        for i=1:length(locs)
            EPSC_130(:,i)=Postsynaptic_current(locs(i):locs(i)+150);
        end
    %     EPSC(:,length(locs))=Postsynaptic_current(locs(i+1):locs(i+1)+1000);

        EPSC_130=EPSC_130(20:150,:);
    %     figure
    %     plot(y)

        hold on
        plot(max(EPSC_130),'k','LineWidth',.5)
        peak_EPSC_130(:,j)=max(EPSC_130);
    end
    plot(mean(peak_EPSC_130'),'r','LineWidth',2)
    plot(mean(peak_EPSC_130')-std(peak_EPSC_130'),'--r','LineWidth',1)
    plot(mean(peak_EPSC_130')+std(peak_EPSC_130'),'--r','LineWidth',1)
end

%%
% close all
steady_state10=mean(mean(peak_EPSC_10(08:end,:)))/90;
steady_state20=mean(mean(peak_EPSC_20(15:end,:)))/90;
steady_state130=mean(mean(peak_EPSC_130(100:end,:)))/90;
F_DBS_=[10, 20 , 130];
I_inf=[steady_state10,steady_state20,steady_state130];
figure; plot(F_DBS_,I_inf)

I_REF{1}=mean(peak_EPSC_10(1:4))/90;
I_REF{2}=mean(peak_EPSC_20(1:5))/90;
I_REF{3}=mean(peak_EPSC_130(1:10))/90;

lb=[.001,.01,.05];
ub=[.1,.7,3];
f20=figure(20);
set(f20,'Position',[20 200 560 420])
f21=figure(21);
set(f21,'Position',[600 200 560 420])
for i=1:100
    x0=rand(1,3).*(ub-lb)+lb
    
    [fitresult, gof] = gradient_fit_3_freq(F_DBS_, I_inf,x0, ub ,lb);
    f_std(i)=fitresult.f;
    F_std(i)=fitresult.F;
    D_std(i)=fitresult.D;
    figure(20)
    subplot(3,1,1);plot(DBS_profile_neurotransmitters(f_std(i),0,F_std(i),D_std(i),12,10,10)/f_std(i),'k'); hold on;
    subplot(3,1,2);plot(DBS_profile_neurotransmitters(f_std(i),0,F_std(i),D_std(i),12,20,20)/f_std(i),'k');hold on;
    subplot(3,1,3);plot(DBS_profile_neurotransmitters(f_std(i),0,F_std(i),D_std(i),12,130,130)/f_std(i),'k');hold on;
    
    x_std=[f_std(i),F_std(i),D_std(i)];

    fun = @(x)100*Profile_Error_3_freq(x,I_REF,F_DBS_); % assigning the errro function
    func= @(x)fine_tune_error(fun,x,x_std,.0);
    
    options = optimset('MaxFunEvals',100);
    [x,fval]=fminsearchbnd(func,x_std,lb,ub,options);
    
    f_dual(i)=x(1);
    F_dual(i)=x(2);
    D_dual(i)=x(3);
    figure(21)
    subplot(3,1,1);plot(DBS_profile_neurotransmitters(f_dual(i),0,F_dual(i),D_dual(i),12,10,10)/f_dual(i),'k'); hold on;
    subplot(3,1,2);plot(DBS_profile_neurotransmitters(f_dual(i),0,F_dual(i),D_dual(i),12,20,20)/f_dual(i),'k');hold on;
    subplot(3,1,3);plot(DBS_profile_neurotransmitters(f_dual(i),0,F_dual(i),D_dual(i),12,130,130)/f_dual(i),'k');hold on;
    
    x0=[f_dual(i),F_dual(i),D_dual(i)];
    [fitresult, gof] = gradient_fit_3_freq(F_DBS_, I_inf,x0, ub ,lb);
    f_std(i)=fitresult.f;
    F_std(i)=fitresult.F;
    D_std(i)=fitresult.D;
    figure(20)
    subplot(3,1,1);plot(DBS_profile_neurotransmitters(f_std(i),0,F_std(i),D_std(i),12,10,10)/f_std(i),'k'); hold on;
    subplot(3,1,2);plot(DBS_profile_neurotransmitters(f_std(i),0,F_std(i),D_std(i),12,20,20)/f_std(i),'k');hold on;
    subplot(3,1,3);plot(DBS_profile_neurotransmitters(f_std(i),0,F_std(i),D_std(i),12,130,130)/f_std(i),'k');hold on;
    
    x_std=[f_std(i),F_std(i),D_std(i)];

    fun = @(x)100*Profile_Error_3_freq(x,I_REF,F_DBS_); % assigning the errro function
    func= @(x)fine_tune_error(fun,x,x_std,.0);
    
    [x,fval]=fminsearchbnd(func,x_std,lb,ub,options);
    
    f_dual(i)=x(1);
    F_dual(i)=x(2);
    D_dual(i)=x(3);
    figure(21)
    subplot(3,1,1);plot(DBS_profile_neurotransmitters(f_dual(i),0,F_dual(i),D_dual(i),12,10,10)/f_dual(i),'k'); hold on;
    subplot(3,1,2);plot(DBS_profile_neurotransmitters(f_dual(i),0,F_dual(i),D_dual(i),12,20,20)/f_dual(i),'k');hold on;
    subplot(3,1,3);plot(DBS_profile_neurotransmitters(f_dual(i),0,F_dual(i),D_dual(i),12,130,130)/f_dual(i),'k');hold on;
end

%%
figure(20);title('Steady-state')
subplot(3,1,1); plot(mean(peak_EPSC_10')/400,'r','LineWidth',2)
subplot(3,1,2); plot(mean(peak_EPSC_20')/400,'r','LineWidth',2)
subplot(3,1,3); plot(mean(peak_EPSC_130')/400,'r','LineWidth',2)

figure(21);title('Dual')
subplot(3,1,1); plot(mean(peak_EPSC_10')/400,'r','LineWidth',2)
subplot(3,1,2); plot(mean(peak_EPSC_20')/400,'r','LineWidth',2)
subplot(3,1,3); plot(mean(peak_EPSC_130')/400,'r','LineWidth',2)

figure(31); histogram(f_std,'BinWidth',.001,'FaceColor','b'); title('f_{std}')
figure(32); histogram(F_std,'BinWidth',.001,'FaceColor','b'); title('F_{std}')
figure(33); histogram(D_std,'BinWidth',.001,'FaceColor','b'); title('D_{std}')

figure(31); hold on; histogram(f_dual,'BinWidth',.001,'FaceColor','r'); title('f_{Dual}')
figure(32); hold on; histogram(F_dual,'BinWidth',.001,'FaceColor','r'); title('F_{Dual}')
figure(33); hold on; histogram(D_dual,'BinWidth',.001,'FaceColor','r'); title('D_{Dual}')