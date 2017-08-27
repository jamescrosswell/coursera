function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG Compute cost and gradient for logistic regression with regularization
%   J = COSTFUNCTIONREG(theta, X, y, lambda) computes the cost of using
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

%!test
%! data = load('ex2data2.txt');
%! X = X = mapFeature(data(:,1), data(:,2)); 
%! y = data(:, 3);
%! initial_theta = zeros(size(X, 2), 1);
%! lambda = 1;
%! [J, grad] = costFunctionReg(initial_theta, X, y, lambda);
%! assert(round(J * 1000) / 1000 == 0.693);
%!
%! assert(size(grad) == size(initial_theta));