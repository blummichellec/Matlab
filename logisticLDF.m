function [] = logisticLDF(C0,C1)
%Create a logistic LDF line

%Form matrix C (combine all data points)
C = [C0; C1];
label = [zeros(1,size(C0,1)) ones(1,size(C1,1))];

beta0 = [0 0 0];
%Get the estimated b values using fitnlm MATLAB function
table = fitnlm(C,label,@mdl,beta0);

%Extract b values from table
p = table.Coefficients.Estimate;

%Form LDF equation by plugging in b values
syms x y
LDF = (p(1)+p(2).*x+p(3).*y);


%Find the number of misclassifieds
count0 = 0;
%Go through each coordinate of the matrix, take the
%dot product with the seed, and evaluate if less than 0
onesC0 = [ones(size(C0,1),1) C0];
onesC1 = [-1*(ones(size(C1,1),1)) C1];
Dot = onesC0*p;
for i=1:size(Dot)
    if Dot(i) < 0
        count0 = count0 + 1; %if less than 0, add to count
    end
end
count1 = 0;
Dot = onesC1*p;
for i=1:size(Dot)
    if Dot(i) < 0
        count1 = count1 + 1;
    end
end

%Determine percentage of data points which were properly classified
percentC0 = double((size(C0,1) - count0)/size(C0,1))*100
percentC1 = double((size(C1,1) - count1)/size(C1,1))*100

%Plot C0 feature points in green and C1 feature points in red
scatter(C0(:,1),C0(:,2), [],'g') 
hold on
scatter(C1(:,1),C1(:,2), [],'r') 
%Plot LDF
hold on
plot(LDF == 0)

end
