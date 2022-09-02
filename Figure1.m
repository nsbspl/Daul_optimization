clear
close all 
F_DBS=50;
pulse_num=40;
f=.15;
U=0;
F=.300;
D=.800;
Tsyn=1e-6;
S=DBS_profile(f,U,F,D,Tsyn,F_DBS,pulse_num);
figure(1)
p=plot(S/S(1),'.b','MarkerSize', 15)
hold on
plot(S/S(1),'color',[.5 0.5 1])
% plot([1:pulse_num;1:pulse_num], [S/S(1);zeros(1,40)],'b')
figure(2)
for f_dbs=1:200
    I_inf(f_dbs)=infinity_current(f,U,F,D,Tsyn,f_dbs);
end
plot(I_inf/I_inf(1),'b','lineWidth',2)
hold on
%%
f=.05;
U=0;
F=.6;
D=.080;
S=DBS_profile(f,U,F,D,F_DBS,Tsyn,pulse_num);
figure(1)
plot(S/S(1),'.r','MarkerSize', 15)
plot(S/S(1),'color',[1 0.5 .5])
% plot([1:pulse_num;1:pulse_num], [S/S(1);zeros(1,40)],'r')
figure(2)
for f_dbs=1:200
    I_inf(f_dbs)=infinity_current(f,U,F,D,Tsyn,f_dbs);
end
plot(I_inf/I_inf(1),'r','lineWidth',2)
hold on

%%
f=.95;
U=0.;
F=.010;
D=.080;
S=DBS_profile(f,U,F,D,Tsyn,F_DBS,pulse_num);
figure(1)
plot(S/S(1),'.m','MarkerSize', 15)
plot(S/S(1),'color',[1 0.5 1])
% plot([1:pulse_num;1:pulse_num], [S/S(1);zeros(1,40)],'m')
figure(2)
for f_dbs=1:200
    I_inf(f_dbs)=infinity_current(f,U,F,D,Tsyn,f_dbs);
end
plot(I_inf/I_inf(1),'m','lineWidth',2)
hold on

figure(1)
xlabel('Stimulation number')
ylabel('EPSC')
title('Profile of the postsynaptic response to DBS')

figure(2)
xlabel('DBS frequency')
ylabel('Steady-state EPSC')
title('Frequency response')