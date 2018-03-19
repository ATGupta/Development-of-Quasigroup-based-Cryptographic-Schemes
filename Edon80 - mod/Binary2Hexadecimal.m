function f=Binary2Hexadecimal(x)
    hx='0123456789ABCDEF';
    f=' ';
    for i = 1 : length(x)/4
        y=0;
        for j = i*4-3 : i*4
            if y==0
                y=x(j);
            else
                y=[y,x(j)];
            end
        end
        y=GetValueFromBits(y);
        if f == ' '
            f = hx(y+1);
        else
            f=strcat(f,hx(y+1));
        end
    end
end