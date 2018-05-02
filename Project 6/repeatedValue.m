function [value] = repeatedValue(a)
%The function checks if one or more values are repeated in an array. It
%returns an array of the values repeated and the number of times they were
%repeated. 

%The input variables: 
%1. a = vector which is to be analysed

%The output variables:
%1. value: The first column contains the values which were repeated, while
%the second column contains the number of times tey were repeated.

%Initialization of the different variables
    j = 1;
    match = 0;
    loc = [];
    %The loop continues till a is empty
    while(~isempty(a))
        %Initialization of a row of the value variable
        value(j, :) = [a(1) 0];
        for i = 1:length(a)
            
            %Check if the value of the element in a matches with the value
            %current being checked
            if(a(i) == value(j, 1))
                %increase the counter variable and store the location in an
                %array
                match = match + 1;
                loc = [loc, i];
            end
        end
        
        %Update the row in the value variable to include the number of time
        %the value occurs in the vector
        value(j, :) = [a(1), match];
        match = 0;
        i = 1;
        
        %Drop all the values at the locations stored in the loc variable
        while (loc(end) ~= 0 )
            a(loc(i)) = [];
            loc = loc - loc(i);
            i = i + 1;
        end
        
        %Increment the increment counter
        j = j + 1;
        loc = [];
    end
end
