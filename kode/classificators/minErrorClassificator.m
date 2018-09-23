function [inProgress, errRate, confusion] = minErrorClassificator(train,...
    test, active, true_class)
n = size(train.class(:),1);
[x_1, x_2, x_test] = extractX(train, test, active);
[d_1, n_1] = size(x_1);
[d_2, n_2] = size(x_2);

% Mean vectors
mu_1 = 1/n_1 * sum(x_1');
mu_2 = 1/n_2 * sum(x_2');
mu_1 = mu_1';
mu_2 = mu_2';

% Covariance matrices
sigma_1 = zeros(d_1);
sigma_2 = zeros(d_2);

for k=1:n_1
    sigma_1 = sigma_1 + (x_1(:,k)-mu_1)*(x_1(:,k)-mu_1)';
end
sigma_1 = 1/n_1 * sigma_1;

for k=1:n_2
    sigma_2 = sigma_2 + (x_2(:,k)-mu_2)*(x_2(:,k)-mu_2)';
end
sigma_2 = 1/n_2 * sigma_2;

% Discriminant function parameters
W_1 = -0.5*inv(sigma_1);
W_2 = -0.5*inv(sigma_2);
w_1 = inv(sigma_1)*mu_1;
w_2 = inv(sigma_2)*mu_2;
w_1_0 = -0.5*mu_1'*inv(sigma_1)*mu_1 - 0.5*log(det(sigma_1)) + log(n_1/n);
w_2_0 = -0.5*mu_2'*inv(sigma_2)*mu_2 - 0.5*log(det(sigma_2)) + log(n_2/n);


% Classifcation
classify = zeros(n,1);

for i=1:n
   g_1 = x_test(:,i)'*W_1*x_test(:,i) + w_1'*x_test(:,i) + w_1_0;
   g_2 = x_test(:,i)'*W_2*x_test(:,i) + w_2'*x_test(:,i) + w_2_0;
   
   g = g_1 - g_2;
   
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