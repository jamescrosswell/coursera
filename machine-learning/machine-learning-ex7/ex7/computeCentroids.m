function centroids = computeCentroids(X, idx, K)
%COMPUTECENTROIDS returns the new centroids by computing the means of the 
%data points assigned to each centroid.
%   centroids = COMPUTECENTROIDS(X, idx, K) returns the new centroids by 
%   computing the means of the data points assigned to each centroid. It is
%   given a dataset X where each row is a single data point, a vector
%   idx of centroid assignments (i.e. each entry in range [1..K]) for each
%   example, and K, the number of centroids. You should return a matrix
%   centroids, where each row of centroids is the mean of the data points
%   assigned to it.
%

  % Useful variables
  [m n] = size(X);

  % Compute the mean of the data points assigned to each centroid
  centroids = zeros(K, n);
  for j = 1:K
      assigned = X(idx == j,:);
      centroids(j, :) = mean(assigned);
  endfor  

end

%!test
%! load('ex7data2.mat');
%! K = 3; % 3 Centroids
%! initial_centroids = [3 3; 6 2; 8 5];
%! idx = findClosestCentroids(X, initial_centroids);
%! centroids = computeCentroids(X, idx, K);
%! assert(centroids, [ 2.428301 3.157924 ; 5.813503 2.633656 ; 7.119387 3.616684 ], 0.0001);