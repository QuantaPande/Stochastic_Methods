clc;
close all;
clear all;

%Aim   : To simulate a coin toss
%Name  : Tanmayan Pande
%Email : tpande@usc.edu

%Let the heads be denoted by ones and the tails by zeroes. The experiment
%will consist of 50 trials and the experiment itself will be repeated 5000
%times to get an accurate picture of the distribution

%The symbols S1 - S50 denotes the different series of consecutive heads
%For example, S1 == 'H', S2 == 'HH', S3 == 'HHH' and so on.

exp_res = zeros(5000, 50);                      %The variable which stores the results of all experiments
S = zeros(5000, 50);                            %The variable which stores the occurences of the patterns S1 - S50
heads = zeros(1, 5000);                         %The variable which stores all the heads
tails = zeros(1, 5000);                         %The variable which stores all the tails
prob_Nh = zeros(1, 5000);                       %The variable to store the probability of heads appearing in the sequence
for i = 1:5000                                  %Iterate 5000 times
    exp_res(i,:) = randi([0, 1], 1, 50);        %The results of the experiment
    for j = 1:50                                %Loop to count the heads obtained from the experiment
        if(exp_res(i, j) == 1)
            heads(i) = heads(i) + 1;
        end
    end
    tails(i) = 50 - heads(i);                   %If the trial doesn't give a head, it gives a tail (Binomial trial)
    prob_Nh(i) = heads(i)/50;                   %Calculate the probability of heads appearing in the experiment
    for j = 1:50                                %Loop to check for the series S1 - S50
        Lh = ones(1, j);                        %Lh stores the series in the form of consecutive ones
        for k = 1:50-j+1                        %Loop to check when the series appears for the first time in the sequence
            if(exp_res(i, k:k+j-1) == Lh)       
                S(i, j) = k;                    %Store the position
                break;
            end
        end
    end
end

%Display of the anaylsis
%Display the probability distribution
subplot(2,3,1)
disp(histogram(prob_Nh));
xlabel('Probability');
ylabel('Count');
title('Histogram of probability v/s count');

%Displey the times S1 appeared on each location
subplot(2,3,2)
disp(histogram(S(:,1)));
xlabel('Position of series S1');
ylabel('Count');
title('Histogram of length of series S1')

%Display the times S2 appeared on each location
subplot(2,3,3)
disp(histogram(S(:,2)));
xlabel('Position of series S2');
ylabel('Count');
title('Histogram of length of series S2')

%Display the times S3 appesred on each location
subplot(2,3,4)
disp(histogram(S(:,3)));
xlabel('Position of series S3');
ylabel('Count');
title('Histogram of length of series S3')

%Display the times S4 appeared on each location
subplot(2,3,5)
disp(histogram(S(:,4)));
xlabel('Position of series S4');
ylabel('Count');
title('Histogram of length of series S4')

%Display the times S5 appeared on each location
subplot(2,3,6)
disp(histogram(S(:,5)));
xlabel('Position of series S5');
ylabel('Count');
title('Histogram of length of series S5')



