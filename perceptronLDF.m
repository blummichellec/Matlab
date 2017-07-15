% © 2017 MICHELLE BLUM ALL RIGHTS RESERVED

function [] = perceptronLDF( C0,C1,a1 )
%Perceptron
%Starting at seed a1, uses Perceptron method to 
%find LDF of data sets C0 and C1
    
    NegC1 = C1 * -1; %generate -C1 matrix
    %add 1 to each vector in matrix to place into augmented space
    size0 = size(C0);
    size1 = size(C1);
    A0 = [ones(size0(1), 1) C0];
    A1 = [ones(size1(1), 1) NegC1];
    A = [A0; A1];
    d = -1; %initialize d as a negative value
    
    while d ~= 0
        sum = [0 0 0];
        %Go through each coordinate of the matrix, take the
        %dot product with the seed, and evaluate if less than 0
        Dot = A*a1';
        for i=1:size(Dot)
            if Dot(i) < 0
                sum = sum + A(i, :); %if less than 0, add to sum
            end
        end
        %if the sum is 0, no misclassifieds were present, otherwise
        %the new a1 should become the sum of the last a1 and the
        %misclassifieds
        d = sum;
        a1 = sum + a1;
    end
            
        syms x y
        %generate LDF equation, if z = 1, will be set equal to a1(3)
        LDF = (a1(1) * x) + (a1(2) * y) == a1(3);
        %Form explicit solution of LDF equation
        yLDF = solve(LDF, y);
        %Extract the coefficient of x from the explicit LDF equation, which
        %represents the slope
        num = coeffs(yLDF, x);
        m = double(num(2))
        %solve for y-intercept
        b = double(subs(yLDF, x, 0))
        
        %Plot C0 in green, C1 in red
        scatter3(A0(:,1), A0(:,2),A0(:,3),[],'g')
        hold on
        scatter3(A1(:,1), A1(:,2),A1(:,3),[],'r')
        hold on
        ezsurf(LDF)

end

