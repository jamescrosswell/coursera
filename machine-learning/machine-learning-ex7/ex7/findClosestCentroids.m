function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

  % Set K
  K = size(centroids, 1);

  % You need to return the following variables correctly.
  idx = inf(size(X,1), 1);
  
  % Find the closest centroid to each data point
  for i = 1:size(X,1)
    closest = inf;
    for j = 1:K
      d = norm(X(i,:) - centroids(j,:), 2);
      if closest > d 
        closest = d;
        idx(i) = j;
      endif
    endfor  
  endfor  

end

%!test
%! load('ex7data2.mat');
%! K = 3; % 3 Centroids
%! initial_centroids = [3 3; 6 2; 8 5];
%! idx = findClosestCentroids(X, initial_centroids);
%! assert(idx(1:3), [1;3;2]);