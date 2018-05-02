clc;
close all;
clear all;

%AIM    : To simulate a series of lengths which denote the difference
%between a number and the next largest number 
%NAME   : Tanmayan Pande
%E-MAIL : tpande@usc.edu

%A brief description of the variables used

%1. n = number of times the simulation is run.
%2. u = variable to store the sum of the sequence
%3. j = iterative variable
%4. i = iterative variable
%5. X2 = difference between the first value and the next largest value in
%the sequence
%6. X3 = difference between the current value and the next largest value in
%the sequence
%7. prob_X2 = probability of the different values of X2
%8. prob_X3 = probability of the different values of X3
%9. h1 = histogram of X2
%10. h2 = histogram of X3
%11. mean_X2 = mean of the values of X2
%12. mean_X3 = mean of the values of X3

n = input('The number of times you want the sequence to be run: ');
for i = 1:n 
    %Initialization of variables
    u = rand(1, 100);
    j = 1;
    X2(i) = 1;
    X3(i) = 0;
    
    %Check whether the current value is greater than the initial value
    while(u(1) > u(j + 1) && j < 99)
        X2(i) = X2(i) + 1;
        j = j + 1;
    end
    
    %Check whether the current value is greater than the inital value
    while(u(X2 + 1) > u(j))
        X3(i) = X3(i) + 1;
        j = j + 1;
    end
end

%Plotting of the results
h1 = histogram(X2);

%Calculation of probability and mean
prob_X2 = h1.Values./n;
mean_X2 = sum(X2)/length(X2);

%Plotting the results
h2 = histogram(X3);

%Calculation of the probability and mean
prob_X3 = h2.Values./n;
mean_X3 = sum(X3)/length(X3);

%Display
subplot(1,1,1)
histogram(X2)
xlabel('The lengths which appear in the sequence')
ylabel('The frequency of the different lengths')
title('Histogram of the lengths of X2')
disp('The probability of X2')
disp(prob_X2)
disp('The probability of X3')
disp(prob_X3)
disp('The mean of X2')
disp(mean_X2)
disp('The mean of X3')
disp(mean_X3)