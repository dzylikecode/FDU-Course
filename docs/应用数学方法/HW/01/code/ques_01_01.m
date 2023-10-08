times = 100;
observe(@(x) 3.2*x*(1-x), 0.1000001, times, '1');
observe(@(x) 3.5*x*(1-x), 0.1000002, times, '2');
observe(@(x) 4*x*(1-x), 0.1000003, times, '3');
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
    eq = func(x) == x;
    sol = solve(eq, x);
    hold on;
    line([0, times], [sol(1), sol(1)], 'Color', 'r', 'LineStyle', '-');
    line([0, times], [sol(2), sol(2)], 'Color', 'g', 'LineStyle', '-.');
    text(times/4, sol(1), sprintf('$x_1$ = %f', sol(1)), 'Interpreter','latex');
    text(times/4*3, sol(2), sprintf('$x_2$ = %f', sol(2)), 'Interpreter','latex');
    title(f_latex, 'Interpreter','latex');
    hold off;
    [~, filename, ~] = fileparts(matlab.desktop.editor.getActiveFilename);
    saveas(gcf, sprintf('../figure/%s_%s.png', filename, imgName));
end