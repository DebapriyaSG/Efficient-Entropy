tic;
path1=strcat(pwd,'\Database');
listing=dir(path1);
SZ=size(listing);
J_Arr=zeros(1,SZ(1)-2); %Because first two points are non-image
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
          ImR=Im(:,:,1);
          ImG=Im(:,:,2);
          ImB=Im(:,:,3);

          %Finding the corner points
          [ImR_R,pair_1R,pair_2R,pair_3R,pair_4R]=Image_Rotate(ImR,20);
          [ImG_R,pair_1G,pair_2G,pair_3G,pair_4G]=Image_Rotate(ImG,20);
          [ImB_R,pair_1B,pair_2B,pair_3B,pair_4B]=Image_Rotate(ImB,20);

          %Overlapping region and corresponding intensities
          [CR,DR,BWR]=ROI_1_2D(ImR,ImR_R,pair_1R,pair_2R,pair_3R,pair_4R);
          [CG,DG,BWG]=ROI_1_2D(ImG,ImG_R,pair_1G,pair_2G,pair_3G,pair_4G);
          [CB,DB,BWB]=ROI_1_2D(ImB,ImB_R,pair_1B,pair_2B,pair_3B,pair_4B);

          histR=zeros(256,256);
          histG=zeros(256,256);
          histB=zeros(256,256);

          %Histogram
          szR=size(BWR);
          for i=1:szR(1)
              for j=1:szR(2)
                  if(BWR(i,j)==1)
                      IntR1=CR(i,j);
                      IntR2=DR(i,j);
                      histR(IntR1+1,IntR2+1)=histR(IntR1+1,IntR2+1)+1;
                      IntG1=CG(i,j);
                      IntG2=DG(i,j);
                      histG(IntG1+1,IntG2+1)=histR(IntG1+1,IntG2+1)+1;
                      IntB1=CB(i,j);
                      IntB2=DB(i,j);
                      histB(IntB1+1,IntB2+1)=histB(IntB1+1,IntB2+1)+1;
                  end
              end
          end
          totR=sum(histR(:));
          totG=sum(histG(:));
          totB=sum(histB(:));
          probR=histR/totR;
          probG=histG/totG;
          probB=histB/totB;          
          EntR=0;
          EntG=0;
          EntB=0;

          %Joint Entropy standard method
          for i=1:256
              for j=1:256
                  if(probR(i,j)~=0)
                    TR=probR(i,j)*log2(probR(i,j));
                    EntR=EntR+TR;
                  end
                  if(probG(i,j)~=0)
                    TG=probG(i,j)*log2(probG(i,j));
                    EntG=EntG+TG;
                  end
                  if(probB(i,j)~=0)
                    TB=probB(i,j)*log2(probB(i,j));
                    EntB=EntB+TB;
                  end
              end
          end
          EntR=(-1)*EntR;
          EntG=(-1)*EntG;
          EntB=(-1)*EntB;
          E=(EntR+EntG+EntB)/3;
        else %For non-RGB images
          [Im_R,pair_1,pair_2,pair_3,pair_4]=Image_Rotate(Im,20);
          [C,D,BW]=ROI_1_2D(Im,Im_R,pair_1,pair_2,pair_3,pair_4);
          
          hist=zeros(256,256);        
          sz1=size(BW);
          for i=1:sz1(1)
              for j=1:sz1(2)
                  if(BW(i,j)==1)
                      Int1=C(i,j);
                      Int2=D(i,j);
                      hist(Int1+1,Int2+1)=hist(Int1+1,Int2+1)+1;                      
                  end
              end
          end
          tot=sum(hist(:));          
          prob=hist/tot;                   
          Ent=0;
          
          %Joint Entropy standard method
          for i=1:256
              for j=1:256
                  if(prob(i,j)~=0)
                    T=prob(i,j)*log2(prob(i,j));
                    Ent=Ent+T; 
                  end
              end
          end
          Ent=(-1)*Ent; 
          E=Ent;
        end
        J_Arr(counter)=E;
    end       
end
  toc;         