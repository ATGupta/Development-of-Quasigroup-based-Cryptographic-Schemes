% generates table 3 of Edon 80 keystream mode- referred as table 2 in this
% prog
% generates keystream; enc/dec the input

function f = Encypher(a,K,V,limit,Q)

% a=last row of table 1 of prog; K=key; V=IV; limit=order of quasigroup;Q=4
% quasigroups matrix
    prompt='Enter the length of keystream in no. of bits.\n';
    lm=input(prompt);
    if mod(lm,2)==1
        lm=lm+1;
    end
    
    s=size(a);
    r=s(1,1);
    A=a(r,:);
    
    prompt='Enter the name of file to write the second table formed.\nEnter<0> for default name (Table2.txt).\n';
    o=input(prompt);
    if o == 0
        outputTables='Table2.txt';
    else
        outputTables = o;
    end
    fileID=fopen(outputTables,'w');
    
    fprintf(fileID,'\tLeader\t');
    for i = 1 : lm
        fprintf(fileID,'%d',mod(i-1,4)+1);
        fprintf(fileID,'\t');
    end
    fprintf(fileID,'\n');
    
    for i = 1 : length(a)
        
        fprintf(fileID,'q');
        
        for j = 1 : limit
            for l = 1 : limit
                if i <= 40
                    qw(j,l)=Q(j,l,K(i));
                else
                    qw(j,l)=Q(j,l,K(i-40));
                end
            end
        end
        
        if i <= 40
            fprintf(fileID,'%d',K(i));
        else
            fprintf(fileID,'%d',K(i-40));
        end
        
        fprintf(fileID,'\t');
        fprintf(fileID,'%d',A(i));
        fprintf(fileID,'\t\t');
        
        for j = 1 : lm
            
            if i == 1
                y=mod(j-1,4)+1;
            else
                y=z(i-1,j);
            end
            
            if j == 1
                x=A(i);
            else
                x=z(i,j-1);
            end
            
            z(i,j)=qw(x,y);
            
            fprintf(fileID,'%d',z(i,j));
            fprintf(fileID,'\t');
        end
        fprintf(fileID,'\n');
    end
    
    s=size(z);
    r=s(1,1);
    Z=z(r,:);
    
    finalKey=0;
    
    for i = 1 : lm
        if mod(i,2) == 0
            x=Z(i)-1;
            
            if i == 2
                finalKey=x;
            else
                finalKey=[finalKey,x];
            end
        end
    end
    finalKey=QuasiForm2Binary(finalKey+1);
    
    prompt='Enter the name of file to write the keystream.\nEnter <0> for the default file (Keystream.txt).\n';
    o=input(prompt);
    if o == 0
        keystreamFile='Keystream.txt';
    else
        keystreamFile=o;
    end
    fileID=fopen(keystreamFile,'w');
    fprintf(fileID,'%d',finalKey);
    
    prompt='Enter <1> to encypher using generated Keystream.\nEnter <2> to decypher using generated Keystream.\nEnter <0> to exit.\n';
    o=input(prompt);
    if o == 1
        
        prompt='Enter the name of input file.\nEnter <0> for default file (Input.jpg):\n';
        o=input(prompt);
        if o == 0
            imageSource='Input.jpg';
        else
            imageSource=o;
        end
        
        inim=imread(imageSource);
        s=size(inim);
        
        i=1;
        for r = 1 : s(1)
            for c = 1 : s(2)
                for h = 1 : s(3)
                    bin=dec2bin(inim(r,c,h));
                    b=8-length(bin);
                    bits=0;
                    for n = 1 : b
                        bits(n)=0;
                    end
                    for n = 1 : length(bin)
                        bits(n+b)=int64(bin(n))-48;
                    end
                    g=0;
                    for n = 1 : length(bits)
                        x=finalKey(i);
                        i=i+1;
                        y=bits(n);
                        g(n)=xor(x,y);
                    end
                    d='';
                    for n = 1 : length(g)
                        d=strcat(d,int2str(g(n)));
                    end
                    outpix=bin2dec(d);
                    outim(r,c,h)=uint8(outpix);
                end
            end
        end
        outim=uint8(outim);
        
        prompt='Enter the name of output file.\nEnter <0> for default file (Output.jpg):\n';
        o=input(prompt);
        if o == 0
            imageSource='Output.jpg';
        else
            imageSource=o;
        end
        
        imwrite(outim, imageSource, 'Mode', 'lossless');
        imageSource=strcat(imagesource, '-View.jpg');
        imwrite(outim, imageSource);
        
    else
        if o == 2
        
            prompt='Enter the name of input file.\nEnter <0> for default file (Input.jpg):\n';
            o=input(prompt);
            if o == 0
                imageSource='Input.jpg';
            else
                imageSource=o;
            end
    
            inim=imread(imageSource);
            s=size(inim);
    
            i=1;
            for r = 1 : s(1)
                for c = 1 : s(2)
                    for h = 1 : s(3)
                        bin=dec2bin(inim(r,c,h));
                        b=8-length(bin);
                        bits=0;
                        for n = 1 : b
                            bits(n)=0;
                        end
                        for n = 1 : length(bin)
                            bits(n+b)=int64(bin(n))-48;
                        end
                        g=0;
                        for n = 1 : length(bits)
                            x=finalKey(i);
                            i=i+1;
                            y=bits(n);
                            g(n)=xor(x,y);
                        end
                        d='';
                        for n = 1 : length(g)
                            d=strcat(d,int2str(g(n)));
                        end
                        outpix=bin2dec(d);
                        outim(r,c,h)=uint8(outpix);
                    end
                end
            end
            outim=uint8(outim);
    
            prompt='Enter the name of output file.\nEnter <0> for default file (Output.jpg):\n';
            o=input(prompt);
            if o == 0
                imageSource='Output.jpg';
            else
                imageSource=o;
            end
    
            imwrite(outim, imageSource, 'Mode', 'lossless');
            imageSource=strcat(imagesource, '-View.jpg');
            imwrite(outim, imageSource);
        end
    f=0;
    end
end