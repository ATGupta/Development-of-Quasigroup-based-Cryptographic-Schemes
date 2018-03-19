% generates table 2 of Edon 80 Keystream mode- referred as table 1 in this
% prog
function a=GenerateKey(k,v,q,limit)
% k=input key; v=input iv; q=input 4 quasigroups; limit=order of quasigroups
    tt=0;
    for i = 1 : length(k)/2
        if i == 1
            K=GetValueFromBits([k(i*2-1),k(i*2)]);
        else
            K=[K,GetValueFromBits([k(i*2-1),k(i*2)])];
        end
    end
    K=K+1;
    
    for i = 1 : length(v)/2
        if i == 1
            V=GetValueFromBits([v(i*2-1),v(i*2)]);
        else
            V=[V,GetValueFromBits([v(i*2-1),v(i*2)])];
        end
    end
    V=[V,3,2,1,0,0,1,2,3];
    V=V+1;
    
    s=size(q);
    r=s(1,1);
    c=s(1,2);
    for i = 1 : r
        for j = 1 : c
            Q(ceil(j/limit),mod(j-1,limit)+1, i)=q(i,j);
        end
    end
    
    prompt='Enter the name of file to write the first table formed.\nEnter<0> for default name (Table1.txt).\n';
    o=input(prompt);
    if o == 0
        outputTables='Table1.txt';
    else
        outputTables = o;
    end
    fileID=fopen(outputTables,'w');
    
    fprintf(fileID,'\tLeader\t');
    for i = 1 : length(K)
        fprintf(fileID,'%d',K(i));
        fprintf(fileID,'\t');
    end
    for i = 1 : length(V)
        fprintf(fileID,'%d',V(i));
        fprintf(fileID,'\t');
    end
    fprintf(fileID,'\n');
    
    for i = 1 : length(V)
        
        fprintf(fileID,'q');
        fprintf(fileID,'%d',K(i));
        fprintf(fileID,'\t');
        fprintf(fileID,'%d',V(41-i));
        fprintf(fileID,'\t\t');
        
        for j = 1 : limit
            for l = 1 : limit
                qw(j,l)=Q(j,l,K(i));
            end
        end
        
        for j = 1 : length(K)
            
            if i == 1
                y=K(j);
            else
                y=a(i-1,j);
            end
            
            if j == 1
                x=V(41-i);
            else
                x=a(i,j-1);
            end
            
            a(i,j)=qw(x,y);
            fprintf(fileID,'%d',a(i,j));
            fprintf(fileID,'\t');
        end
        
        for j = 1 : length(V)
            
            if i == 1
                y=V(j);
            else
                y=a(i-1,j+40);
            end
            
            x=a(i,(j+40)-1);
            
            a(i,j+40)=qw(x,y);
            fprintf(fileID,'%d',a(i,j+40));
            fprintf(fileID,'\t');
            
        end
        fprintf(fileID,'\n');
    end
    
    for i = 1 : length(K)
        
        fprintf(fileID,'*');
        fprintf(fileID,'%d',K(i));
        fprintf(fileID,'\t');
        fprintf(fileID,'%d',K(i));
        fprintf(fileID,'\t\t');
        
        for j = 1 : limit
            for l = 1 : limit
                qw(j,l)=Q(j,l,(K(i)));
            end
        end
        
        for j = 1 : length(K)
            
            y=a(40+i-1,j);
            
            if j == 1
                x=K(41-i);
            else
                x=a(40+i,j-1);
            end
            
            a(40+i,j)=qw(x,y);
            fprintf(fileID,'%d',a(40+i,j));
            fprintf(fileID,'\t');
        end
        
        for j = 1 : length(V)
            
            y=a(40+i-1,40+j);
            
            x=a(40+i,40+j-1);
            
            a(i+40,j+40)=qw(x,y);
            fprintf(fileID,'%d',a(i+40,j+40));
            fprintf(fileID,'\t');
        end
        fprintf(fileID,'\n');
    end
    
    cypher=Encypher(a,K,V,limit,Q);
    
    a=cypher+1;
    fclose('all');
end