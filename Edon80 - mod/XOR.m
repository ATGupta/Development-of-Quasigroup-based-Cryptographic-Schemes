function f=XOR(a,b)
    a=GetBitsFromValue(a);
    b=GetBitsFromValue(b);
    
    if length(a)>length(b)
        g=a;l=b;
    else
        g=b;l=a;
    end
    
    for i = length(l)+1 : length(g)
        l=[0,l];
    end
    
    f=0;
    for i = 1 : length(l)
        
        posg=length(g)-i+1;
        posl=length(l)-i+1;
        
        if g(posg)==l(posl)
            x=0;
        else
            x=1;
        end
        
        if i==1
            f=x;
        else
            f=[x,f];
        end 
    end
    
    f=GetValueFromBits(f);
end