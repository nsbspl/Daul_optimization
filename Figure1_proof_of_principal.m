%% proof of principal of the accuracy of the steady-state analytical solution
clear 
close all 

%% example 1: Pseudo
close all
f=.45;
U=0;
F=.300;
D=.800;
Tsyn=1e-4;
pulse_num=50;

for F_DBS=1:200
    I_infinity_analytical(F_DBS)=infinity_current_Tsyn(f, U, F, D,Tsyn, F_DBS);
    I=DBS_profile(f, U, F, D,0.0001, F_DBS,pulse_num);
    I_infinity_computational(F_DBS)=I(end);

end
F_DBS=1:200;
figure;
plot(F_DBS,I_infinity_computational);
hold on
F_DBS_sparse=[1,5,20,30,50,100,130,200];
plot(F_DBS,I_infinity_analytical);

figure('Position',[100 100 900 300])
plot(F_DBS,I_infinity_analytical,'b','LineWidth',2);
hold on
F_DBS_sparse=[1,5,10,20,30,50,100,130,200];
title('Frequency response')
xlabel('F_{DBS}')
ylabel('Steady-state value')

p=plot(F_DBS_sparse,I_infinity_computational(F_DBS_sparse),'or','MarkerSize',6,'MarkerFaceColor','r');
legend('Analytical formula','100th EPSC')

% for i=F_DBS_sparse
%     figure('position',[100,100,300,200]); 
%     
%     plot(DBS_profile(f,U,F,D,i,pulse_num))
%     hold on
%     plot(ones(1,pulse_num)*infinity_current(f,U,F,D,i))
%     ylim([0 0.4])
%     title(['F_{DBS}=',num2str(i),'Hz'])
%     xlabel('stimulation number')
%     ylabel('EPSC')
% end

figure('Position',[100 100 900 400])
n=0;
for i=F_DBS_sparse(2:end)
    n=n+1;
    s=subplot(2,4,n);
    I=zeros(1,floor(pulse_num*10000/i)+1);
    I(floor(10000*(1:pulse_num)./i))=DBS_profile(f,U,F,D,0,i,pulse_num);
    h=exp(-1*(0:5000)./30);
    I=conv(I,h);
    
    plot((1:length(I))/floor(10000./i),I); hold on
%     plot(DBS_profile(f,U,F,D,i,pulse_num),'--b')
    hold on
%     plot([1:pulse_num;1:pulse_num],[zeros(1,pulse_num);DBS_profile(f,U,F,D,i,pulse_num)],'b')
    plot(DBS_profile(f,U,F,D,0.0001,i,pulse_num),'.b','LineWidth',2)
    
    hold on
    plot(ones(1,pulse_num)*infinity_current_Tsyn(f,U,F,D,Tsyn,i),'--r','LineWidth',1)
    ylim([0 .4])
    xlim([0 30])
    title(['F_{DBS}=',num2str(i),'Hz'])
    if n>4; xlabel('stimulation number');set(s,'XTick',[0,10,20,30]); else; set(s,'XTick',''); end
    if n==1 || n==5; ylabel('EPSC');set(s,'YTick',[0,.4]); else; set(s,'YTick',''); end
end
%% example 2: 
close all

f=.05;
U=0.1;
F=.600;
D=.080;
pulse_num=100;

for F_DBS=1:200
    I_infinity_analytical(F_DBS)=infinity_current_Tsyn(f, U, F, D,Tsyn, F_DBS);
    I=DBS_profile(f, U, F, D,Tsyn, F_DBS,pulse_num);
    I_infinity_computational(F_DBS)=I(end);

end
F_DBS=1:200;
figure;
plot(F_DBS,I_infinity_computational);
hold on
F_DBS_sparse=[1,5,20,30,50,100,130,200];
plot(F_DBS,I_infinity_analytical);

figure('Position',[100 100 900 300])
s=subplot(1,1,1);
plot(F_DBS,I_infinity_analytical,'b','LineWidth',2);
hold on
F_DBS_sparse=[1,5,10,20,30,50,100,130,200];
title('Frequency response')
xlabel('F_{DBS}')
ylabel('Steady-state value')

p=plot(F_DBS_sparse,I_infinity_computational(F_DBS_sparse),'or','MarkerSize',6,'MarkerFaceColor','r');
legend('Analytical formula','100th EPSC')
Ticks=[1,5:5:200];
LABELS={};
for i=1:length(Ticks)
    if sum(Ticks(i)==F_DBS_sparse)
        LABELS{i}=num2str(Ticks(i));
    else
        LABELS{i}=''
    end
end
set(s,'XTick',Ticks,'XTickLabel',LABELS,'BOX','off','XScale','log')
% for i=F_DBS_sparse
%     figure('position',[100,100,300,200]); 
%     
%     plot(DBS_profile(f,U,F,D,i,pulse_num))
%     hold on
%     plot(ones(1,pulse_num)*infinity_current_Tsyn(f,U,F,D,i))
%     ylim([0 0.4])
%     title(['F_{DBS}=',num2str(i),'Hz'])
%     xlabel('stimulation number')
%     ylabel('EPSC')
% end

figure('Position',[100 100 900 400])
n=0;
for i=F_DBS_sparse(2:end)
    n=n+1;
    s=subplot(2,4,n);
    I=zeros(1,floor(pulse_num*10000/i)+1);
    I(floor(10000*(1:pulse_num)./i))=DBS_profile(f,U,F,D,Tsyn,i,pulse_num);
    h=exp(-1*(0:5000)./30);
    I=conv(I,h);
    p(1)=plot(0:pulse_num-1,ones(1,pulse_num)*infinity_current_Tsyn(f,U,F,D,Tsyn,i),'--r','LineWidth',1); hold on
    p(2)=plot((1:length(I))/floor(10000./1),I,'Color','k'); hold on
%     plot(DBS_profile(f,U,F,D,i,pulse_num),'--b')
    hold on
%     plot([1:pulse_num;1:pulse_num],[zeros(1,pulse_num);DBS_profile(f,U,F,D,i,pulse_num)],'b')
    p(3)=plot((1:pulse_num)/i,DBS_profile(f,U,F,D,Tsyn,i,pulse_num),'.b','LineWidth',2);
    
    hold on
    
    ylim([0 .4])
    xlim([0 20/i])
    title(['F_{DBS}=',num2str(i),'Hz'],'VerticalAlignment','top')
%     if n==4; legend(p,{'Analytical formula','TM','DTM'}, 'Location','northeastoutside'); end
    if n>4; xlabel('Time(sec)'); end
    if n==1 || n==5; ylabel('EPSC');set(s,'YTick',[0,.2,.4],'BOX','off'); else; set(s,'YTick','','BOX','off','YColor','w'); end
end

%% example 3: Depression

f=.95;
U=0.;
F=.010;
D=.080;
pulse_num=50;

for F_DBS=1:200
    I_infinity_analytical(F_DBS)=infinity_current_Tsyn(f, U, F, D,Tsyn, F_DBS);
    I=DBS_profile(f, U, F, D,Tsyn, F_DBS,pulse_num);
    I_infinity_computational(F_DBS)=I(end);

end
F_DBS=1:200;
figure;
plot(F_DBS,I_infinity_computational);
hold on
F_DBS_sparse=[1,5,20,30,50,100,130,200];
plot(F_DBS,I_infinity_analytical);

figure('Position',[100 100 900 300])
plot(F_DBS,I_infinity_analytical,'b','LineWidth',2);
hold on
F_DBS_sparse=[1,5,10,20,30,50,100,130,200];
title('Frequency response')
xlabel('F_{DBS}')
ylabel('Steady-state value')

p=plot(F_DBS_sparse,I_infinity_computational(F_DBS_sparse),'or','MarkerSize',6,'MarkerFaceColor','r');
legend('Analytical formula','100th EPSC')

% for i=F_DBS_sparse
%     figure('position',[100,100,300,200]); 
%     
%     plot(DBS_profile(f,U,F,D,i,pulse_num))
%     hold on
%     plot(ones(1,pulse_num)*infinity_current_Tsyn(f,U,F,D,i))
%     ylim([0 0.4])
%     title(['F_{DBS}=',num2str(i),'Hz'])
%     xlabel('stimulation number')
%     ylabel('EPSC')
% end

figure('Position',[100 100 900 400])
n=0;
for i=F_DBS_sparse(2:end)
    n=n+1;
    s=subplot(2,4,n);
    I=zeros(1,floor(pulse_num*10000/i)+1);
    I(floor(10000*(1:pulse_num)./i))=DBS_profile(f,U,F,D,Tsyn,i,pulse_num);
    h=exp(-1*(0:5000)./30);
    I=conv(I,h);
    
    plot((1:length(I))/floor(10000./i),I); hold on
%     plot(DBS_profile(f,U,F,D,i,pulse_num),'--b')
    hold on
%     plot([1:pulse_num;1:pulse_num],[zeros(1,pulse_num);DBS_profile(f,U,F,D,i,pulse_num)],'b')
    plot(DBS_profile(f,U,F,D,Tsyn,i,pulse_num),'.b','LineWidth',2)
    
    hold on
    plot(ones(1,pulse_num)*infinity_current_Tsyn(f,U,F,D,Tsyn,i),'--r','LineWidth',1)
    ylim([0 1.2])
    xlim([0 30])
    title(['F_{DBS}=',num2str(i),'Hz'])
    if n>4; xlabel('stimulation number');set(s,'XTick',[0,10,20,30]); else; set(s,'XTick',''); end
    if n==1 || n==5; ylabel('EPSC');set(s,'YTick',[0,.4,.8,1.2]); else; set(s,'YTick',''); end
end

