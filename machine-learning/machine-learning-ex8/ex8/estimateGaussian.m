function [mu sigma2] = estimateGaussian(X)
%ESTIMATEGAUSSIAN This function estimates the parameters of a 
%Gaussian distribution using the data in X
%   [mu sigma2] = estimateGaussian(X), 
%   The input X is the dataset with each n-dimensional data point in one row
%   The output is an n-dimensional vector mu, the mean of the data set
%   and the variances sigma^2, an n x 1 vector
% 

  % Store the row/column sizes
  [m, n] = size(X);

  % Compute the mean of the data and the variances. mu(i) is set to the mean of
  % the data for the i-th feature and sigma2(i) to the variance.
  mu = mean(X)(:);
  sigma2 = var(X)(:) .* (m - 1) ./ m; % The var function uses 1/m-1 to calculate variance

end
