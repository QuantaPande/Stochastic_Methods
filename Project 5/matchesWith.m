function [quantity] = repeatingValue(v, a)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    s = size(a);
    truth = 0;
    match = 0;
    for i = 1:length(a)
        diff = v - a(i);
        if(diff == 0)
            match =  match + 1;
        end
    end
    quantity = match;       
end

