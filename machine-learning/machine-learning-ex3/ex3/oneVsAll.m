function [all_theta] = oneVsAll(X, y, num_labels, lambda)
%ONEVSALL trains multiple logistic regression classifiers and returns all
%the classifiers in a matrix all_theta, where the i-th row of all_theta 
%corresponds to the classifier for label i
%   [all_theta] = ONEVSALL(X, y, num_labels, lambda) trains num_labels
%   logistic regression classifiers and returns each of these classifiers
%   in a matrix all_theta, where the i-th row of all_theta corresponds 
%   to the classifier for label i

  % Some useful variables
  m = size(X, 1); % number of rows
  n = size(X, 2); % number of columns

  % Add ones to the X data matrix (the bias unit)
  X = [ones(m, 1) X];

  % Set Initial theta
  initial_theta = zeros(n + 1, 1);

  % Set options for fminunc
  options = optimset('GradObj', 'on', 'MaxIter', 50);

  % Run fmincg to obtain the optimal theta and cost.
  all_theta = zeros(num_labels, n + 1);
  for c = 1:num_labels
    class_match = (y == c);
    [theta] = fmincg (@(t)(lrCostFunction(t, X, class_match, lambda)), ...
               initial_theta, options);
    all_theta(c,:) = theta';
  endfor

end
