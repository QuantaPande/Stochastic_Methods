clc;
close all;
clear all;

%AIM    : To simulate a series of sequences until the predecessor is
%smaller than the current elements
%NAME   : Tanmayan Pande
%E-MAIL : tpande@usc.edu

%A brief description of the variables used

%1. n = number of times the simulation is run.
%2. u = random sequence over which we run the simulation
%3. j = iterative variable
%4. i = iterative variable
%5. len = variable to store the length of sequences
%6. h = histogram of the values in the variable len
%7. prob = probability of each length
%8. num = the variable to store the value of different kinds of lengths
%9. mean = the variable for the mean of lengths

n = input('Enter the maximum number of times the simulation is to be run: ');
for i = 1:n
    
    %Initialization of the variables
    u = rand(1, 20);
    j = 1;
    %Until the successor is greater than the predecessor, run the loop
    while(u(j) < u(j + 1))
        j = j + 1;
    end
    
    %To correct for the fact that the sequence starts at n = 1
    j = j + 1;
    %Store the length of the sequence in a variable
    len(i) = j;
end


%Histogram for plotting the values of len
subplot(1,1,1)
h = histogram(len);
xlabel('The frequency of the lengths')
ylabel('The frequency of the values')
title('Histogram of sequence lengths')
disp(h);

%Probability of the different values of length
prob = h.Values./n;
for i = 1:(length(h.BinEdges)-1)
    num(i) = (h.BinEdges(i) + h.BinEdges(i + 1))/2;
end
disp(num)

%Mean of the lengths
mean = sum(num.*prob);  
disp(mean)
disp(prob)
