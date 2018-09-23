function [v1, v2, v3] = extractX(train, test, active)
d = size(train.Properties.VariableNames(:),1)-1;
v1 = zeros();
v2 = zeros();

% Making property vectors and test vector
d = size(train.Properties.VariableNames(:),1)-1;
v3 = test{:,2:end};

for i=1:size(train.class(:),1)
   if train.class{i} == 'class-1'
        v1(end+1,1:d) = train{i,2:end};  % Class 1
   else
        v2(end+1,1:d) = train{i,2:end};  % Class 2
   end
end

% Delete first empty row and transpose
v1(1,:) = [];
v2(1,:) = [];
v1 = v1';
v2 = v2';
v3 = v3';

% Remove inactive properties
inactive= active == zeros(1,d);
[~,del] = find(inactive);
if ~isempty(del)                % Only remove if 1 or more is inactive
    for var=length(del):-1:1
        v1(del(var), :) = [];
        v2(del(var), :) = [];
        v3(del(var), :) = [];
    end
end

end