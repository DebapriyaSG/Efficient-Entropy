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
           
           %Entropy proposed method
           
           HA=(H1(1:2:end-1)+H1(2:2:end));
           ent_R1=(-1)*sum(log2(HA/2).*HA);
           HA=(H2(1:2:end-1)+H2(2:2:end));
           ent_R2=(-1)*sum(log2(HA/2).*HA);
           HA=(H3(1:2:end-1)+H3(2:2:end));
           ent_R3=(-1)*sum(log2(HA/2).*HA);
           ent_R=(ent_R1+ent_R2+ent_R3)/3;

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
           
           %Entropy proposed method           
          
           H=(H1(1:2:end-1)+H1(2:2:end));
           ent_R=(-1)*sum(log2(H/2).*H);
        end      
        AR(counter)=ent_R;
    end
end

prp_ent_mean=sum(AR)/counter;



