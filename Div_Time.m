
%Arbitrary values assigned to a and b

a=0.123;
b=0.456;

%Time taken to compute a division 20000 times
tic;
for i=1:20000
    c=a/b;
end
toc;