function [answer] = SteepestDescent(f,x1,num_iter)
%Uses the method of steepest descent to find the absolute minimum
%f = function for which minimum is desired
%x1 = starting vector "seed"
%num_iter = how many iterations to go through
syms x y
for i = 1:num_iter
    fx = diff(f,x); %Step 1: Partial derivative of f with respect to x
    fy = diff(f,y); %Step 2: Partial derivative of f with respect to y
    %Step 3: Plug current coordinate into partials vector
    step3x = subs(fx,[x y],x1); 
    step3y = subs(fy,[x y],x1);
    %Step 4: Form equation x1-(t)*(point from Step 3)  and form new
             %coordinate that is a function of t
    syms t
    step4x = x1(1) - t * step3x;
    step4y = x1(2) - t * step3y;
    %Step 5: Plug new point into original function
    step5 = subs(f,[x y],[step4x step4y]);
    %Step 6: Take derivative of new function (respect to t)
    step6 = diff(step5,t);
    %Step 7: Set derivative equal to 0 and solve for t
    step7 = double(solve(step6, t));
    ddphi = diff(step6,t);
    evddphi = subs(ddphi,t,step7);
    if evddphi(1) > 0
        step8 = step7(1);
    else
        step8 = step7(2);
    end
    %Step 8: Plug back into x1-(t)*(point) and solve for second iteration
             %point
    step8x = double(x1(1) - step8 * step3x);
    step8y = double(x1(2) - step8 * step3y);
    x1 = [step8x step8y]
end

answer = x1;

end

