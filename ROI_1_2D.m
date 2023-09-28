%This function finds out the overlapping region of two images while
%computing joint entropy

function[C,D,BW]=ROI_1_2D(A,B_t,pair_1,pair_2,pair_3,pair_4)
sA=size(A);
sB_t=size(B_t);

c_A=[1 sA(2) sA(2) 1];
r_A=[1 1 sA(1) sA(1)];
BW_A=roipoly(A,c_A,r_A);

c_B_t=[pair_1(2) pair_2(2) pair_3(2) pair_4(2)];
r_B_t=[pair_1(1) pair_2(1) pair_3(1) pair_4(1)];
BW_B_t=roipoly(B_t,c_B_t,r_B_t);

if(sA(1)>sB_t(1))
    s(1)=sA(1);    
else
    s(1)=sB_t(1);    
end

if(sA(2)>sB_t(2))
    s(2)=sA(2);    
else
    s(2)=sB_t(2);    
end

if(sA(1)==sB_t(1) && sA(2)==sB_t(2))
    s(1)=sA(1);
    s(2)=sA(2);
end

sBW_A=size(BW_A);
sBW_B_t=size(BW_B_t);

C=zeros(s(1),s(2));
D=zeros(s(1),s(2));
BW_C=zeros(s(1),s(2));
BW_D=zeros(s(1),s(2));
BW=zeros(s(1),s(2));

%Finding out region of interest for different size combinations
if(sA(1)>sB_t(1) && sA(2)>sB_t(2))
    cntr_Ar=round(sA(1)/2);
    cntr_Ac=round(sA(2)/2);
    cntr_B_t_r=round(sB_t(1)/2);
    cntr_B_t_c=round(sB_t(2)/2);
    diff_r=cntr_Ar-cntr_B_t_r;
    diff_c=cntr_Ac-cntr_B_t_c;   
    
    
    for j=diff_r+1:diff_r+sB_t(1)
            for k=diff_c+1:diff_c+sB_t(2)
                D(j,k)=B_t(j-diff_r,k-diff_c);                    
            end
    end
      
    for j=diff_r+1:diff_r+sB_t(1)
        for k=diff_c+1:diff_c+sB_t(2)            
            BW_D(j,k)=BW_B_t(j-diff_r,k-diff_c);
        end
    end

    C=A;
    BW_C=BW_A;
 else
    if(sA(1)<sB_t(1) && sA(2)<sB_t(2))
        cntr_Ar=round(sA(1)/2);
        cntr_Ac=round(sA(2)/2);
        cntr_B_t_r=round(sB_t(1)/2);
        cntr_B_t_c=round(sB_t(2)/2);
        diff_r=cntr_B_t_r-cntr_Ar;
        diff_c=cntr_B_t_c-cntr_Ac;        
        
        for j=diff_r+1:diff_r+sA(1)
                for k=diff_c+1:diff_c+sA(2)
                    C(j,k)=A(j-diff_r,k-diff_c);                        
                end
        end             
        
        for j=diff_r+1:diff_r+sA(1)
            for k=diff_c+1:diff_c+sA(2)                    
                BW_C(j,k)=BW_A(j-diff_r,k-diff_c);
            end
        end   

        D=B_t;
        BW_D=BW_B_t;
     else
        if(sA(1)>=sB_t(1) && sA(2)<=sB_t(2))
            col_shft_1=floor((sB_t(2)-sA(2))/2);            
            
            for j=1:s(1)
                for k=col_shft_1+1:col_shft_1+sA(2)
                    C(j,k)=A(j,k-col_shft_1);                        
                end
            end
            
            row_shft_1=floor((sA(1)-sB_t(1))/2);
            
            for j=row_shft_1+1:row_shft_1+sB_t(1)
                for k=1:s(2)
                    D(j,k)=B_t(j-row_shft_1,k);                       
                end
            end
            
            for j=1:sBW_A(1)
                for k=1+col_shft_1:sBW_A(2)+col_shft_1
                    BW_C(j,k)=BW_A(j,k-col_shft_1);
                end
            end

            for j=row_shft_1+1:sBW_B_t+row_shft_1
                for k=1:sBW_B_t(2)
                    BW_D(j,k)=BW_B_t(j-row_shft_1,k);
                end
            end          
        else
              if(sA(1)<=sB_t(1) && sA(2)>=sB_t(2))
                  row_shft_1=floor((sB_t(1)-sA(1))/2); 
                 
                  for j=1+row_shft_1:sA(1)+row_shft_1
                      for k=1:s(2)
                          C(j,k)=A(j-row_shft_1,k);
                      end
                  end
                  
                  col_shft_1=floor((sA(2)-sB_t(2))/2);
                  
                  for j=1:sB_t(1)
                      for k=1+col_shft_1:sB_t(2)+col_shft_1
                          D(j,k)=B_t(j,k-col_shft_1);
                      end
                  end
                                   
                  for j=1+row_shft_1:sBW_A(1)+row_shft_1
                      for k=1:s(2)
                          BW_C(j,k)=BW_A(j-row_shft_1,k);
                      end
                  end
                  
                  for j=1:s(1)
                      for k=1+col_shft_1:sBW_B_t(2)+col_shft_1
                          BW_D(j,k)=BW_B_t(j,k-col_shft_1);
                      end
                  end 
             end
        end
     end
end

%BW is 1 iff BW_C = 1 and BW_D = 1
for j=1:s(1)
    for k=1:s(2)
        if(BW_C(j,k)==1 && BW_D(j,k)==1)
            BW(j,k)=1;
        end                    
    end
end
BW=logical(BW);
end         
   
