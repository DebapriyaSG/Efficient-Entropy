
%Arbitrary values assigned to a and b

a=0.123;
b=0.456;

%Time taken to compute one logarithm (base 2) and one multiplication (20000 times)
tic;
for i=1:20000
    c=a*b;
    d=log2(b);
end
toc;
