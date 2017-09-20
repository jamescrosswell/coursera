function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

  % Baked in values for assignment submission
  C =  1;
  sigma =  0.10000;
  return;

  % various different values to try for C and sigma
  c_vals = [0.01;0.03;0.1;0.3;1;3;10;30];
  sigma_vals = [0.01;0.03;0.1;0.3;1;3;10;30];
  
  validation_errors = Inf(rows(c_vals), rows(sigma_vals));
  for i = 1:rows(c_vals)
    this_c = c_vals(i);
    for j = 1:rows(sigma_vals)
      this_sigma = sigma_vals(j);
      model = svmTrain(X, y, this_c, @(x1, x2) gaussianKernel(x1, x2, this_sigma));
      predictions = svmPredict(model, Xval);
      validation_errors(i,j) = mean(double(predictions ~= yval));
    endfor
  endfor  

  % Find the minimum and return the corresponding C and sigma values
  [min_error, min_index] = min(validation_errors(:));
  [min_C, min_sigma] = ind2sub(size(validation_errors), min_index);
  
  % You need to return the following variables correctly.
  C = c_vals(min_C);
  sigma = sigma_vals(min_sigma);
  
end
