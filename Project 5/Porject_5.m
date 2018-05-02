clc;
close all;
clear all;

N = input('Enter the number of packet radios in this simulation: ');
B = input('Enter the buffer size for each of the packet radio: ');
disp('Choose which type of system you want to simulate: ');
choose = input('1. Immediate First Transmission \n2. Delayed First Transmission\n');
switch(choose)
    case 1
        p = 1;
        lambda = 1/(2*N):0.01:1/N;
        for i = 1:length(lambda)
            buff = zeros(1,N);
            packet = 0;
            Col(i) = 0;
            Trans(i) = 0;
            for k = 1:10000
                trans_queue = zeros(N,2);
                point = 1;
                for j = 1:N
                    l = rand();
                    if (l <= lambda(i))
                        %Fill Buffer
                        buff(j) = buff(j) + 1;
                        q(j, buff(j)) = k;
                    end
                end
                for j = 1:N
                    if(buff(j) == B)
                        trans_queue(point, 1) = 1;
                        trans_queue(point, 2) = j;
                        point = point + 1;
                    end
                end
                if (trans_queue(2, 1) == 1)
                    Col(i) = Col(i) + 1;
                    trans_queue = zeros(N,2);
                    buff(trans_queue(1, 2)) = buff(trans_queue(1, 2)) - 1;
                else if (trans_queue(1, 1) == 1)
                    Trans(i) = Trans(i) + 1;
                    time(packet + 1) = k - q(trans_queue(1, 2), buff(trans_queue(1, 2)));
                    packet = packet + 1;
                    trans_queue = zeros(N,2);
                    buff(trans_queue(1, 2)) = buff(trans_queue(1, 2)) - 1;
                    end
                end
            end
            Col(i) = Col(i)/10000;
            Trans(i) = Trans(i)/10000;
        end
    case 2
        p = input('Enter the probability of transmission  \n');
        lambda = 1/(2*N):0.01:1/N;
        packet = 0;
        for i = 1:length(lambda)
            buff = zeros(1,N);
            for k = 1:10000
                Col(i) = 0;
                Trans(i) = 0;
                trans_queue = zeros(1,N);
                point = 1;
                for j = 1:N
                    l = rand();
                    if (l <= lambda(i))
                        %Fill Buffer
                        buff(j) = buff(j) + 1;
                        q(j, buff(j)) = k;
                    end
                end
                for j = 1:N
                    if(buff(j) == B)
                        trans_queue(point, 1) = 1;
                        trans_queue(point, 2) = j;
                        point = point + 1;
                    end
                end
                if (trans_queue(2) == 1)
                    Col(i) = Col(i) + 1;
                    trans_queue = zeros(N, 2);
                else if (trans_queue(1) == 1)
                        a = rand();
                        if(a <= p)
                            Trans(i) = Trans(i) + 1;
                            time(packet + 1) = k - q(trans_queue(1, 2), buff(trans_queue(1, 2)));
                            packet = packet + 1;
                            trans_queue = zeros(N, 2);
                        end
                    end
                end
            end
            Col(i) = Col(i)/10000;
            Trans(i) = Trans(i)/10000;
        end
    otherwise
        disp('Enter the correct option');
end
subplot(2,1,1)
plot(lambda, Col)
subplot(2,1,2)
plot(lambda, Trans)
delay_avg = sum(time)/length(time);
disp(delay_avg);
