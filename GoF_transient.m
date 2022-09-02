clear
close all
f_true=[0.05,   0.05,   0.3,    0.15,   0.11]; 
U_true=[0.7,    0.5,    0.25,   0.15,   0.1];
F_true=[20,     50,     200,    500,    1000];
D_true=[1700,   500,    200,    50,     20];
% figure; 
TYPE={'SuperDepression','Depression','Psudo','Facilitation','SuperFacilitation'}
for j=1:length(TYPE)
    x=csvread(['Steady_state_estimation_',TYPE{j},'_syn.csv']);
    F_DBS_=[1,2,5,10,20,30,50,100,200];
    for i=1:100
        f=x(1,i);
        U=x(2,i);
        F=x(3,i);
        D=x(4,i);
        I_trans(i,:)=DBS_profile(f,U,F,D,50,50);
    end
    switch j
        case 1
            subplot(3,4,1:2)
        case 2
            subplot(3,4,3:4)
        case 3
            subplot(3,4,6:7)
        case 4
            subplot(3,4,9:10)
        case 5
            subplot(3,4,11:12)
    end
    
    p1=plot(I_trans','Color',[0.7,.7,1]); 
    hold on; 
    p2=plot(mean(I_trans),'Color',[0 0 1],'LineWidth',2);
    p3=plot(DBS_profile(f_true(j),U_true(j),F_true(j),D_true(j),50,50),'Color',[0,.7,0],'LineWidth',2)

        
    if j==2;     
        h1=plot(NaN,NaN,'-','Color',[0.7,.7,1])
        
        legend([h1,p2, p3],{'estimation examples','mean of estimations','true'}); 
    end
    

        
        
    title(TYPE(j))
    ylabel('ESPC')
    xlabel('Stimulation Number')
    csvwrite(['Transient_',TYPE{j},'_syn.csv'],[1:50;I_trans]);

end