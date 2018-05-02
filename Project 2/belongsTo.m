function [truth] = belongsTo(v,a)
%belongsTo checks if the sorted input vector lies in the given array. The
%input variables are 
%1. v: The vector which is to be checked
%2. a: The array it is to be checked against

%The output variables are
%1. truth: The truth value of the check. 
%1 if the sorted array exists in the deck
%0 if the sorted array doesn't exist in the deck

%Check the size of the array
s = size(a);
truth = 0;

%Give an error if the length of the vector is greater than the number of
%columns in the array. 
if length(v) > s(2)
    error('The vector is longer than the rows of the given array')
end

%Sort the array to reduce the number of rows to check the array with
v = sort(v);
for i = 1:s(1)
    if(v == a(i,:)) %If the row is equal to the vector, the vector exists 
                    %in the array
        truth = 1;
        break;
    end
end

