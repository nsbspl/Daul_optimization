clear 

f=.15;
U=.4;
F=50;
D=750;
syn=.003;
puls_num=200;
figure
F_DBS_=[5, 10 , 20 ,30 ,50, 100, 130 , 200];
for i=1:8
    F_DBS=F_DBS_(i);
    subplot(2,4,i); %plot(infinity_current(f,U,F,D,puls_num)*ones(1,puls_num));
    hold on
    F =1498/1000  ;
    D =49.28/1000  ;
    U =2.544e-05  ;
    f =0.01502  ;
%     plot(DBS_profile_neurotransmitters(f,U,F,D,syn,F_DBS,puls_num))

    D = 48.55/1000;  
    F = 7850/1000  ;
    U = 0.5909 ; 
    f = 0.008307;  
    plot(DBS_profile_neurotransmitters(f,U,F,D,syn,F_DBS,puls_num))

    D = 49.79/1000  ;
    F = 3153/1000  ;
    U = 0.3376 ;
    f = 0.05021 ; 
    plot(DBS_profile_neurotransmitters(f,U,F,D,syn,F_DBS,puls_num))

    D = 50.98/1000 ;
    F = 192.8/1000 ;
    U = 0.4396 ;
    f = 0.3261 ;
    plot(DBS_profile_neurotransmitters(f,U,F,D,syn,F_DBS,puls_num))
    title(['F_{DBS}=',num2str(F_DBS),'Hz'])
end