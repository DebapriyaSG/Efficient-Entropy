%This code computes time taken to perform one logarithm (base 2) and one multiplication (20000 times)


%Arbitrary values assigned to a and b
a=0.123;
b=0.456;


tic;
for i=1:20000
    c=a*b;
    d=log2(b);
end
toc;
