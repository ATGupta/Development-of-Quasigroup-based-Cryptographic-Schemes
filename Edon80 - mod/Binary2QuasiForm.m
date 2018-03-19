function f=Binary2QuasiForm(x)
    f=0;
    for i = 1 : length(x)/2
        y=0;
        for j = i*2-1 : i*2
            if y == 0
                y = x(j);
            else
                y = [y,x(j)];
            end
        end
        f(i)=GetValueFromBits(y)+1;
    end
end