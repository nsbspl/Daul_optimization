clear
f_=.01:.01:.25;
U_=.25:.01:.5;
F_=10:10:400;
D_=500:10:800;
volume=1000;
pulse_num=15;
% 
% f=.15;
% U=.4;
% F=50;
% D=750;

f=f_(15)
U=U_(16)
F=F_(5)
D=D_(26)

F_DBS=[5,10,20,30,50,100,150,200];
for i=1:length(F_DBS)
    I_REF(i)=infinity_current(f,U,F,D,F_DBS(i));
    I_REF_trans(i,:)=DBS_profile(f,U,F,D,F_DBS(i),pulse_num);
end

%%
n=0
for i=1:length(f_)
    for j=1:length(U_)
        for k=1:length(F_)
            for l=1:length(D_)
%                 n=n+1/(length(f_)*length(U_)*length(F_)*length(D_))
                E(i,j,k,l)=SteadyStateError(f_(i),U_(j),F_(k),D_(l),F_DBS,I_REF );
                Etrans(i,j,k,l)=Profile_Error([f_(i),U_(j),F_(k),D_(l)],I_REF_trans,F_DBS);
            end
        end
    end
end

%%
% clear
load('ErrorSurfaceData.mat')
[I J K L]=size(E_steadystate);
figure; 
V=reshape(E_steadystate(:,11,:,:),[I K L]);
[X,Y,Z]=meshgrid(F_,f_,D_);

Z2=X+Y;
slice(X,Y,Z,log(V),F,f,[D,700]);
xlabel('F')
ylabel('f')
zlabel('D')
title('Steady-State Error')

hold on
[xsurf,zsurf] = meshgrid(F_,D_);
ysurf=(xsurf+zsurf);
ysurf=.25*ysurf/max(ysurf(:));
ysurf=ysurf/2;
slice(X,Y,Z,log(V),xsurf,ysurf,zsurf);
xlabel('F')
ylabel('f')
zlabel('D')
title('Steady-State Error')

%%

[I J K L]=size(E_transient);
figure;
V=reshape(E_transient(:,16,:,:),[I K L]);
[X,Y,Z]=meshgrid(F_,f_,D_);
slice(X,Y,Z,log(V),F,f,D);

title('Transient Error')