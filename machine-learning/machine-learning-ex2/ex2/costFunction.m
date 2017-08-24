function [J, grad] = costFunction(theta, X, y)
%COSTFUNCTION Compute cost and gradient for logistic regression
%   J = COSTFUNCTION(theta, X, y) computes the cost of using theta as the
%   parameter for logistic regression and the gradient of the cost
%   w.r.t. to the parameters.

  % Initialize some useful values
  m = length(y); % number of training examples
  z = X * theta;
  h = sigmoid(z);

  % Compute the cost of a particular choice of theta.
  J = (1 / m) * sum(-y .* log(h) - (1 - y) .* log(1 - h));
  grad = zeros(size(theta));

  % Compute the cost gradients for each parameter in theta
  grad = 1/m * sum((h - y) .* X)'; 
  
end

%!test
%! data = load('ex2data1.txt');
%! X = data(:, [1, 2]); y = data(:, 3);
%! [m, n] = size(X);
%! X = [ones(m, 1) X];
%! initial_theta = zeros(n + 1, 1);
%! [J, grad] = costFunction(initial_theta, X, y);
%! assert(round(J * 1000) / 1000 == 0.693, sprintf("%d", J));
%!
%! assert(size(grad) == size(initial_theta));
