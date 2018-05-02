clc;
close all;
clear all;

%AIM    : To simulate a series of sequences such that the sum of the
%sequence is just greater than 1
%NAME   : Tanmayan Pande
%E-MAIL : tpande@usc.edu

%A brief description of the variables used

%1. n = number of times the simulation is run.
%2. u = variable to store the sum of the sequence
%3. j = iterative variable
%4. a = variable to store the sequences
%5. len = variable to store the length of sequences
%6. h = histogram of the values in the variable len
%7. prob = probability of each length
%8. bin = the variable to store the value of different kinds of lengths
%9. mean = the variable for the mean of lengths

n = input('Enter the number of sample sequences you want\n');

for i = 1:n
    %Initialization of the variables
    u = 0;
    j = 0;
    %Conditional loop. While the sum is less than zero, continue adding
    %rand variables to the sequence
    while(u <= 1)
        a(i, j+1) = rand();
        u = u + a(i, j+1);
        j = j + 1;
    end
    %Store the length in a variable
    len(i) = j;
end
%Histogram for plotting the values of len
h = histogram(len);
subplot(1,1,1)
xlabel('The lengths of the sequence');
ylabel('The frequency of appearance');
title('Histogram of lengths');

%Probability of the different values of length
prob = h.Values./n;
for i = 1:(length(h.BinEdges)-1)
    bin(i) = (h.BinEdges(i) + h.BinEdges(i + 1))/2;
end
disp(bin)

%Mean of the lengths
mean = sum(bin.*prob);
disp('Mean length = ');
disp(mean)
disp('Probability = ');
disp(prob)

