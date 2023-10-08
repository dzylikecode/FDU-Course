clc; clear;
f = @(c, x) x.^2 + c;
f_curry = @(c) @(x) f(c, x);
figure;
hold on;
labels = [
    draw(@(x) x, 'k');
    draw(f_curry(2), 'b');
    draw(f_curry(1/4), 'r');
    draw(f_curry(0), 'c');
    draw(f_curry(-3), 'g');
    ];
axis equal;
legend(labels, 'Interpreter','latex');
saveas(gcf, formatFilename('1.png'));
hold off;
%%
function f_latex = draw(f, color)
fplot(f, color, [0, 3]);
syms x;
f_latex = sprintf("$%s$", latex(simplify(f(x))));
end
function filename = formatFilename(id)
[~, currentName, ~] = fileparts(matlab.desktop.editor.getActiveFilename);
filename = sprintf('../figure/%s_%s', currentName, id);
end