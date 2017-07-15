function [ ] = MethodOfLeastSquares( f1, f2, f3, f4 )
%Uses the Method of Lease Squares to find the best approximation of a
%solution to the given linear system

syms x y

%Extract x, y, and constant from equations to form A and b matrices
f1y = solve(f1,y); f2y = solve(f2,y); 
f3y = solve(f3,y); f4y = solve(f4,y);

x1 = coeffs(f1y); x2 = coeffs(f2y);
x3 = coeffs(f3y); x4 = coeffs(f4y);

f1x = solve(f1,x); f2x = solve(f2,x); 
f3x = solve(f3,x); f4x = solve(f4,x);

y1 = coeffs(f1x); y2 = coeffs(f2x);
y3 = coeffs(f3x); y4 = coeffs(f4x);

if size(x3) ~= 2
    x3 = [0 x3];
    y3 = [0 y3];
end
if size(x4) ~= 2
    x4 = [0 x4];
    y4 = [0 y4];
end

b = [x1(1); x2(1); x3(1); x4(1)];
Ax = [x1(2); x2(2); x3(2); x4(2)];
Ay = [y1(2); y2(2); y3(2); y4(2)];
A = [Ax Ay];

%Now that the matrices have been formed, perform calculations
step1 = A'*A;
step2 = inv(step1);
step3 = A'*b;
step4 = double(step2*step3)


%Plot results
ezplot(f1y)
hold on
ezplot(f2)
hold on
ezplot(f3)
hold on
ezplot(f4)
hold on
scatter(step4(1), step4(2))

end

