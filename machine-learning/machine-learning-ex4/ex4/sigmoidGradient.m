function g = sigmoidGradient(z)
%SIGMOIDGRADIENT returns the gradient of the sigmoid function
%evaluated at z
  gz = sigmoid(z);
  g = gz .* (1 - gz);
end

%!test 
%! g = sigmoidGradient(0);
%! assert(g == 0.25);