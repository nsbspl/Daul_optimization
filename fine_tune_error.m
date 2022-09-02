function E=fine_tune_error(fun,x,x0,r)
if length(x0)==4
    E=fun(x)+r*sqrt(sum(((x-x0).^2)));
elseif length(x0)==3
    E=fun(x)+r*sqrt(sum(((x-x0)).^2));
elseif length(x0)==8
    E=fun(x)+r*sqrt(sum(((x-x0)).^2));
end