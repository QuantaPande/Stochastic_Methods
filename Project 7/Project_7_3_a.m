clc;
close all;
clear all;

%AIM   : To simulate the queuing system at a bank, specifically the case
%where tellers 2 & 3 handle all types of customers, but teller 1 handles
%only the 

%Name  : Tanmayan Pande
%Email : tpande@usc.edu

%A brief description of the variables used in the program:
% 1. lambda: The arrival rate for customers at the bank
% 2. teller: The status vector for the tellers
% 3. teller_busy: The vector which stores the time till which the teller
%                 will remain busy
% 4. top: The variable which points to the last element in the queue
% 5. count: The iterative variable for the delay of customer type 1
% 6. count2: The iterative variable for the delay of customer type 2
% 7. idle: The time for which the teller is idle
% 8. customer_type: The queue of customers
% 9. delay: The delay experienced by each customer
%10. p: The number of customers which come every minute
%11. r: The random variable which decides the type of the customer
%12. t: The servicing time for a customer
%13. current_j: The time at which a teller starts servicing a customer
%14. delay_end: The time difference for each customer between arrival and
%               service
%15. delay_avg: The average delay experienced by all customers for a
%               specific arrival rate
%16. queue_length: The length of the queue after each minute
%17. queue_length_avg: The average length of the queue for a specific
%                      arrival rate
%18. tot_idle: The total time for which tellers remain idle for a specific
%              arrival rate
%19. I: The variable which stores the location of the shortest queue(s)
%20. delay_end1: The variable to store the value of delays of customer type
%                1 for easier manipulation of the data
%21. delay_end2: The variable to store the value of delays of customer type
%                2 for easier manipulation of the data
%==========================================================================

%Initialization of variables
lambda = 0.1:0.1:10;
tic
for i = 1:length(lambda)
    %Teller 1 is the teller which handles only simple transactions, while
    %tellers 2 and 3 can handle both simple and complex transactions
    teller = zeros(1, 3);
    teller_busy = zeros(1, 3);
    top = zeros(1, 2);
    count = 1;
    count2 = 1;
    customer_type = zeros(2, ceil(5000*lambda(i)));
    delay = zeros(2, ceil(5000*lambda(i)));
    idle = zeros(1, 3);
    for j = 1:10000
        for k = 1:length(teller_busy)
            %Check if the teller is busy, but the service time for the
            %customer is over. If true, then set the teller to free
            if(teller_busy(k) < j)
                teller(k) = 0;
                teller_busy(k) = 0;
            end
            %If the teller is free and the queue is empty, then the teller
            %is idle
            if(top(1) == 0 && k == 1 && teller(k) == 0)
                idle(k) = idle(k) + 1;
                %If the tellers 2 & 3 are free and both queues are empty,
                %the the tellers are idle
            else if(top(2) == 0 && top(1) == 0 && k ~= 1 && teller(k) == 0)
                    idle(k) = idle(k) + 1;
                end
            end
        end
        %The customers arrive according to the Poisson distribution and
        %lambda given by the initial conditions
        p = poissrnd(lambda(i));
        for k = 1:p
            %For each customer, check if they are type 1 or 2
            r = rand();
            %If r is less than 0.25, the customer is type 2. Else, type 1
            if (r <= 0.25)
                %All type 2 customers go in queue 2
                top(2) = top(2) + 1;
                customer_type(2, top(2)) = 2;
                delay(2, top(2)) = 0;
            else
                if(top(1) == 0 && top(2) == 0)
                    %If both queues are empty, type 1 customers can go in
                    %either queue
                    I = randi(2);
                    top(I) = top(I) + 1;
                    customer_type(I, top(I)) = 1;
                    delay(I, top(I)) = 0;
                else
                    %Else, type 1 customers go in queue 1
                    top(1) = top(1) + 1;
                    customer_type(1, top(1)) = 1;
                    delay(1, top(1)) = 0;
                end
            end
        end
        if(top(2) == 0)
            %If queue 2 is empty, increment delay of queue 1 only
            delay(1, :) = delay(1, :) + 1;
        else if(top(1) == 0)
                %If queue 1 is empty, increment delay of queue 2 only
                delay(2, :) = delay(2, :) + 1;
            else if(top(1) == 0 && top(2) == 0)
                    %If both queues are empty, do not increment the delay
                    delay = delay + 0;
                else
                    %Else increment the delay for both queues
                    delay = delay + 1;
                end
            end
        end
        for k = 1:length(teller)
            %Check for each teller if the teller is busy or not
            if(k ~= 1 && teller(k) == 0 && (top(2) > 0 && top(1) > 0))
                %If both queues are not empty, the tellers 2 & 3 can select
                %customer from any queue
                teller(k) = 1;
                I = randi(2);
                if(I == 2)
                    %If the second queue is selected, then each customer is
                    %of type 2. Hence set the service time according to the
                    %distribution of type 2
                    t = Erlang_cust(6, 5);
                    %Shift the customer_type and delay variables to reflect 
                    %the status of the queue
                    customer_type(2, :) = [customer_type(2, 2:end) 0];
                    delay_end(2, count2) = delay(2, 1);
                    count2 = count2 + 1;
                    delay(2, :) = [delay(2, 2:end) 0];
                    %Decrement the top variable to refelct the status of
                    %the queue
                    top(2) = top(2) - 1;
                    %Set current_j to j, so that the teller is busy till
                    %time ceil(current_j + t)
                    current_j = j;
                    teller_busy(k) = t + current_j;
                else
                    %If the first queue is selected, then each customer is
                    %of type 1. Hence set the service time according to the
                    %distribution of type 1
                    t = Erlang_cust(2, 2);
                    %Shift the customer_type and delay variables to reflect 
                    %the status of the queue
                    customer_type(1, :) = [customer_type(1, 2:end) 0];
                    delay_end(1, count) = delay(1, 1);
                    count = count + 1;
                    delay(1, :) = [delay(1, 2:end) 0];
                    %Decrement the top variable to refelct the status of
                    %the queue
                    top(1) = top(1) - 1;
                    %Set current_j to j, so that the teller is busy till
                    %time ceil(current_j + t)
                    current_j = j;
                    teller_busy(k) = t + current_j;
                end
            else if(k ~= 1 && teller(k) == 0 && top(2) == 0 && top(1) > 0)
                    %If queue 2 is empty, then tellers 2 & 3 can service
                    %customers from queue 1. Hence, set the service time
                    %according to the distribution of service time of
                    %customer type 1
                    t = Erlang_cust(2, 2);
                    %Shift the customer_type and delay variables to reflect 
                    %the status of the queue
                    customer_type(1, :) = [customer_type(1, 2:end) 0];
                    delay_end(1, count) = delay(1, 1);
                    count = count + 1;
                    delay(1, :) = [delay(1, 2:end) 0];
                    %Decrement the top variable to refelct the status of
                    %the queue
                    top(1) = top(1) - 1;
                    %Set current_j to j, so that the teller is busy till
                    %time ceil(current_j + t)
                    current_j = j;
                    teller_busy(k) = t + current_j;
                else if(k == 1 && teller(k) == 0 && top(1) > 0)
                        %The teller 1 can service only customers from queue
                        %1. Hence, set the service time according to the
                        %distribution of service time of customer type 1
                        t = Erlang_cust(2, 2);
                        %Shift the customer_type and delay variables to
                        %reflect the status of the queue
                        customer_type(1, :) = [customer_type(1, 2:end) 0];
                        delay_end(1, count) = delay(1,1);
                        count = count + 1;
                        delay(1, :) = [delay(1, 2:end) 0];
                        %Decrement the top variable to refelct the status
                        %of the queue
                        top(1) = top(1) - 1;
                        %Set current_j to j, so that the teller is busy
                        %till time ceil(current_j + t)
                        current_j = j;
                        teller_busy(k) = t + current_j;
                    end
                end
            end
        end
        %Record the average queue length after each time increment j
        queue_length = sum(top)/length(top);
    end
    %Store the average delays and idle times for each customer type and
    %teller respectively
    delay_end1 = delay_end(1, :);
    delay_end2 = delay_end(2, :);
    ind = find(delay_end2(:) == 0);
    delay_end2(ind) = [];
    delay_avg(1, i) = sum(delay_end1)/count;
    delay_avg(2, i) = sum(delay_end2)/count2;
    delay_var(1, i) = sum((delay_end1 - delay_avg(1, i)).^2)/count;
    delay_var(2, i) = sum((delay_end2 - delay_avg(2, i)).^2)/count2;
    queue_length_avg(i) = sum(queue_length)/length(queue_length);
    tot_idle(:, i) = idle;
end

%Display the results
subplot(3,2,1)
plot(lambda, delay_avg(1, :))
xlabel('Arrival Rate in Customers per Minute')
ylabel('Time in Minutes')
title('Delay Experienced by Customer Type 1')
subplot(3,2,2)
plot(lambda, delay_avg(2, :))
xlabel('Arrival Rate in Customers per Minute')
ylabel('Time in Minutes')
title('Delay Experienced by Customer Type 2')
subplot(3,2,3)
plot(lambda, queue_length_avg)
xlabel('Arrival Rate in Customers per Minute')
ylabel('Number of People in Queue')
title('Average Queue Length')
subplot(3,2,4)
plot(lambda, tot_idle(1, :))
xlabel('Arrival Rate in Customers per Minute')
ylabel('Time in Minutes')
title('Idle Time of Teller 1')
subplot(3,2,5)
plot(lambda, tot_idle(2, :))
xlabel('Arrival Rate in Customers per Minute')
ylabel('Time in Minutes')
title('Idle Time of Teller 2')
subplot(3,2,6)
plot(lambda, tot_idle(3, :))
xlabel('Arrival Rate in Customers per Minute')
ylabel('Time in Minutes')
title('Idle Time of Teller 3')

figure
subplot(1,2,1)
plot(lambda, delay_var(1, :))
xlabel('Arrival Rate in Customers per Minute')
ylabel('Variance in minutes squared')
title('Variance in the delay experienced by the Customers of Type 1')
subplot(1,2,2)
plot(lambda, delay_var(2, :))
xlabel('Arrival Rate in Customers per Minute')
ylabel('Variance in minutes squared')
title('Variance in the delay experienced by the Customers of Type 2')
toc

