%This code computes entropy of images using a computationally efficient algorithm

clear;
clc;

path1=strcat(pwd,'\Database');
listing=dir(path1);
SZ=size(listing);
AR=zeros(1,SZ(1)-2); %Because first two points are non-image
counter=0;

for ii=1:SZ(1)  
    f=listing(ii).name;
    byt=listing(ii).bytes;    
    if(byt~=0)
        counter=counter+1;         
        file=strcat(path1,'\',f);
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
           H1=(H1/S1)+eps;          
           H2=(H2/S2)+eps;           
           H3=(H3/S3)+eps;
           
           e1=0;
           e2=0;
           e3=0;

           %Entropy proposed method
           for i=1:2:255               
                p1=H1(i)+H1(i+1);
                e1=e1+p1*log2(p1/2);               
               
                p2=H2(i)+H2(i+1);
                e2=e2+p2*log2(p2/2);               
              
                p3=H3(i)+H3(i+1);
                e3=e3+p3*log2(p3/2);               
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
                H1=(H1/S1)+eps;
                e=0;

                %Entropy proposed method
                for i=1:2:255               
                    p=H1(i)+H1(i+1);
                    e=e+p*log2(p/2);               
                end
                E=(-1)*e;
          end        
        AR(counter)=E;        
    end
end
prp_ent_mean=sum(AR)/counter;


