%implementation of Edon80 algorithm - changeable quasigroups through files
function f=Edon80()
    
    prompt='Enter the name of file to input key.\nEnter <0> to input key from default file (Key.txt):\n';
    o=input(prompt);
    if o == 0
        keySource='Key.txt';
    else
        keySource=o;
    end
    k=importdata(keySource);
    
    prompt='Enter the name of file to input the IV.\nEnter <0> to input key from default file (IV.txt):\n';
    o=input(prompt);
    if o == 0
        ivSource='IV.txt';
    else
        ivSource=o;
    end
    v=importdata(ivSource);
    
    prompt='Enter the name of file to input the four quasigroups.\nEnter <0> to input key from default file (QuasiG..txt):\n';
    o=input(prompt);
    if o == 0
        quasiGSource='QuasiG..txt';
    else
        quasiGSource=o;
    end
    q=importdata(quasiGSource);
    
    a=GenerateKey(k,v,q,4);% 4 is the order of quasigroup
end