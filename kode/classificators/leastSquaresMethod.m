function [inProgress, errRate, confusion] = leastSquaresMethod(train,...
    test, active, true_class)
n = size(train.class(:),1);

% Extract x and preallocate variables
[x_1, x_2, x_test] = extractX(train, test, active);
[d, n_1] = size(x_1);
Y = zeros(n,d+1);
b = zeros(n,1);

% Expand Y and fill out b 
for i=1:n_1
    % For x_1
    Y(i,:) = [1 x_1(:,i)'];
    b(i) = 1;
    
    % For x_2
    Y(n_1+i,:) = [1 x_2(:,i)'];
    b(n_1+i) = -1;
end

% Calculate expanded weight vector a
a = inv(Y'*Y)*Y'*b;

% Classify
classify = zeros(n,1);

for i=1:n
   y = [1 x_test(:,i)']';
   g = a'*y; 
   
   if g >= 0
       classify(i,1) = 1;
   else
       classify(i,1) = 2;
   end
end

% Return result
inProgress = classify;
[errRate, confusion] = getErrRate(classify, true_class);
end