function f=Alphabet2Binary(m)
    m=int64(m);
    f=0;
    for i = 1 : length(m)
        x=dec2bin(m(i));
        x=int64(x);
        x=x-48;
        y=0;
        for j = 2 : 8-length(x)
            y = [y,0];
        end
        for j = 1 : length(x)
            y = [y,x(j)];
        end
        if f==0
            f=y;
        else
            f=[f,y];
        end
    end
end