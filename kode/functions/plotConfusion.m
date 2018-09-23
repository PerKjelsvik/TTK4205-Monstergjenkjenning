function plotConfusion(C, meta)
%{ 
Plot out heatmap from confusion matrix - data constructed like this:

                     _   Data-1     Data-2      Data-3  _
  Nearest Neighbor  |    (...)      (...)       (...)    |
  Mimimum Error     |    (...)      (...)       (...)    |
  Least Squares     |_   (...)      (...)       (...)   _|

%}

n_1 = size(C,1);
n_2 = size(C,2);

fprintf('Confusion matrices of the different classificators');
set = 1;

for col=1:2:n_1
    for row=1:2:n_2
        figure
        h = heatmap(C(row:row+1,col:col+1));
        h.XLabel = 'Predicted class';
        h.YLabel = 'True class';
        h.Title = meta{row,col};
    end
    set = set + 1;
end
end