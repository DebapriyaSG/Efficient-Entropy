function[IMG,pair_1,pair_2,pair_3,pair_4]=Image_Rotate(im,ang)
s=size(im);
x=s(1);
y=s(2);
x_cord=zeros(x,y);
y_cord=zeros(x,y);
x_new=zeros(x,y);
y_new=zeros(x,y);
n=zeros(x,y);
p=zeros(x,y);

angle=ang*pi/180;
cos1=cos(angle);
sin1=sin(angle); 

%Calculation of half of length and width
x1=mod(x-1,2);
y1=mod(y-1,2);

if(x1==1)
    x1=round((x-1)/2);
else
    x1=(x-1)/2;
end

if(y1==1)
    y1=round((y-1)/2);
else
    y1=(y-1)/2;
end

for i=1:x
    for j=1:y
        %Bringing the center pixel of the image to (1,1)
        x_cord(i,j)=i-x1;
        y_cord(i,j)=j-y1;

        %Rotated x coordinate
        x_new(i,j)=(x_cord(i,j)*cos1);        
        z1=(y_cord(i,j)*sin1);		
        x_new(i,j)=x_new(i,j)-z1;	

        %Rounding to nearest integer
        n(i,j)=round(x_new(i,j));
        %Shifting the rounded up pixel from (1,1) centre to original centre
        n(i,j)=n(i,j)+x1;

        %Rotated y coordinate
        y_new(i,j)=(x_cord(i,j)*sin1);		
        z2=(y_cord(i,j)*cos1);		
        y_new(i,j)=y_new(i,j)+z2;

        %Rounding to nearest integer
        p(i,j)=round(y_new(i,j));	
        %Shifting the rounded up pixel from (1,1) centre to original centre
        p(i,j)=p(i,j)+y1;     
    end     
end

%Finding minimum values of new coordinates
 minn=min(n(:)); 
 minp=min(p(:));
 

 for i=1:x	
     for j=1:y
         %If some coordinates are negative, they are shifted to (0,0) 
         n(i,j)=n(i,j)-minn;
         p(i,j)=p(i,j)-minp;       
     end
 end
 
 %Finding the shifted maximum and minimum values of coordinates
 minn1=min(n(:));
 maxn1=max(n(:));
 minp1=min(p(:));
 maxp1=max(p(:));

 %Writing the intensity values in the changed coordinates 
 IMG=zeros((maxn1+1),(maxp1+1));
 
 %Corner points if size of transformed image is equal to size of original
 %image
 flag=0;
 if(maxn1+1==s(1) && maxp1+1==s(2))
    pair_1=[s(1),s(2)];
    pair_2=[minn1+1,s(2)];
    pair_3=[minn1+1,minp1+1];
    pair_4=[s(1),minp1+1];
    flag=1;
 else
     if(maxn1+1==s(2) && maxp1+1==s(1))
         pair_1=[s(2),s(1)];
         pair_2=[minn1+1,s(1)];
        pair_3=[minn1+1,minp1+1];
        pair_4=[s(2),minp1+1];
        flag=1;
     end
 end
 
 for i=1:x
    for j=1:y
        n1=n(i,j);
        p1=p(i,j);
        %In order to get the corner points
        if(flag==0)        
            if(n1==maxn1)
                p_corner=p1+1;
                pair_1=[maxn1+1,p_corner]; 
                
            end
            if(p1==maxp1)
                n_corner=n1+1;
                pair_2=[n_corner,maxp1+1];
                
            end
            if(n1==0)
                p_corner_2=p1+1;
                pair_3=[n1+1,p_corner_2];
                
            end
            if(p1==0)
                n_corner_2=n1+1;
                pair_4=[n_corner_2,p1+1];
                
            end
        end
        IMG((n1+1),(p1+1))=im(i,j);
    end
        %Since coordinates start from (1,1),(n1+1) and (p1+1) is done
        
 end 

end

