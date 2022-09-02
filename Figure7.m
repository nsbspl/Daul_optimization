clear 
close all
f=.25;
U=0.6;
F=580;
D=1000;
Tsyn=1e-6;
pulse_num=50;
EOT=[];
v_EOT=[];
figure;hold on
for F_dbs=1:1:200
    I=DBS_profile_recursive(f,U,F,D,Tsyn,F_dbs,pulse_num);
    plot(I)
    
    [MAX,LOC]=max(I);
    for i=LOC:length(I)
        if abs(I(i)-infinity_current_Tsyn(f,U,F,D,Tsyn,F_dbs))<.05*infinity_current_Tsyn(f,U,F,D,Tsyn,F_dbs)
            EOT(end+1)=i;
            v_EOT(end+1)=I(i);
            plot(i,I(i),'.r','MarkerSize',12)
            break
        end
    end
    
    
    
end

plot(EOT,v_EOT,'k','LineWidth',2)
figure; plot(EOT)