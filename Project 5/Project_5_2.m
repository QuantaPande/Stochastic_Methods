clc;
close all;
clear all;

%AIM    : To simulate slotted aloha technique for immediate first transfer
%and delayed first transfer paradigms
%NAME   : Tanmayan Pande
%E-MAIL : tpande@usc.edu

%A brief description of the variables used

%1. N = Number of packet radios in the system
%2. B = Length of the buffer for each packet radio
%3. lambda = The probability of packet generation
%4. p = Probability of transmission (1 for the IFT case);
%5. Col = Variable to store the number of collisions
%6. Trans = Variable to store the number of transmitted packets
%7. loss1 = Variable to store the number of packets lost at source
%8. buff = The buffer variable for each packet radio
%9. last = The variable which points to the first empty element in the
%buffer queue
%10. packet = The variable which stores the number of packets transferred
%11. transqueue = The 'channel', modelled here as a queue
%12. point = Variable which points to the top of transqueue variable
%13. time = Variable to store the delay in transmission of a packet
%14. mean_k = Mean of all the buffer occupancy states for each buffer for
%the current time slot
%15. mean = Mean of buffer occupancy for the current simulation
%16. loss = Total packets lost due to collision or at source
%17. delay_avg : Average delay for the system.

%Initialisation of the variables
N = input('Enter the number of packet radios in this simulation: ');
B = input('Enter the buffer size for each of the packet radio: ');
lambda = 1/(10*N):0.001:1/N;
p = input('Enter the probability of transmission: ');
Col = zeros(1, length(lambda));
Trans = zeros(1, length(lambda));
loss1 = zeros(1, length(lambda));

%Run the simulation for different values of lambda
for i = 1:length(lambda)
    %Initial the buffer queues and the pointer variables for each
    %simulation
    buff = zeros(N, B);
    last = ones(1, N);
    packet = 0;
    for k = 1:10000
        %Initialize the transfer queue for each iteration. This means, the
        %packets which are not transmitted are dropped
        transqueue = zeros(N, 2);
        point = 1;
        for j = 1:N
            l = rand();
            %If the value of the uniform variable is less than the
            %probablity of packet generation, generate a packet
            if(l <= lambda(i))
                if(last(j) < B + 1)
                    %Packet is generated
                    buff(j, last(j)) = k;
                    last(j) = last(j) + 1;
                else
                    %Packet is lost
                    loss1(i) = loss1(i) + 1;
                end
            end
        end
        for j = 1:N
            %Check if any buffer is full. If yes, then proceed with that
            %buffer
            if(buff(j, B) ~= 0)
                a = rand();
                if(a <= p)
                    %If the value of the uniform random variable is less
                    %than the probability of packet transmission, push the
                    %packet onto the transmission queue
                    transqueue(point, 1) = j;
                    transqueue(point, 2) = buff(j, 1);
                    point = point + 1;
                    %Remove the packet from the buffer and update the
                    %buffer stats
                    last(j) = last(j) - 1;
                    buff(j, :) = [buff(j, 2:end) 0];
                end
            end
        end
        %If the second element in the transfer queue is non-zero, there is
        %more than one element in the transfer queue, i.e the channel. This
        %means a collision has taken place
        if(transqueue(2, 1) ~= 0)
            Col(i) = Col(i) + 1;
        else if(transqueue(1, 1) ~= 0)
                %Else, if the first element of the transfer queue is not
                %empty, and the earlier check failed, then transmit the
                %packet in the first position.
                Trans(i) = Trans(i) + 1;
                time(i, packet + 1) = k - transqueue(1, 2);
                packet = packet + 1;
            end
        end
        mean_k(k) = sum(last)/length(last);
    end
    
    %Calculate the statistics of the simulation
    mean(i) = sum(mean_k)/length(mean_k);
    loss(i) = loss1(i) + Col(i);
    Col(i) = Col(i)/10000;
    Trans(i) = Trans(i)/10000;
    delay_avg(i) = sum(time(i,:))/length(time(i,:));
end

%Display the values
subplot(3,2,1)
plot(lambda, loss)
xlabel('Probability of packet generation')
ylabel('Number of packets lost')
title('Loss v/s probability of arrival')
subplot(3,2,2)
plot(lambda, Trans)
xlabel('Probability of packet generation')
ylabel('Throughput')
title('Throughput v/s probability of arrival')
subplot(3,2,3)
plot(lambda, delay_avg)
xlabel('Probability of packet generation')
ylabel('Time delay in timeslots')
title('Time delay v/s probability of arrival')
subplot(3,2,4)
plot(lambda, loss1)
xlabel('Probability of packet generation')
ylabel('Number of packets lost at source')
title('Loss at source v/s probability of arrival')
subplot(3,2,5)
plot(lambda, Col.*10000)
xlabel('Probability of packet generation')
ylabel('Number of packets lost due to collision')
title('Loss due to collision v/s probability of arrival')
subplot(3,2,6)
plot(lambda, mean)
xlabel('Probability of packet generation')
ylabel('Buffer Occupancy')
title('Buffer Occupancy v/s probability of arrival')