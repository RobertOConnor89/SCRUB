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
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1)); %25x401
Theta2_grad = zeros(size(Theta2)); %10x26

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%
%add bias term for first layer

A1 = [ones(1,size(X,1)); X']; %401x5000

%feed forward to second layer

Z2 = Theta1*A1; %25x5000

%take sigmoid of second layer and add bias term

A2 = [ones(1,size(Z2,2)); sigmoid(Z2)]; %26x5000

%feed forward to third layer

Z3 = Theta2*A2; %10x5000

%compute sigmoid of third layer

H = sigmoid(Z3'); %10x5000

%convert y from a vector of labels into a matrix of row vectors where 
%the class of the vector is indicated by a '1' at that column index 

Y = zeros(size(y,1),size(H,2)); %10x5000

for j = 1:size(y,1)
  Y(j,y(j)) = 1; %10x5000
end

%compute J(Theta)
for i = 1:size(y,1)
  J += (1/m)*(-Y(i,:)*log(H(i,:)')-(1-Y(i,:))*...
  log(1-H(i,:))');
end

%add regularization to cost function
J += lambda/(2*m)*(sum(sum(Theta1(:,2:size(Theta1,2)).^2))+...
sum(sum(Theta2(:,2:size(Theta2,2)).^2)));

%compute unregularized gradients for theta1 and theta2 using 
%the backpropogation algorithm

bigDelOne = zeros(size(Theta1));

bigDelTwo = zeros(size(Theta2));

%compute gradient for the cost function
for t=1:m
  
  delta3 = H(t,:)' - Y(t,:)'; % 10x1
  
  delta2 = (Theta2'*delta3)(2:end).*sigmoidGradient(Z2(:,t)); %25x1
  
  bigDelTwo += delta3*(A2(:,t)'); %10x26
  
  bigDelOne += delta2*(A1(:,t)'); %25x401
  
end

%normalize gradients
Theta1_grad = (1/m)*bigDelOne; %25x401
Theta2_grad = (1/m)*bigDelTwo; %10x26

%regularize gradients
Theta1_grad(:,2:end) += lambda/m*Theta1(:,2:end);

Theta2_grad(:,2:end) += lambda/m*Theta2(:,2:end);














% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
