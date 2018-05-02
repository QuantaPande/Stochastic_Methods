function [X, M_n] = shiftn( X_i, n)
%The function shiftn shift the given sequence of size N from -N to +N
%The input variables are X_i, the sequence which is to be shifted and n, th
%e length till which it is to be shifted (defaulted to length of the
%sequence)

%The output variables are X, the shifted sequence and M_n, the means of the
%shifted sequence
    x_s = size(X_i);
    if~((length(x_s) == 2)&&(x_s(1) == 1))                    %Check if the arrays are one dimensional
        error('The arrays must be one-dimensional');
        return;
    end

    if ~exist('n','var')                                     %Check if the variable 'n' has been initialied by the user
        n = length(X_i);
    end
    
    %Initialization of the output variables
    X = zeros(2*n-1, n);                    
    M_n = zeros(1, 2*n - 1);
    
    %The loop for shifting logic
    for i = 1:2*n-1                                         %The problem can be split into two different problems.
        %Logic 1. If iterating variable i is less than or equal to the size 
        %of the sequence, then the series resembles shift in the negative
        %direction, i.e. a new sries of i(n + k).
        if i<=n
            m = 1;
            k = i;
            for j = m:k
                X(i,j) = X_i(n - i + j);
            end
        %Logic 2: If the iterating variable is more than the size of the
        %sequence, the the series resembles a shift in the the positive
        %direction, i. e. a new series i(n - k).
        else
            m = i - n + 1;
            k = n;
            for j = m:k
                X(i, j) = X_i(j - m + 1);
            end
        end
        %Calculate the mean of each new series obtained
        M_n(i) = sum(X(i,:))/(k - m + 1);
    end
end

