function sim = gaussianKernel(x1, x2, sigma)
%RBFKERNEL returns a radial basis function kernel between x1 and x2
%   sim = gaussianKernel(x1, x2) returns a gaussian kernel between x1 and x2
%   and returns the value in sim

  % Ensure that x1 and x2 are column vectors
  x1 = x1(:); x2 = x2(:); 
  
  % Calculate a guassian distance between the two vectors
  sim = exp( -sum((x1 - x2) .^ 2) / (2 * sigma ^ 2) );    
  
end

%!test
%! x1 = [1 2 1]; x2 = [0 4 -1]; sigma = 2;
%! sim = gaussianKernel(x1, x2, sigma);
%! assert(sim, 0.324652, 0.000001);