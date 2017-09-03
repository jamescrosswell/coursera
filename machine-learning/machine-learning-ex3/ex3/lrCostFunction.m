function [J, grad] = lrCostFunction(theta, X, y, lambda)
%LRCOSTFUNCTION Compute cost and gradient for logistic regression with 
%regularization
%   J = LRCOSTFUNCTION(theta, X, y, lambda) computes the cost of using
%   theta as the parameter for regularized logistic regression and the
%   gradient of the cost w.r.t. to the parameters. 

  % Initialize some useful values
  m = length(y); % number of training examples
  param_count = length(theta);
  h = sigmoid(X * theta);

  % Compute the regularized cost of a particular choice of theta.
  cost_reg = lambda / (2.0 * m) * sum(theta(2:param_count) .^ 2);
  J = (1 / m) * sum(-y .* log(h) - (1 - y) .* log(1 - h)) + cost_reg;

  % Compute the cost gradients for each parameter in theta
  grad = 1/m * sum((h - y) .* X)'; 
  
  % Add regularization factor to the gradients for theta(n) where n > 1
  grad_reg = lambda / m * theta;
  grad = [grad(1) ; grad(2:param_count) + grad_reg(2:param_count)];

end
