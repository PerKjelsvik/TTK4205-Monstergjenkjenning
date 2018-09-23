function [errRate, confusion] = getErrRate(classified, true_class)
% Set up confusion matrix and other variables
n       = size(classified, 1);      % Number of objects
c       = 2;                        % Number of classes
C       = zeros(c,c);               % Confusion matrix of size cxc
x       = true_class;               % Sorted: [1 1 ... 1 2 2 ... 2]'

% Find number of class 1 and 2 objects
[n_x1, ~]   = find(true_class == 1);
n_x1        = n_x1(end);
n_x2        = length(x)-n_x1;

% Find wrongly classified objects
[wrong, ~]  = find(classified ~= x);        % Wrongly classified objects
errRate     = 1-sum(classified == x)/n;     % Error rate

% Make confusion matrix
C(:,1) = [n_x1 - sum(wrong<=n_x1) ;        sum(wrong<n_x1) ];
C(:,2) = [       sum(wrong>n_x1)  ; n_x2 - sum(wrong>=n_x1)];

confusion = C;

end