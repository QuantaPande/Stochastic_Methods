clc;
close all;
clear all;

%Aim    : To simulate poker hands using Monte Carlo approximations
%Name   : Tanmayan Pande
%E-mail : tpande@usc.edu

%Brief Description of the variables and functions used in the program:

%Variables:
%1. deck: The variable which stores the original deck, in order.
%2. suits_flush: A variable needed in the function belongsTo to check if
%the first 5 cards of the set have the same suit.
%3. suits_straight: A variable which checks if the first 5 cards are
%consecutive and in order.
%4. n: the number of times the simulation is to be run
%5. straight_flush: A counter variable for the number of straight flush
%hands
%6. four_of_a_kind: A counter variable for the number of four of a kind hands
%7. full_house: A counter variable for the number of full house hands
%8. flush: A counter variable for the number of flush hands
%9. stright: A counter variable for the number of straight hands
%10. three_of_a_kind: A counter variable for the number of three of a kind
%hands
%11. two_pairs: A counter variable for the number of two pairs hands
%12. one_pairs: A counter variable for the number of one pair hands
%13. ordered_deck: A variable to store each card in the variable deck as a
%combination of suit and value
%14. s: A variable to store the output of the function repeatedValue
%15. p: A container variable for the counts of all hands
%16. high_card: A counter variable to store the values of the high card
%hand
%17. names: A variable to store the names of all hands in string format
%18. final: A table which stores the final format for display

%Functions:
%1. shuffle: The function takes a vector as an input and gives a shuffled
%array as the output.
%2. belongsTo: It checks whether a vector lies in an array as it is. For 
%the purpose of this test, I have sorted the array so that all the cases 
%are covered. It takes the vector and the array as inputs and outputs a 
%boolean value signifying if the vector lies in the array. It is useful in 
%checking if the cards are of the same suit or rank.
%3. repeatedValues: It takes a vector as an input and outputs the repeated
%values and the number of times they are repeated.

deck = 1:52;
suits_flush = [1 1 1 1 1; 2 2 2 2 2; 3 3 3 3 3; 4 4 4 4 4];
suits_straight = [1:9; 2:10; 3:11; 4:12; 5:13]';
n = input('Enter the number of times you want the simulation to run \n');
straight_flush = 0;
straight = 0;
flush = 0;
full_house = 0;
four_of_a_kind = 0;
three_of_a_kind = 0;
two_pairs = 0;
one_pair = 0;
for i = 1:n
    deck = shuffle(deck);
    for j = 1:52
        ordered_deck(j,:) = [ceil((deck(j) - 1)/13), mod((deck(j) - 1), 13) + 1];
    end
    %Check if the suit of the first five cards is the same
    if(belongsTo(ordered_deck(1:5,1)', suits_flush)) 
        %Check if the first five cards are consecutive
        if(belongsTo(ordered_deck(1:5, 2)', suits_straight))
            straight_flush = straight_flush + 1;
        end
    end
    %Check if the first five carda have the same suit
    if(belongsTo(ordered_deck(1:5, 1)', suits_flush))
        flush = flush + 1;
    end
    %Check if the first five cards are consecutive
    if(belongsTo(ordered_deck(1:5, 2)', suits_straight))
        straight = straight + 1;
    end
    s = repeatedValue(ordered_deck(1:5, 2)');
    if(size(s) == [2 2]) 
    %This means there are only two values which repeat. They can't be [5 0]
    %and hence must be [4 1] or [2 3], which are the cases for four of a 
    %kind and full house
        %Check if the hand has 3 values of one rank and two of the another
        if((s(:,2)' == [3 2]) | (s(:,2)' == [2 3]))
            full_house = full_house + 1;
        end
        %Check if the hand has 4 cards of the same hand
        if(s(:,2)' == [4 1] | s(:,2)' == [1 4])
            four_of_a_kind = four_of_a_kind + 1;
        end
    end
    if(size(s) == [3 2])
    %This case corresponds to having 3 different values in the array, out 
    %of which, 2 cases are of importance to us, namely the [3 1 1] case and
    %the [2 2 1] case which correspond to the three of a kind and two pairs
    %case.
        %Check if one card is repeating 3 times.
        if(s(:,2)' == [3 1 1] | s(:,2) == [1 3 1] | s(:, 2) == [1 1 3])
            three_of_a_kind = three_of_a_kind + 1;
        end
        %Check if we have two pairs of cards in the hand
        if(s(:,2)' == [2 2 1] | s(:,2)' == [2 1 2] | s(:,2)' == [1 2 2])
            two_pairs = two_pairs + 1;
        end
    end
    %If the size is [4 2], this means that only one of the value is
    %repeating, which corresponds to the one pair case.
    if(size(s) == [4 2])
        one_pair = one_pair + 1;
    end
end

%Store all the values in an array for easier display
p = [straight_flush four_of_a_kind full_house flush straight three_of_a_kind two_pairs one_pair];

%If a hand doesn't fall in any of the above cases, it must be a high card
%hand.
high_card = n - sum(p);

%Concatenate with the original string to get the final array
p = [p high_card];

%Calculate the probability
prob = p./n;

%The display section
%Store the names of all the cases in the array
names = ["Straight Flush";"Four of a Kind";"Full House";"Flush";"Straight";"Three of a Kind";"Two Pairs";"One Pair";"High Card"];

%Build a table with the names of the hands and the probability values.
final = table(names, prob');
final.Properties.VariableNames = {'Hand', 'Probability'};
disp('The probability of the hands is displayed');
disp(final);