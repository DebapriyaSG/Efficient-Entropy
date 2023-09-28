
%This code computes time taken to perform three logarithms (base 2) and three multiplications
%(20000 times)

clear;
clc;

%Arbitrary values assigned to a, b and c
a=0.123;
b=0.456;
c=0.789;

tic;
for i=1:20000
    d=log2(a);
    e=log2(b);
    f=log2(c);
    g=a*b;
    h=b*c;
    j=a*c;
end
toc;