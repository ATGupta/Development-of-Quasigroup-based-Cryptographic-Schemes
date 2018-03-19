%implementation of Edon80 algorithm - for images
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
    
    q=[
        [1 3 2 4 3 2 4 1 2 4 1 3 4 1 3 2];
        [2 4 1 3 1 2 3 4 3 1 4 2 4 3 2 1];
        [3 2 1 4 2 3 4 1 4 1 3 2 1 4 2 3];
        [4 3 2 1 2 1 4 3 1 4 3 2 3 2 1 4];
        ];
    
    a=GenerateKey(k,v,q,4);% 4 is the order of quasigroup
end