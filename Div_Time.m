
%This code computes time taken to perform a division 20000 times

%Arbitrary values assigned to a and b
a=0.123;
b=0.456;

tic;
for i=1:20000
    c=a/b;
end
toc;