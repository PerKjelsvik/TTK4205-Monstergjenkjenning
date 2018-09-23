function [inProgress, properties, C, T] = closestNeighbor(train,test,...
    true_class)
n = size(train.class(:),1);
d = size(train.Properties.VariableNames(:),1)-1;
T = table();

% Make all possible combinations of properties
combinations = getcondvects(d);
combinations(1,:) = [];
classified = zeros(n,size(combinations,1));

% Run closest neighbor and find combination with least errors
min_err = inf;
errRates      = zeros(1,size(combinations,1));

for combo=1:size(combinations,1)
    % Run closest neighbor classificator
    classified(:,combo) = ...
        closestNeighborClassificator(train,test,combinations(combo,:));
    
    % Find the error rate of the classification
    [errRates(combo), confusion] = getErrRate(classified(:,combo),...
        true_class); 
    
    % Update best classification 
    if errRates(combo) < min_err
        min_err = errRates(combo);
        best_combination = combo;
        C = confusion;
    end
end

% Return best combination and accompying classification
properties = combinations(best_combination,:);
inProgress = classified(:, best_combination);

% Sort the combinations of properties and put in Table with error rates
[~, order] = sort(errRates);
errRates = sort(errRates);
combinations = combinations(order', :);
T{:,1} = errRates';
T.Properties.VariableNames{1} = 'Error';

for j=2:d+1
   T{:,j} = combinations(:,j-1);
   T.Properties.VariableNames{j} = insertAfter('var','r',num2str(j-1));
end

end