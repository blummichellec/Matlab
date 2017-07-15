% Use this function in accordance with my TrainNN function
% © 2017 MARK DEBONIS ALL RIGHTS RESERVED

function [Net, netk, augY, z] = feedNN(Wi, Wh, x)

% x should be biased (i.e. augmented)

% EX: XOR
% Wi = [0.5 1 1;-1.5 1 1];
% Wh = [-1 0.7 -0.4];

% input to hidden
for i = 1:size(Wi,1)
    Net = Wi*x';
    Y = sign(Net);  %for signum function
    %Y = phi(Net);
end

% hidden to output
augY = [1; Y];
netk = Wh*augY;
z = sign(netk);  %for signum function
%z = phi(netk);

end
