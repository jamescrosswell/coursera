function p = predict(theta, X)
%PREDICT Predict whether the label is 0 or 1 using learned logistic 
%regression parameters theta
%   p = PREDICT(theta, X) computes the predictions for X using a 
%   threshold at 0.5 (i.e., if sigmoid(theta'*x) >= 0.5, predict 1).
%   Since sigmoid(0) == 0.5 this basically means z = h(x) = X  * theta >= 0

  % Make predictions using the learned logistic regression parameters for theta.  
  p = (X * theta) >= 0;

end
