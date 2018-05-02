%The function Erlang_cust returns a variable with Erlang distribution with
%mean mu, and alpha = n
function [t] = Erlang_cust(mu, n)
    %The function uses the inversion method to give a random variable which
    %follows the PDF of the specified Erlang distribution
    r = rand(1, n);     %Generation of n uniformly distributed random
                        %samples
    r = prod(r);        %Product of the random samples
    t = -log(r)/mu;     %The natural log of the product of the uniformly
                        %distributed random samples divided by the mean
                        %mu gives the Erlang distributed random sample
end

