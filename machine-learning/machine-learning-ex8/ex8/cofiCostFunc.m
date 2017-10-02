function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

  % Unfold the U and W matrices from params
  X = reshape(params(1:num_movies*num_features), num_movies, num_features);
  Theta = reshape(params(num_movies*num_features+1:end), num_users, num_features);
              
  % Compute the cost function and gradient for collaborative filtering.
  % Note that R and Y are num_movies × num_users matrices. R(j,i) indicates
  % whether user j has submitted a rating for movie i. If so, the user's actual
  % rating is indicated by Y(i,j)
  h = X * Theta';
  diff = h - Y;
  reg_Theta = lambda * sum(Theta(:) .^ 2) / 2; % Regularize user preference weights
  reg_X = lambda * sum(X(:) .^ 2) / 2; % Regularize the feature weights
  J = sum((diff.^2)(R==1)) / 2 + reg_Theta + reg_X;

  % Calculate the gradient 
  X_grad = diff .* R * Theta + lambda * X;
  Theta_grad = (diff .* R)' * X + lambda * Theta;

  grad = [X_grad(:); Theta_grad(:)];
end

%!test
%! load ('ex8_movies.mat');
%! load ('ex8_movieParams.mat');
%! num_users = 4; num_movies = 5; num_features = 3;
%! X = X(1:num_movies, 1:num_features);
%! Theta = Theta(1:num_users, 1:num_features);
%! Y = Y(1:num_movies, 1:num_users);
%! R = R(1:num_movies, 1:num_users);
%! J = cofiCostFunc([X(:) ; Theta(:)], Y, R, num_users, num_movies, num_features, 0);
%! assert(J, 22.22, 1e-2);          
%!
%! J = cofiCostFunc([X(:) ; Theta(:)], Y, R, num_users, num_movies, num_features, 1.5);     
%! assert(J, 31.34, 1e-2);          
