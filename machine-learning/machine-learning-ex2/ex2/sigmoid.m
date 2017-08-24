function g = sigmoid(z)
%SIGMOID Compute sigmoid function
%   g = SIGMOID(z) computes the sigmoid of z.

  % Compute the sigmoid of each value of z (z can be a matrix, vector or scalar).
  g = 1  ./ (1 + e .^ -z);
  
end

%!test assert (sigmoid(0) == 0.5);
%!test assert (sigmoid(zeros(2,2)) == 0.5 * ones(2,2));
