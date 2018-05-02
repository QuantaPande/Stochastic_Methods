clc;
close all;
clear all;

mu = 1/5;
lambda = 1;
c = 2.384;
count = 1;
tic
for i = 1:100000
    y = rand();
    u = rand();
    u = -1/mu*(log(1 - u));
    if (y <= u^4*exp(-u*(1 - mu))/(c*24/5));
        s(count) = u;
        count = count + 1;
    end
end
toc
histogram(s)
xlabel('Values of the sum')
ylabel('Frequency')
title('Generation of Sn using rejection method')
mean=sum(s)/length(s);
va=var(s);
disp('Mean is: ')
disp(mean)
disp('Variance is: ')
disp(va)