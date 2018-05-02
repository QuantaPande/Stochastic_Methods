clc;
close all;
clear all;

lambda = 1:5;
tic
for i = 1:length(lambda)
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
            if(teller_busy(k) < j)
                teller(k) = 0;
                teller_busy(k) = 0;
            end
            if(top(1) == 0 && k == 1 && teller(k) == 0)
                idle(k) = idle(k) + 1;
            else if(top(2) == 0 && k ~= 1 && teller(k) == 0)
                    idle(k) = idle(k) + 1;
                end
            end
        end
        p = poissrnd(lambda(i));
        for k = 1:p
            r = rand();
            if (r <= 0.25)
                top(2) = top(2) + 1;
                customer_type(2, top(2)) = 2;
                delay(2, top(2)) = 0;
            else
                top(1) = top(1) + 1;
                customer_type(1, top(1)) = 1;
                delay(1, top(1)) = 0;
            end
        end
        if(top(2) == 0)
            delay(1, :) = delay(1, :) + 1;
        else if(top(1) == 0)
                delay(2, :) = delay(2, :) + 1;
            else if(top(1) == top(2) == 0)
                    delay = delay + 0;
                else
                    delay = delay + 1;
                end
            end
        end
        for k = 1:length(teller)
            if(k ~= 1 && teller(k) == 0 && top(2) > 0)
                teller(k) = 1;
                t = Erlang_cust(6, 5);
                customer_type(2, :) = [customer_type(2, 2:end) 0];
                delay_end(2, count2) = delay(2, 1);
                count2 = count2 + 1;
                delay(2, :) = [delay(2, 2:end) 0];
                top(2) = top(2) - 1;
                current_j = j;
                teller_busy(k) = t + current_j;
%                 else if(customer_type(2, 1) == 1)
%                         t = Erlang_cust(2, 2);
%                         customer_type(2, :) = [customer_type(2, 2:end) 0];
%                         delay_end(1, count) = delay(2, 1);
%                         count = count + 1;
%                         delay(2, :) = [delay(2, 2:end) 0];
%                         top(2) = top(2) - 1;
%                         current_j = j;
%                         teller_busy(k) = t + current_j;
            else if(k == 1 && teller(k) == 0 && top(1) > 0)
                t = Erlang_cust(2, 2);
                customer_type(1, :) = [customer_type(1, 2:end) 0];
                delay_end(1, count) = delay(1,1);
                count = count + 1;
                delay(1, :) = [delay(1, 2:end) 0];
                top(1) = top(1) - 1;
                current_j = j;
                teller_busy(k) = t + current_j;
                end
            end
        end
        queue_length = sum(top)/length(top);
    end
    delay_avg(1, i) = sum(delay_end(1, :))/length(delay_end(1, :));
    delay_avg(2, i) = sum(delay_end(2, :))/length(delay_end(2, :));
    queue_length_avg(i) = sum(queue_length)/length(queue_length);
    tot_idle(:, i) = idle;
end
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
toc
