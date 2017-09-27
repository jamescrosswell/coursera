function [U, S] = pca(X)
%PCA Run principal component analysis on the dataset X
%   [U, S, X] = pca(X) computes eigenvectors of the covariance matrix of X
%   Returns the eigenvectors U, the eigenvalues (on diagonal) in S
%

  % Useful values
  [m, n] = size(X);

  % Compute the covariance matrix and pass this to svd to do the grunt work
  sigma = 1/m * X' * X;
  [U,S,V] = svd(sigma);
  
end

%!test
%! load ('ex7data1.mat');
%! [X_norm, mu, sigma] = featureNormalize(X);
%! [U, S] = pca(X_norm);
%! assert(U(1,1), -0.707107, 1e-6);
%! assert(U(2,1), -0.707107, 1e-6);