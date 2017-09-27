function Z = projectData(X, U, K)
%PROJECTDATA Computes the reduced data representation when projecting only 
%on to the top k eigenvectors
%   Z = projectData(X, U, K) computes the projection of 
%   the normalized inputs X into the reduced dimensional space spanned by
%   the first K columns of U. It returns the projected examples in Z.

  % Compute the projection of X onto the K dimensional subspace
  Z = X * U(:, 1:K);
  
end

%!test
%! load ('ex7data1.mat');
%! [X_norm, mu, sigma] = featureNormalize(X);
%! [U, S] = pca(X_norm);
%! K = 1;
%! Z = projectData(X_norm, U, K);
%! assert(Z(1), 1.481, 1e-3);