clc;
close all;
clear all;

%Aim   : To check the randomness of a random number generator.
%Name  : Tanmayan Pande
%Email : tpande@usc.edu

%The sequence R is generated using the rand function. The functions shiftn,
%variance and covariance are user defined functions which calculate the
%shifted sequence from a given sequence, the variance of he series and the
%covariance between two random series.

%The symbols 
%R = random sequence generated
%M_0 = mean of the generated sequence
%R_n = shifted sequences
%M = mean of the shifted sequence
%var = variance of each of the shifted sequence
%covar = covariance of the original sequence with each shifted sequence
%a = sequence of random integers from 0 to 9
%y = histogram data of generated random integers
%count = the count of each instance of the integer
%GOF = chi-squared value of GOF test

GOF = 0;
R = rand(1, 10000);        
M_0 = sum(R)/length(R);                 %Theoretical Value = 0.5;
disp('The mean of the sequence is');
disp(M_0);
[R_n, M] = shiftn(R);
for i = 1:2*length(R) - 1
    var(i) = variance(R_n(i,:));        %Theoretical Value = 0;   
%     disp(size(R));
%     disp(size(R_n(i,:)));
    covar(i) = covariance(R, R_n(i,:)); %Theoretical Value = 0;
end
%Plot the variance
subplot(1,3,1)
stem(1:2*length(R)-1, var);
xlabel('Sequence number')
ylabel('Variance')
title('The graph of variance')

%Plot the covariance
subplot(1,3,2)
stem(1:2*length(R)-1, covar);
xlabel('Sequence number')
ylabel('Covariance')
title('The graph of covariance')

%Part C
a = randi([0,9], 1, 10000);
subplot(1,3,3)
y = histogram(a);
xlabel('Integers from 0 to 9');
ylabel('Frequency')
title('The histogram generated of random variables taking integral values from from 0 to 9')
count = y.BinCounts;
for i = 1:length(count)
    GOF = GOF + (count(i) - 1000)^2/1000;%Theoretical Value = 0;
end
disp('The Chi-Squared value after running the goodness of fit test is');
disp(GOF);