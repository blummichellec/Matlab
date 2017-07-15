function [] = PCA(data)
%Using Principle Component Analysis (PCA)
%to compute direction of maximal variance and the corresponding angle 
%associated with the direction 

%Step 1: Find x0 so that the data is zero mean
%Accomplished by setting x0 = m

%Step 2: Find the variance-covariance matrix for the data
n = size(data,1);
sumVar1 = 0; sumVar2 = 0; sumCov = 0;

for i=1:n
  %Variance formula reduces to this when the mean is equal to zero
  var1 = (data(i,1))^2/n;
  var2 = (data(i,2))^2/n;
  sumVar1 = sumVar1 + var1;
  sumVar2 = sumVar2 + var2;
  %Covariance formula reduces to this when the mean is equal to 0
  %Produces a 2x2 matrix (number of columns in data is 2)
  cov = ((data(i,1)) * (data(i,2))) / n;
  sumCov = sumCov + cov;
end

mat = [sumVar1 sumCov; sumCov sumVar2];

%Step 3: Calculate the eigen vectors and eigen values of the
%variance-covariance matrix to produce a new orthagonal coordinate system
%for the matrix (spectral theorem)

[V,D] = eig(mat); %Where V represents eigen vectors and 
                  %D represents eigen values in a diagonal matrix
                 
%The eigen vector with the highest eigen value is the 
%Principle Component of the data 
D = diag(D);
if D(1) > D(2)
    PC = V(:,1)
else
    PC = V(:,2)
end

%Find the angle associated with the direction given by the Principle
%Component
theta = atan2(PC(2,1),PC(1,1))
    
%Project the original data set
[~, indices] = sort(-1*D);
V = V(:, indices);
pro = data * V';

%Find the variance and angle of each projected point
proAngle = zeros(n,1);
var = zeros(n,1);

for i = 1: n
   proAngle(i,1) = atan2(pro(i,2),pro(i,1));
   var(i,1) = (((pro(i,1))^2/n) + ((pro(i,2))^2/n)) / 2;
end

%Plot angle vs. variance
syms x
scatter(proAngle, var);
hold on
vline(theta);

end

