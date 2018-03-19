function v=GetBitsFromValue(x)
    index=1;
    if x==0
        r=0;
    end
    while x>0
        a=mod(x,2);
        x=floor(x/2);
        r(index)=a;
        index=index+1;
    end
    disp(x);
    s=size(r);
    s=s(1,2);
    if s==1
        r=[r,0];
        s=size(r);
        s=s(1,2);
    end
    for i = 1 : s
        v(i)=r(s-i+1);
    end
end