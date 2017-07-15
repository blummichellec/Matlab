function D = simulate_exp(n,numbins,L)
%Uses the Inverse Transform Method to generate data points for exponential
%distribution
%Input n: number of data points
      %L: Lambda 
      %Numbins: amount of bins used to create the relative freqeuncy
               %ditribution histogram
               
%Inverse Transform Method

X = zeros(size(n,1));
U = zeros(size(n,1));

for i = 1:n

%Generate random number between 0 and 1
U = rand;
%Equation for exponential distribution, F = 1-e^(-L*U);
%X is equal to the inverse of F, which equals the equation below
X(i) = -(1/L)*log(1-U);

end

%Plot exponential pdf versus the histogram
D = X';
fplot(@(x) L*exp(1).^(-L.*x))
hold on
histogram(X,numbins)
axis([-1 10 0 20])

%Compare using MLE
%The estimator is obtained as a solution to a maximization problem
compare = n/sum(X)

end

