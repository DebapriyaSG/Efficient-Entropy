%This code computes entropy of images using the standard formula

path1=strcat(pwd,'\Database');
listing=dir(path1);
SZ=size(listing);
AR1=zeros(1,SZ(1)-2); %Because first two points are non-image
counter=0;

for ii=1:SZ(1)  
    f=listing(ii).name;
    byt=listing(ii).bytes;    
    if(byt~=0)
        counter=counter+1;
        file=strcat('E:\HDD-1\PhD\Publications(CICT and ICIC)\Entropy Computation Renewed\All_Images_Combined\',f);             
        Im=imread(file);
        if(islogical(Im))
            Im=uint8(255*Im);
        end
        S=size(Im);
        N=ndims(Im);
        if(N==3) %For RGB images           
           H1=zeros(256,1);
           H2=zeros(256,1);
           H3=zeros(256,1);

           %Histogram
           for j=1:S(1)
               for k=1:S(2)
                   in1=Im(j,k,1);
                   in2=Im(j,k,2);
                   in3=Im(j,k,3);
                   H1(in1+1)=H1(in1+1)+1;
                   H2(in2+1)=H2(in2+1)+1;
                   H3(in3+1)=H3(in3+1)+1;
               end
           end          
           S1=sum(H1);
           S2=sum(H2);
           S3=sum(H3);
           H1=H1/S1;
           H2=H2/S2;
           H3=H3/S3;
           e1=0;
           e2=0;
           e3=0;

           %Entropy standard method
           for i=1:256
               if(~(H1(i)==0))
                    e1=e1+H1(i)*log2(H1(i));
               end
               if(~(H2(i)==0))
                    e2=e2+H2(i)*log2(H2(i));
               end
               if(~(H3(i)==0))
                    e3=e3+H3(i)*log2(H3(i));
               end
           end
           E=(-1)*((e1+e2+e3)/3);
        else %For non-RGB images
           H1=zeros(256,1);
           for j=1:S(1)
               for k=1:S(2)
                   in1=Im(j,k);                   
                   H1(in1+1)=H1(in1+1)+1;                   
               end
           end
           S1=sum(H1);
           H1=H1/S1;
           e=0;

           %Entropy standard method
           for i=1:256
               if(~(H1(i)==0))
                    e=e+H1(i)*log2(H1(i));
               end
           end
           E=(-1)*e;
        end
        AR1(counter)=E;
    end
end

std_ent_mean=sum(AR1)/counter;
