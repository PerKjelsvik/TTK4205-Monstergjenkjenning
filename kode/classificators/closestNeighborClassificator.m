function [inProgress] = closestNeighborClassificator(train,test, active)
n = size(train.class(:),1);

% Extract x
[x_1, x_2, x_test] = extractX(train, test, active);
x = [x_1 x_2];
b = zeros(n,1);

% Classify objects
for obj=1:n
    min_norm = inf;
    for neighbor=1:n
        obj_norm = norm(x_test(:,obj) - x(:,neighbor));
        if obj_norm < min_norm
            min_norm = obj_norm;
            if neighbor<=length(x_1)
                b(obj) = 1;
            else
                b(obj) = 2;
            end
        end
    end
end

inProgress = b;