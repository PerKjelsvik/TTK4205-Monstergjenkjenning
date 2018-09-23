function [train, test, true_class] = data2Table(set)
    fid = fopen(set);
    train = {};
    test  = {};
    row1 = 0;
    row2 = 0;
    iteration = 0;
    true_class = [];

    while ~feof(fid)
        iteration = iteration + 1;
        tline = fgetl(fid);
        [token, remain] = strtok(tline);
        remain = str2num(remain);
        if mod(iteration,2) == 1        % Training set (odd numbered)
            row1 = row1+1;
            train{row1,1} = insertAfter('class-','-',token);
            for i=1:length(remain)
               train{row1,i+1} = remain(i); 
            end
        else                            % Test set (even numbered)
            row2 = row2 + 1;
            test{row2,1} = insertAfter('class-','-',token);
            for i=1:length(remain)
               test{row2,i+1} = remain(i);
            end
            true_class(row2, 1) = str2num(token);
        end
    end

    fclose(fid);

    % Convert cells to tables
    train = cell2table(train);
    test  = cell2table(test);
    train.Properties.VariableNames{1} = 'class';
    test.Properties.VariableNames{1} = 'class';
    for i=2:length(test.Properties.VariableNames)
       train.Properties.VariableNames{i} = insertAfter('var',...
           'r',num2str(i-1));
       test.Properties.VariableNames{i} = insertAfter('var',...
           'r',num2str(i-1));
    end
    
    % Sort sets so that class 1 comes first, then class 2
    train       = sortrows(train,1);
    test        = sortrows(test,1);
    true_class  = sortrows(true_class);
end