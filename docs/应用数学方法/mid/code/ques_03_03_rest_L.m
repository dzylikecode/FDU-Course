clear; clc; close all;
times = 100000;
f = @(r) @(x) x.*exp(r*(1-x));
observe(f(2.1), 0.1, times, '1_1');
observe(f(2.1), 0.8, times, '1_2');
observe(f(2.1), 1.1, times, '1_3');
observe(f(3), 0.1, times, '2_1');
observe(f(3), 0.8, times, '2_2');
observe(f(3), 1.1, times, '2_3');
observe(f(3.116), 0.1, times, '3_1');
observe(f(3.116), 0.8, times, '3_2');
observe(f(3.116), 1.1, times, '3_3');
%%
%%
function ys = difference(func, x0, numIterates)
    ys = zeros(1, numIterates);
    ys(1) = func(x0);
    for i = 2:1:numIterates
        ys(i) = func(ys(i-1));
    end
end

function observe(func, x0, times, imgName)
    ys = difference(func, x0, times);
    ys = [x0 ys];
    %% observe Lyapunov
    Ls = estimateL(func, ys)
end

function dotysprod = estimateL(func, ys)
syms x;
fp = diff(func, x);
fp_mat = matlabFunction(fp);
dotys = log(abs(fp_mat(ys)));
dotysprod = intermediateSum(dotys);
end

function ysp = intermediateSum(ys)
    ysp(1) = ys(1);
    for k = 2:length(ys)
        ysp(k) = ysp(k-1) + ys(k);
    end
    for k = 1:length(ys)
        ysp(k) = ysp(k) / k;
    end
end