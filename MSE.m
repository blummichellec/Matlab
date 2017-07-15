%© 2017 MICHELLE BLUM ALL RIGHTS RESERVED

function [] = MSE( C0, C1, b )
%Fisher LDF is the MSE for a particular choice of b

%Obtain feature points from Project #1
[x,y] = Project1(C0,C1,size(C0,1),size(C1,1));

%Form classes c0 and c1 from feature points
c0 = [(x(1:(size(C0,1))))' (y(1:(size(C0,1))))'];
c1 = [(x((size(C0,1)+1):(size(C0,1)+size(C1,1))))' (y((size(C0,1)+1):(size(C0,1)+size(C1,1))))'];

%Create a column vector of 1's and a column vector of -1's
oneC0 = ones(size(C0,1),1);
oneC1 = ones(size(C1,1),1);
oneC1 = -1*oneC1;

%To create Y, concatenate the vector of 1's with c0, and the vector of -1's
%with c1
Y1 = [oneC0 c0];
Y2 = [oneC1 (-1*c1)];
Y = [Y1; Y2];

%Calculate the pseudoinverse
Yt = (inv(Y'*Y))*Y';
%Plug the pseudoinverse in to find a, which serves as the LDF
a = Yt*b;

%Find the number of misclassifieds
count0 = 0;
%Go through each coordinate of the matrix, take the
%dot product with the seed, and evaluate if less than 0
Dot = Y1*a;
for i=1:size(Dot)
    if Dot(i) < 0
        count0 = count0 + 1; %if less than 0, add to count
    end
end
count1 = 0;
Dot = Y2*a;
for i=1:size(Dot)
    if Dot(i) < 0
        count1 = count1 + 1;
    end
end

%Determine percentage of data points which were properly classified
percentC0 = double((size(C0,1) - count0)/size(C0,1))*100
percentC1 = double((size(C1,1) - count1)/size(C1,1))*100

%Plot C0 feature points in green and C1 feature points in red
scatter(x(1:(size(C0,1))),y(1:(size(C0,1))),[],'g') 
hold on
scatter(x((size(C0,1)+1):size(C0,1)+size(C1,1)),y((size(C0,1)+1):size(C0,1)+size(C1,1)), [], 'r') 
%Plot LDF a
hold on
plot([1 x y]*a == 0)

end

