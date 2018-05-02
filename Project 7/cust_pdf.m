function [x] = cust_pdf(noOfSamples)
%The function cust_pdf gives random values which follow the PDF given by
%f_x(x) = c*sin(x), with C = 1/2. The function uses the inversio nmethod to
%generate the values. The input argument is the number of samples required,
%while the output is the random sequence.
%List of variables used:
% 1. U = Uniform random variable generated using inbuilt functions
% 2. x = Random samples generated
% 3. noOfSamples = Number of samples required
%==========================================================================
U = rand(1, noOfSamples);
x = acos(1 - 2*U);
end

