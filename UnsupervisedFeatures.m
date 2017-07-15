function [] = UnsupervisedFeatures()
%Takes adjacency matrices and examines them to sort

    %Read in the adjacency matrices and place into an array
    numM = 9924;
    adj = cell(1, numM);

    for k = 1:numM
        myfilename = sprintf('A%d', k);
        adj{k} = dlmread(myfilename);
    end
    
    %Allocates memory for the size of x y and z vectors
    x = zeros(1, numM);
    y = zeros(1, numM);
    z = zeros(1, numM);
    
    for i = 1: numM
        x(i) = feature1(adj{i}); %call function for feature 1
        y(i) = feature2(adj{i}); %call function for feature 2
        z(i) = feature3(adj{i}); %call function for feature 3
    end

    %Plot feature points
    scatter3(x,y,z);
    
end

function [x] = feature1(M)
%Feature #1 - Find the mean of the eigenvalues of the Laplacian matrix
    
    %Calculate the Laplacian matrix
    L=diag(sum(M))-M;
    
    %Find the eigenvalues of the Laplacian Matrix
    eigVals =eig(L);
    
    %Take the mean of the eigenvalues
    x = mean(eigVals);

end

function [y] = feature2(M)
%Feature #2 - Compute the average shortest path between nodes 

    %Create a matrix of 0's the size of adjacency matrix
    sizeM = size(M,1);
    d = zeros(sizeM);

    for i=1:sizeM 
        %Using M (current adjacency matrix) and i as starting node for
            %inputs
        d(:, i) = DijkstraAlgorithm(M, i);
    end
   
    d = d(:);
    d = d(d ~= Inf & d ~= 0); %Do not include starting node in average 
                              %calculation or unreachable nodes 
                              %(should not happen, but for safety)
    y = nanmean(d); %sum and average across everything but the diagonal

end

function [z] = feature3(M)
%Feature #3 - Calculate the ditance distribution at each node

    sizeM = size(M,1);

    dij=[]; %Initialize a 0x0 matrix
    %Places vector of shortest paths between nodes into dij
    for i=1:sizeM 
        dij=[dij; DijkstraAlgorithm(M,i)]; 
    end

    dij(find(dij==0))=inf; %Not considering (i-i) node pairs/loops

    %Apply values to the distribution vector and calculate the average
        %distribution
    ddist=[];
    sum = 0;
    count = 0;
    for i=1:sizeM-1 
        ddist(i)=length(find(dij==i)) / (sizeM*(sizeM-1));
        sum = sum + ddist(i);
        count = count + 1;
    end
    
    z = sum/count;
    
end