
            finalKey=importdata('Keystream.txt');
            imageSource='Input.jpg';
            
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
            imageSource=strcat(imageSource, '-View.jpg');
            imwrite(outim, imageSource);