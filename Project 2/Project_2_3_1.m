clc;
close all;
clear all;

%Aim    : To use Monte Carlo methods to estimate the value of pi
%Name   : Tanmayan Pande
%E-mail : tpande@usc.edu

%Brief descriptions of the variables used

%1. n = number of points to be used for the first iteration of the loop
%2. m = number of times the simulation is to be run fo the same number of
%points
%3. a = variable which contains the indicator function value
%4. x = randomly generated x values
%5. y = randomly generated y values
%6. i, j = iterative variables
%7. p = value to store the sum of the array a
%8. pi_a = variable to store the value of pi
%9. m = value to store the mean of the values of pi for all simulations for
%a particular n
%10.v = value to store the variance of the values of pi for a particular n
%11.conf_int: The variable which stores the value of confidence interval of
%the value of pi for a particular n
%12. conf_int_n = the variable to store the confidence interval for the
%specific case of the value of pi lying between 0.99*pi and 1.01*pi
%13. v_n = variance for the same case as above
%14. n_n = value of n for the same case

n = input('Enter the number of points you want to use \n');
m = input('Enter the number of times you want the simulation to run \n');
for n = n:50:200*n
    %Initialization of the variables
    a = zeros(1, n);
    for j = 1:m
        %Initialization using normal distribution for equal weightage 
        x = rand(1, n);
        x = abs(x);
        y = rand(1, n);
        y = abs(y);
        for i = 1:n
            %Chcek if each point lies inside the unit circle. if yes,
            %indicator function = 1
            if((x(i)^2 + y(i)^2) < 1)
                a(i) = 1;
            end
        end
        
        %Calculation of the value of pi for this interation.
        p = sum(a);
        pi_a(j) = (p/n)*4;
        a = [];
    end
    
    %The calculation of the mean and the variance of the values of pi for
    %this value of n
    m = sum(pi_a)/length(pi_a);
    v = 0;
    v = var(pi_a);
    %confidence interval = 1.96*v - (-1.96*v) = 3.92*v
    conf_int(n/50) = 3.92*v;
end

disp(m)
%Plotting the value of confidence interval with respect to the number of
%points.
subplot(1,1,1)
plot((1:200)*50, conf_int);
xlabel('The number of points used');
ylabel('The confidence interval');
title('Plot of points used v/s the confidence interval');

%The calculation for the value of n if the confidence interval is pi +- 1%
conf_int_n = (101*pi - 99*pi)/100;
%As confidence interval is four times the variance
v_n = conf_int_n/4; 

%As variance is equal to sqrt(p(1-p)/n))
n_n = (sqrt(pi/4*(1-pi/4))/v_n)^2;
disp('The value for n if the confidence interval is pi +- 1% is:');
disp(ceil(n_n));