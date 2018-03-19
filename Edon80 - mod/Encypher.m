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
        
        prompt='Enter the name of file where the message / plaintext is present.\nEnter <0> for default file (Plain Text.txt)\n';
        o=input(prompt);
        if o==0
            messageFile='Plain Text.txt';
        else
            messageFile=o;
        end
        
        prompt='Enter the form of input plaintext.\nEnter <1> for alphablet.\nEnter <2> for Hexadecimal.\nEnter <3> for quasigroup form (1-4).\nEnter <4> for binary.\n';
        o=input(prompt);
        
        if o == 1
            fileID=fopen(messageFile,'r');
            m=fscanf(fileID,'%s');
            m=Alphabet2Binary(m);
        else if o == 2
                fileID=fopen(messageFile,'r');
                m=fscanf(fileID,'%s');
                m=Hexadecimal2Binary(m);
            else if o == 3
                    m=importdata(messageFile);
                    m=QuasiForm2Binary(m);
                else
                    m=importdata(messageFile);
                end
            end
        end
        lm=length(m);
        
        f(1)=0;
        for i = 1 : lm
            x=finalKey(i);
            y=m(i);
            f(i)=xor(x,y);
        end
        
        prompt='Enter the name of file to write the cypher.\nEnter <0> for default file (Cypher.txt)\n';
        o=input(prompt);
        if o==0
            cypherFile='Cypher.txt';
        else
            cypherFile=o;
        end
        
        prompt='Enter the form of output cypher.\nEnter <1> for Hexadecimal.\nEnter <2> for quasigroup form (1-4).\nEnter <3> for binary.\n';
        o=input(prompt);
        
        if o == 1
            f=Binary2Hexadecimal(f);
            fileID=fopen(cypherFile,'w');
            fprintf(fileID,'%s',f);
        else if o == 2
                f=Binary2QuasiForm(f);
                
                fileID=fopen(cypherFile,'w');
                fprintf(fileID,'%d ',f);
            else
                fileID=fopen(cypherFile,'w');
                fprintf(fileID,'%d ',f);
            end
        end
        
    else
        if o == 2
        
            prompt='Enter the name of file where the cypher is present.\nEnter <0> for default file (Cypher.txt)\n';
            o=input(prompt);
            if o==0
                messageFile='Cypher.txt';
            else
                messageFile=o;
            end
    
            prompt='Enter the form of input cypher.\nEnter <1> for alphablet.\nEnter <2> for Hexadecimal.\nEnter <3> for quasigroup form (1-4).\nEnter <4> for binary.\n';
            o=input(prompt);
    
            if o == 1
                fileID=fopen(messageFile,'r');
                m=fscanf(fileID,'%s');
                m=Alphabet2Binary(m);
            else if o == 2
                    fileID=fopen(messageFile,'r');
                    m=fscanf(fileID,'%s');
                    m=Hexadecimal2Binary(m);
                else if o == 3
                        m=importdata(messageFile);
                        m=QuasiForm2Binary(m);
                    else
                        m=importdata(messageFile);
                    end
                end
            end
            lm=length(m);
        
            f(1)=0;
            for i = 1 : lm
                x=finalKey(i);
                y=m(i);
                f(i)=xor(x,y);
            end
        
            prompt='Enter the name of file to write the message / plain text.\nEnter <0> for default file (Plain Text.txt)\n';
            o=input(prompt);
            if o==0
                cypherFile='Plain Text.txt';
            else
                cypherFile=o;
            end
    
            prompt='Enter the form of output message / plain text.\nEnter <1> for Hexadecimal.\nEnter <2> for quasigroup form (1-4).\nEnter <3> for binary.\n';
            o=input(prompt);
    
            if o == 1
                f=Binary2Hexadecimal(f);
                fileID=fopen(cypherFile,'w');
                fprintf(fileID,'%s',f);
            else if o == 2
                    f=Binary2QuasiForm(f);
    
                    fileID=fopen(cypherFile,'w');
                    fprintf(fileID,'%d ',f);
                else
                    fileID=fopen(cypherFile,'w');
                    fprintf(fileID,'%d ',f);
                end
            end
        end
    f=0;
    end
end