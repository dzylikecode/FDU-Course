A = [-1, 1;
     -2, -2];
b = [5;-1];
f = @(x) A * x + b;
x0s = initX0s(9/4, -11/4);

observe(f, 0.01, x0s, 1000, 'phase');
%%
function observe(func, h, x0s, times, imgName)
figure;
for k = 1:size(x0s,2)
    x0 = x0s(:, k);
    xys = EulerIterate(func, h, x0, times);
    plot(xys(1, :), xys(2, :));
    hold on;
end
[~, filename, ~] = fileparts(matlab.desktop.editor.getActiveFilename);
saveas(gcf, sprintf('../figure/%s_%s.png', filename, imgName));
end

function xys = EulerIterate(func, h, x0, times)
    xys = [x0];
    for k = 1:times
        xys(:,k+1) = xys(:,k) + h * func(xys(:,k));
    end
end

function x0s = initX0s(centerx, centery)
left = centerx - 0.5 - 1;
top  = centery + 0.5 + 1;
for k = 0:3
    P0s(:,k+1) = [left + k; top];
end
P1s = [[left; top - 1] [left + 3; top - 1]];
P2s = [[left; top - 2] [left + 3; top - 2]];
for k = 0:3
    P3s(:,k+1) = [left + k; top - 3];
end
x0s = [P0s, P1s, P2s, P3s];
end