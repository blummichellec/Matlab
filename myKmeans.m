function [] = myKmeans()
%K-Means Clustering Algorithm

%Let k represent the number of clusters desired, for this example, we
%will use k =2
    
%Run unsupervised features program to obtain the 3 feature arrays
[x, y, z] = UnsupervisedFeatures();

%Randomly select initial cluster centroids
k1 = [x(1) y(1) z(1)];
k2 = [x(2) y(2) z(2)];

%Initialize cluster 1 and cluster 2 groupings, which will be used to
%hold the positions of the cluster's contents
clust1 = zeros(size(x,1));
clust2 = zeros(size(x,1));

%Calculate euclidian distances from clusters 1 and 2
for i=3:size(x,1)
    dist1 = sqrt((x(i)-k1(1))^2+(y(i)-k1(2))^2+(z(i)-k1(3))^2);
    dist2 = sqrt((x(i)-k2(1))^2+(y(i)-k2(2))^2+(z(i)-k2(3))^2);
    %Assign point to cluster depending on which distance produced minimum
    %value and update centroid accordingly
    if (dist1 < dist2)
        %Cluster 1
        clust1(i) = i;
        k1(1) = mean(k1(1),x(i));
        k1(2) = mean(k1(2),y(i));
        k1(3) = mean(k1(3),z(i));
    else
        %Cluster2
        clust2(i) = i; 
        k2(1) = mean(k1(1),x(i));
        k2(2) = mean(k1(2),y(i));
        k2(3) = mean(k1(3),z(i));
    end 
end 

%Display final centroid values for clusters
centroid1 = k1
centroid2 = k2

%Remove 0's from cluster 1 and 2 positions
finalClust1 = clust1(clust1~=0);
finalClust2 = clust2(clust2~=0);

%Set colors
greenx = zeros(size(finalClust1,1));
greeny = zeros(size(finalClust1,1));
greenz = zeros(size(finalClust1,1));
for i=1:size(finalClust1,1)
    greenx(i) = x(finalClust1(i));
    greeny(i) = y(finalClust1(i));
    greenz(i) = z(finalClust1(i));
end
redx = zeros(size(finalClust2,1));
redy = zeros(size(finalClust2,1));
redz = zeros(size(finalClust2,1));
for i=1:size(finalClust1,1)
    redx(i) = x(finalClust1(i));
    redy(i) = y(finalClust1(i));
    redz(i) = z(finalClust1(i));
end

%Plot feature points
scatter3(greenx,greeny,greenz, [], 'g')
hold on
scatter3(redx,redy,redz, [], 'r')

end

