function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

  % Initialize some useful values
  m = length(y); % number of training examples

  % ====================== YOUR CODE HERE ======================
  h = X * theta;
  
  % Calulate the regularized linear cost
  J = sum((h - y) .^2)/(2 * m) + lambda * sum(theta(2:end) .^ 2) / (2 * m);
  
  % Calculate the unregularized gradient
  g_unreg = sum((h - y) .* X) / m;
  g_unreg = g_unreg'; % make it a column vector
  
  % Create a regularization vector to apoply to  the gradient, excluding the 
  % x0 bias term
  g_reg = (lambda / m) * theta;
  g_reg(1) = 0;
  
  grad = g_unreg + g_reg;

end

%!test
%! load ('ex5data1.mat');
%! m = size(X, 1);
%! theta = [1 ; 1];
%! [J, grad]  = linearRegCostFunction([ones(m, 1) X], y, theta, 1);
%! assert(J, 303.993, 0.001);
%! assert(grad(1), -15.303016, 0.001);
%! assert(grad(2), 598.250744, 0.001);
