function f=QuasiForm2Binary(m)
    %m=int64(m);
    hx=[1 2 3 4];
    bin=[
        [0 0];
        [0 1];
        [1 0];
        [1 1];
        ];
    f=0;
    for i = 1 : length(m)
        x=find(hx==m(i));
        f(i*2-1)=bin(x,1);
        f(i*2)=bin(x,2);
    end
end