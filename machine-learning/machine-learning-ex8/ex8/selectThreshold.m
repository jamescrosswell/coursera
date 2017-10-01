function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

  bestEpsilon = 0;
  bestF1 = 0;
  F1 = 0;

  stepsize = (max(pval) - min(pval)) / 1000;
  for epsilon = min(pval):stepsize:max(pval)
      
      % Calculate a binary vector of 0's and 1's for the outlier predictions
      % using this value of epsilon
      outliers = pval < epsilon;  
  
      % Sum true positives (i.e. rows where both our prediction and the cross 
      % validation set indicate an anomoly - i.e. a value of 1)
      tp = sum(yval(outliers == 1)); 
      
      % Sum the false positives (i.e. rows we predict as positive (1) but 
      % the cross validation set actually indicates a nevative (0))
      fp = sum(yval(outliers == 1) == 0); 
      
      % Sum the false negatives (i.e. rows we predict as negative (0) but are 
      % actually positive (1))
      fn = sum(yval(outliers == 0)); 
      
      % Now calculate our F1 score      
      precision = tp / (tp + fp);
      recall = tp / (tp + fn);
      F1 = 2 * precision * recall / (precision + recall);

      if F1 > bestF1
         bestF1 = F1;
         bestEpsilon = epsilon;
      end
  end

end

%!test
%! load('ex8data1.mat');
%! [mu sigma2] = estimateGaussian(X);
%! p = multivariateGaussian(X, mu, sigma2);
%! pval = multivariateGaussian(Xval, mu, sigma2);
%! [epsilon F1] = selectThreshold(yval, pval);
%! assert(epsilon, 8.99e-05, 1e-6);
%! assert(F1, 0.875000, 1e-6);
