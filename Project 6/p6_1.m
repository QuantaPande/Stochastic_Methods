clc;
close all;
clear all;

%--------------------------------------------------------------------------
%% Project 6: Part A
% Aim: To generate the sum of exponential random variables using the
% inversion method
% A list of the variables used: 

% 1. n: The number of times the trial is to be run. Input by the user 
% 2. s: The variable which stores the sum of 5 exponential random variables
% 3. k: The variable which stores the length of the sequence to be summed
%       up
% 4. u: The variable which stores the inital uniform variable
% 5. x: The variable whcih stores the exponential random variable
% 6. lambda: The variable which stores the mean of the exponential variable
% 7. mean: Mean of the summed exponential variable
% 8. va: Variance of the summed exponential variable

%--------------------------------------------------------------------------

%Initialization section
n = input('Enter the maximum number of trials you want to run: ');
k = input('Enter the length of the sequence to be summed up: ');
lambda = input('Enter the value of lambda (The mean): ');
s=zeros(1,n);
disp('The values generated by the inversion method: ')
tic

%Loop for generating sum starts
for i=1:n
    u=rand(1,k);          %Generate a uniformly distributed random variable
    x=-log(1-u)/lambda;   %Generate the exponentially distributed random 
                          %variable using the inversion method
    s(i) = sum(x);        %Sum the new random variables up
end
toc

%Display Section
figure
histfit(s, 125, 'gamma')
xlabel('Values of the sum')
ylabel('Frequency')
title('Generation of Sn using inversion method')

mean=sum(s)/length(s);
va=var(s);
disp('Mean by summing up the exponential variables is: ')
disp(mean)
disp('Variance is summing up the exponential variables is: ')
disp(va)

%--------------------------------------------------------------------------
%% Project 6: Part B

% Aim: To generate the sum of exponential random variables using the
% inversion method by taking the log of the product of uniform variables
% A list of the variables used: 

% 1. n: The number of times the trial is to be run. Input by the user 
% 2. s: The variable which stores the sum of 5 exponential random variables
% 3. k: The variable which stores the length of the sequence to be summed
%       up
% 4. u: The variable which stores the inital uniform variable
% 5. sd: The variable whcih stores the log of the sum of the exponential
%        random variable
% 6. lambda: The variable which stores the mean of the exponential variable
% 7. mean: Mean of the summed exponential variable
% 8. va: Variance of the summed exponential variable

%--------------------------------------------------------------------------

%Initialization section
disp('The values generated by taking log of product of uniformly generated random variable: ')
sd=ones(1,n);
tic

%Loop starts
for i=1:n
    u=rand(1,k);          %Generate a uniformly distributed random variable
    for j = 1:k
        sd(i)=sd(i)*u(j); %The sum is the log of the product. sd stores the
                          %the product of the uniform random variable
    end
end
s=-log(sd)/lambda;        %Take the log of the product and divide by lambda
toc

%Display Section
figure
histfit(s, 125, 'gamma')
xlabel('Values of the sum')
ylabel('Frequency')
title('Generation of Sn by taking log of the product of uniform variables')

mean=sum(s)/length(s);
va=var(s);
disp('Mean by taking the log of uniform variables: ')
disp(mean)
disp('Variance by taking the log of uniform variables: ')
disp(va)

%--------------------------------------------------------------------------
%% Project 6: Part C

% Aim: To generate the sum of exponential random variables using the
% inversion method by taking the log of the product of uniform variables
% A list of the variables used: 

% 1 . n: The number of times the trial is to be run. Input by the user 
% 2 . s: The variable which stores the sum of 5 exponential random variables
% 3 . k: The variable which stores the length of the sequence to be summed
%       up
% 4 . y: The variable which stores the inital uniform variable
% 5 . u: The variable which stores the exponential random generated with
%       given g(x)
% 6 . lambda: The variable which stores the mean of the exponential variable
% 8 . mean: Mean of the summed exponential variable
% 9 . va: Variance of the summed exponential variable
% 10. mu: The mean of the exponential variable given by g(x)
% 11. s: The variable which stores the accepted random variable value
% 12. count: Iterative variable to store the value of generated random
%            variable
%--------------------------------------------------------------------------
mu = 1/k;                                 %The value of mu for maximising c
c = lambda^k*k^k*exp(-k+1)/factorial(k-1);%The maximum value of c
count = 1;
const = lambda^k/(c*factorial(k-1)*mu);   %The constant term in calculating
                                          %h(x)/g(x)

%Loop starts
disp('The values generated by the rejection method: ')
tic
while(count ~= 100000)
    y = rand();                           %A uniform random variable used 
                                          %for the rejection method
    u = rand();                           %A uniform random variable used 
                                          %to generate the exponential
                                          %random variable
    u = -1/mu*(log(1 - u));               %Generation of the 
                                          %exponential random variable
    if (y <= const*u^(k-1)*exp(-u*(1-mu)))%Checking the rejection condition
        s(count) = u;                     %If the rejection condition is
                                          %satisfied, accept the generated 
                                          %random variable
        count = count + 1;
    end
end
toc

%Display Secion
figure 
histfit(s, 125, 'gamma')
xlabel('Values of the sum')
ylabel('Frequency')
title('Generation of Sn using rejection method')


mean=sum(s)/length(s);
va=var(s);
disp('Mean is: ')
disp(mean)
disp('Variance is: ')
disp(va)
    