function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 

  % Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
  % for our 2 layer neural network
  Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                   hidden_layer_size, (input_layer_size + 1));

  Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                   num_labels, (hidden_layer_size + 1));

  % Setup some useful variables
  m = size(X, 1);                   % number of rows
           
  % Feedforward the neural network and return the cost in the variable J. 
  a1 = [ones(1, m); X'];  
  z2 = Theta1 * a1;
  a2 = [ones(1, m); sigmoid(z2)];  
  a3 = sigmoid(Theta2 * a2);  
  h  = a3;

  % we need to the cost for each class (K) - so we first vectorize the prediciton 
  % classes by turning each prediction y into a vector k where k[i] = i == y
  yk = zeros(num_labels, m);
  for i=1:m
    yk(y(i), i)=1;
  endfor

  % follow the form
  J = sum((1 / m) * sum(-yk .* log(h) - (1 - yk) .* log(1 - h))); 
  
  % Regularize the cost function (excluding bias constants in theta - the first elements) 
  J = J + lambda / (2.0 * m) * sum(sum(Theta1(:,2:end) .^ 2));
  J = J + lambda / (2.0 * m) * sum(sum(Theta2(:,2:end) .^ 2));
  
  % Backpropogation to compute the gradients Theta1_grad and Theta2_grad 
  d3 = a3 - yk;  % 10 x m
  d2 = (Theta2(:,2:end)' * d3) .* sigmoidGradient(z2);  % 25 x m - omit the bias

  Theta2_grad = (1/m) * d3 * a2'; % mean of the gradients for each training example
  Theta1_grad = (1/m) * d2 * a1'; % mean of the gradients for each training example
    
  % Regularization with the cost function and gradients.
  Theta2_grad = Theta2_grad + ...
                (lambda / m) * ([zeros(size(Theta2, 1), 1), Theta2(:, 2:end)]);
  Theta1_grad = Theta1_grad + ...
                (lambda / m) * ([zeros(size(Theta1, 1), 1), Theta1(:, 2:end)]);

  % Unroll gradients
  grad = [Theta1_grad(:) ; Theta2_grad(:)];
end

%!test
%! input_layer_size  = 400;  
%! hidden_layer_size = 25;   
%! num_labels = 10;          
%! load('ex4data1.mat');
%! m = size(X, 1);
%! load('ex4weights.mat');
%! nn_params = [Theta1(:) ; Theta2(:)];
%!
%! lambda = 0;
%! J = nnCostFunction(nn_params, input_layer_size, hidden_layer_size, ...
%!                    num_labels, X, y, lambda);
%! assert(round(J * 1000000) / 1000000 == 0.287629);
%!
%! lambda = 1;
%! J = nnCostFunction(nn_params, input_layer_size, hidden_layer_size, ...
%!                    num_labels, X, y, lambda);
%! assert(round(J * 1000000) / 1000000 == 0.383770);