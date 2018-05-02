clc;
close all;
clear all;

%PDF : f(x) = C*sin(x)
%C = 2
%CDF : F(x) = 1/2 - 1/2*cos(x);
%Mean : pi/2 = 1.5704
%Variance : pi^2/4 - 2 = 0.4674

%% Part 1:
%AIM   : To generate a sequence of random numbers following the
%        distribution function f_X(x) = Csin(x). 
%NAME  : Tanmayan Pande
%EMAIL : tpande@usc.edu

%==========================================================================
%List of variables used:
% 1. N = number of samples to be generated
% 2. x = random sequence following the given PDF
% 3. t = sequential variable for displaying theoretical PDF
% 4. y = The probability values for the PDF
% 5. h = variable for storing the histogram
%==========================================================================
N = input('Enter the number of samples you want to generate: ');

%Generates the random samples as per the number specified.
x = cust_pdf(N);

%The calculation for the plotting of the theoretical PDF
t = 0:0.01:pi;
y = 1/2*sin(t);

%Display
h = histogram(x);
figure
bar(h.BinEdges(2:end), 2^(log10(2*N)-1)*h.BinCounts/N)
hold on
plot(t, y);
legend('show')
legend('Practical','Theoretical')
xlabel('Values of random sample')
ylabel('Frequencies')
title('The distribution and its practical results')
hold off

%% Part 2:
%AIM   : To check the mean square error of the mean of the generated random
%        sequence and compare it with the expected value of the MSE
%NAME  ; Tanmayan Pande
%EMAIL : tpande@uec.edu

%==========================================================================
%List of variables used:
% 1. N = number of samples in the sequence
% 2. v1 = Population Variance
% 3. x = Random sequence
% 4. v2 = Sample variance
% 5. MSE_exp = The MSE of the system using the population variance
% 6. MSE_ac = The MSE of the system using the sample variance
%==========================================================================

%Initialization of the variables
N = 100;
v1 = pi^2/4 - 2;

%Generation of different sequences following the PDF
for i = 1:1000
    x = cust_pdf(N);
    v2(i) = var(x);
end
%The expected MSE is the population variance of the sequence.
MSE_exp = v1/N;
MSE_ac = v2/N;
%This ratio should be almost n-1/n. As n -> infintiy, this ratio tends to 1

%Display
disp('The ratio of the expected MSE to the actual MSE is: ')
disp(mean(MSE_exp./MSE_ac))

%% Part 3:
%AIM   : To generate at least 50 bootstrapped samples from a aample
%        following the given PDF
%NAME  : Tanmayan Pande
%EMAIL : tpande@usc.edu

%==========================================================================
%List of variables used:
% 1. N = Number of samples
% 2. M = Bootstrapped samples
% 3. m = Mean of the bootstrapped samples
% 4. v = Variance of the bootstrapped samples
%==========================================================================

N = 100;

%Generating the random samples which follow the PDF
x = cust_pdf(N);

%We need 50 bootstrapped samples from the given sequence. Using the inbuilt
%function datasample(), we sample 100 samples from the sequence x with
%replacement. We then calculate the mean and the variance of each sample
for i = 1:50
    M(i, :) = datasample(x, 100, 'Replace', true);
    m(i) = mean(M(i, :));
    v(i) = var(M(i, :));
end

%Display
disp('The expected value of the means of the bootstrapped sequences is: ')
disp(mean(m))
disp('The expected value of the variances of the bootstrapped sequences is:')
disp(mean(v))

%% Part 4
%AIM   : To estimate the MSE of the sample variance, based on the
%        bootstrapped samples generated
%NAME  : Tanmayan Pande
%EMAIL : tpande@usc.edu

%==========================================================================
%List of variables used:
% 1. pop_var = The population variance of the given PDF
% 2. MSE_var = Mean Square Error of the variance
% 3. v = Variance of the bootstrapped samples
%==========================================================================

pop_var = pi^2/4 - 2;
MSE_var = 0;

%The values of v are taken from the earlier part of the code
v = v - pop_var;
v = (v).^2;
MSE_var = sum(v)/length(v);

%Display
disp('The Mean Square Error in the variance is:')
disp(MSE_var);
