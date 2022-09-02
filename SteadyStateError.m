function Error=SteadyStateError(f,U,F,D,F_DBS,I_REF)

for i=1:length(F_DBS)
    E(i)=I_REF(i)-infinity_current(f,U,F,D,F_DBS(i)); 
    
end
Error=sum(E.^2);


