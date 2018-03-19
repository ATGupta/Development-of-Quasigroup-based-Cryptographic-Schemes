function x=GetValueFromBits(n)
    s=size(n);
    x=0;
    s=s(1,2);
    for i = 1 : s
        x=x+((n(i))*(2.^(s-i)));
    end
end