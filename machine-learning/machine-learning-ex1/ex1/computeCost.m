function J = computeCost(X, y, theta)
%COMPUTECOST Compute cost for linear regression
%   J = COMPUTECOST(X, y, theta) computes the cost of using theta as the
%   parameter for linear regression to fit the data points in X and y

  % Initialize variables used in the calculation
  m = length(y); % number of training examples

  % Now return the cost for the given values of theta
  J = sum((X * theta - y) .^ 2)/(2*m);

end

%!test
%! data = load('ex1data1.txt');
%! y = data(:, 2); 
%! m = length(y);
%! X = [ones(m, 1), data(:,1)];
%! theta = zeros(2, 1);
%! actual = computeCost(X, y, theta);
%! actual = round(100 * actual)/100; % round to two decimal places
%! assert (actual == 32.07);

