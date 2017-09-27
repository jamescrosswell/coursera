function X_rec = recoverData(Z, U, K)
%RECOVERDATA Recovers an approximation of the original data when using the 
%projected data
%   X_rec = RECOVERDATA(Z, U, K) recovers an approximation the 
%   original data that has been reduced to K dimensions. It returns the
%   approximate reconstruction in X_rec.
%

  % Approximate the original data by projecting back to the original space 
  X_rec = Z * U(:, 1:K)';

end

%!test
%! load ('ex7data1.mat');
%! [X_norm, mu, sigma] = featureNormalize(X);
%! [U, S] = pca(X_norm);
%! K = 1;
%! Z = projectData(X_norm, U, K);
%! X_rec  = recoverData(Z, U, K);
%! assert(X_rec(1, 1:2), [-1.047419  -1.047419], 1e-6);
