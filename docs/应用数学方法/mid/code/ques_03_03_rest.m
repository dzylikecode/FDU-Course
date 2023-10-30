clear; clc; close all;
times = 1000;
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
function ys = difference(func, x0, numIterates)
    ys = zeros(1, numIterates);
    ys(1) = func(x0);
    for i = 2:1:numIterates
        ys(i) = func(ys(i-1));
    end
end

function observe(func, x0, times, imgName)
    ys = difference(func, x0, times);
    ns = 0:1:times;
    ys = [x0 ys];
    stem(ns, ys);
    syms x;
    f_latex = sprintf('$%s$', latex(simplify(func(x))));
    infoTitle = sprintf('%s with $x_0=%0.2f$', f_latex, x0);
    title(infoTitle, 'Interpreter','latex');
    hold off;
    [~, filename, ~] = fileparts(matlab.desktop.editor.getActiveFilename);
    saveas(gcf, sprintf('../figure/%s_%s.png', filename, imgName));
    %% observe Lyapunov
    Ls = estimateL(func, ys)
end

function dotysprod = estimateL(func, ys)
syms x;
fp = diff(func, x);
fp_mat = matlabFunction(fp);
dotys = abs(fp_mat(ys));
dotysprod = intermediateProduct(dotys);
end

function ysp = intermediateProduct(ys)
    ysp(1) = ys(1);
    for k = 2:length(ys)
        ysp(k) = ysp(k-1) * ys(k);
        ysp(k) = ysp(k)^(1/k);
    end
end