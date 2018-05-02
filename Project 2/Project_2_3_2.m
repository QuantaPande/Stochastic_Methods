clc;
close all;
clear all;

%Aim    : To find the value of the Dirichlet integral for a specific range
%from pi to 2 pi etc.
%Name   : Tanmayan Pande
%E-mail : tpande@usc.edu

%A brief description of the variables used in the program:
%1. n = number of points which must be used in the run the simulation
%2. u = uniformly distributed random variable which is used in the
%simulation as sample points
%3. k = iterative variable for n = 1,2,3,4,5
%4. I_1 = variable which stores the value of the integrals generated in
%each interation
%5. I_2 = variable to store the value of the integral for the second case,
%for increasing values of n


%Initialization of the variables
n = input('Enter the number of points to be taken: \n');
u = rand(1, n);
I_1 = zeros(1, 5);

%Loop for calculating the integral
for k = 1:5
    for j = 1:n
        I_1(k) = I_1(k) + (sin((k-1)*pi + pi*u(j))/((k-1)*pi + pi*u(j)))*pi;
    end
    %The value of the integral is the expected value of the calculated
    %answers.
    I_1(k) = I_1(k)/n;
end

%Loop for calculating the integral from 0 to n*pi, with increasing n
I_2 = zeros(1, 5);
for i = 1:5
    for j = 1:10^(i+1)
        I_2(i) = I_2(i) + (sin((10^i)*pi*u(j))/u(j));
    end
    %The value of the integral is the expected value of the calculated
    %answer.
    I_2(i) = I_2(i)/(10^(i+1));
end

%Display
disp('The integral for the different intervals, for 0-1 upto 4-5 are:');
disp(I_1);
disp('The integrals from 0 to n*pi for n going from 10 to 10000 logarithmically are');
disp(I_2);