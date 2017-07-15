% © 2017 MICHELLE BLUM ALL RIGHTS RESERVED

function [ Wi, Wh ] = TrainNN( Label, D, numEpoch, nH, eta )
%Back Propagation
%Learning Algorithm that determines weights to 
%train the XOR neural network

%Parameters:
%eta = 0.05 is a commonly used value for the learning rate
%nH = 2, represents the number of hidden nodes
%D = [1 1;-1 1;-1 -1;1 -1];, represents training data
%Label = [-1 1 -1 1];

%Sample Function Call:
% [Wi, Wh] = TrainNN(Label, D, 10, 2, 0.05)

%Initialize weights to be randomly selected between 2 values
%Set d to equal dimension of data (in our case, 2)
d = size(D,2);
lower = -1/sqrt(d);
upper = 1/sqrt(d);
%Want an Nh x d+1 matrix of weights (d+1 allows inclusion of biased node)
Wi = (upper-lower).*rand(nH,d+1) + lower;
%Initialize out as the number of output nodes needed
out = 1;
%Weights for hidden nodes are a out x nH+1 matrix, where nH+1 now includes
%the biased node
Wh = (upper-lower).*rand(out,nH+1) + lower;

%Begin training
%First for loop: create a permutation of the training data for each epoch
for i = 1: numEpoch
    permList = randperm(size(D,1));
    %Second for loop: goes through each data point
    for j = 1: length(D)
        %x is used to augment the data with 1's
        x = [1 D(permList(j), :)];
        %Call feedNN
        [net, netk, augy, z] = feedNN(Wi, Wh, x);
        
        %Update Wi using steepest descent
        for k = 1: d+1
            for l = 1: nH
                Wi(l,k) = Wi(l,k) - eta*-(Label(permList(j))-z)*...
                    phiDeriv(netk)*Wh(l)*phiDeriv(net(l))*x(k);
            end
        end
        
        %In a similar fashion, update Wh
        for m = 1: nH+1
            Wh(m) = Wh(m) - eta*-(Label(permList(j))-z)*...
                phiDeriv(netk)*augy(m);
        end
    end
end

%Plot the outcome using Plot_NN function
Plot_NN(Wi, Wh, Label, D);

end

