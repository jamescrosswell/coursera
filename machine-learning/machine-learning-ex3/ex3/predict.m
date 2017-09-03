function p = predict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

  % Useful values
  m = size(X, 1);   % rows
  num_labels = size(Theta2, 1);

  % You need to return the following variables correctly 
  p = zeros(size(X, 1), 1);
  
  X = [ones(m,1) X];
    
  % Apply our hypothesis to the data to be predicted for each label
  Z2 = sigmoid(X * Theta1');
  Z2 = [ones(m,1) Z2];
  
  Z3 = sigmoid(Z2 * Theta2');
  
  % Find the best ranking hypothesis for each row (i.e the label with the 
  % highest score)... this will be our prediction: p
  [x p] = max(Z3, [], 2);  

end
