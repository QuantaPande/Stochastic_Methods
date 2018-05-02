function [shuffled_deck] = shuffle(deck)

%The function takes a vector and returns a random permutation of the same
%deck. 

%The input variable: 
%1. deck: The input vector which is to be shuffled

%The output variable:
%1. shuffled_deck: The shuffled vector, a random permutation of the input
%vector
    for i = 1:52 %Repeat the process 52 times, which is the size of the 
    %array
    
        %Choose a random integer from the range of 1 to 52
        j = randi([1, 52]);
        
        %Swap with the ith element in the deck with the element at index
        %number j
        t = deck(j);
        deck(j) = deck(i);
        deck(i) = t;
    end
    
    %return the shuffled deck
    shuffled_deck = deck;
end

