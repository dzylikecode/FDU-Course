xs = arrayfun(@(i) sym(sprintf("X_%d", i)), 0:7)
transformProgress(xs)
%%
function transformProgress(xs)
theta = xs;                                     ; theta
while getCols(theta) ~= 1
                                                ; disp('---------' + string(getRows(theta)));
    [alpha, beta] = partition2(theta);           ; a = observe(alpha), b = observe(beta)
    theta = [alpha; beta];                      ; o = observe(theta)
end
end

function [evenIdxElems, oddIdxElems] = partition(xs)
evenIdxElems = xs(:,1:end/2);
oddIdxElems = xs(:,end/2+1:end);
end

function [evenIdxElems, oddIdxElems] = partition2(xs)
evenIdxElems = xs(:,1:2:end);
oddIdxElems = xs(:,2:2:end);
end



function cols = getCols(xs)
cols = size(xs, 2);
end

function rows = getRows(xs)
rows = size(xs, 1);
end

function v = observe(var)
v = var;
latex(var)
end