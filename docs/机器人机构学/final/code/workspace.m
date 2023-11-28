clc; clear;
syms theta
arcs = [60 30 60];
rotx(theta)
rotz(theta) %% just example
arcs = sym('alpha_%d', [1 3])
rots = sym('theta_%d', [1 3])
m = rotationOnSphere(rots, arcs)
mFunc = matlabFunction(m)
mFunc(pi/3, pi/3, pi/6, 0, pi/2, 0) 
mFunc(pi/3, pi/3, pi/6, 0, pi/2, 0) * [1, 0, 0]' % test cases, should be [0 0 1]'
mFunc(pi/3, pi/4, pi/4, 0, pi/2, 0) * [1, 0, 0]'

rangeTheta = 0:0.1:pi;
len = length(rangeTheta);
Trans = [];
count = 1;
for i = 1:len
    for j = 1:len
        for k = 1:len
            Trans(:, :, count) = mFunc(pi/3, pi/3, pi/6, rangeTheta(i) + 0, rangeTheta(j) + pi/2, rangeTheta(k));
            count = count + 1;
        end
    end
end
xyz = [];
for i = 1:size(Trans, 3)
    xyz(:, i) = Trans(:, :, i) * [1 0 0]'; 
end
axis equal
plot3(xyz(1, :), xyz(2, :), xyz(3, :), 'ob')
xyz(1, :).^2 + xyz(2, :).^2 + xyz(3, :).^2
%%
Trans = calcLinkTrans(pi/3, pi/3, pi/6, rangeTheta + 0, rangeTheta + pi/2, rangeTheta);
textRadius = 1.2;
APos = [1 0 0]';
A = product(Trans, APos);
plot3(A(1, :), A(2, :), A(3, :), 'ob')
hold on;
textAPos = APos * textRadius;
text(textAPos(1), textAPos(2), textAPos(3), 'Point A', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

BPos = rotz(pi/3*2)*APos; %% !!!!! 逻辑错误, 应该是 PTP^(-1)B == PTA, 所以应该是 rotz * APos
B = product(Trans, BPos);
plot3(B(1, :), B(2, :), B(3, :), 'og')
textBPos = BPos * textRadius;
text(textBPos(1), textBPos(2), textBPos(3), 'Point B', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

CPos = rotz(pi/3*4)*APos;
C = product(Trans, CPos);
plot3(C(1, :), C(2, :), C(3, :), 'or')
textCPos = CPos * textRadius;
text(textCPos(1), textCPos(2), textCPos(3), 'Point C', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
hold off;

figure;
scatter3(A(1, :), A(2, :), A(3, :), 36, 'b', 'filled', 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.5);
hold on;
scatter3(B(1, :), B(2, :), B(3, :), 'r', 'filled', 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.5);
scatter3(C(1, :), C(2, :), C(3, :), 'g', 'filled', 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.5);

hold off;
parts = intersection3({[1 12 13 123], [2 12 23 123], [3 23 13 123]}, 0.5)
%%
threshold = 1e-1; % 阈值
rangeTheta = 0:pi/15:pi;
Trans = calcLinkTrans(pi/3, pi/3, pi/6, rangeTheta + 0, rangeTheta, rangeTheta);
A = product(Trans, [1 0 0]');
B = product(Trans, rotz(pi/3*2)*[1 0 0]');
C = product(Trans, rotz(pi/3*4)*[1 0 0]');
parts = intersection3({A, B, C}, threshold);

figure;
colors = ['ro'; 'go'; 'mo'; 'bo'; 'yo'; 'ko'; 'co'];
for i=1:length(parts)
    curSets = parts{i};
    if length(curSets) == 0
        continue;
    end
    plot3(curSets(1, :), curSets(2, :), curSets(3, :), colors(i, :)); 
    hold on;
end
hold off;
figure;
ABCpart = parts{7};
plot3(ABCpart(1, :), ABCpart(2, :), ABCpart(3, :), 'co');
%%
threshold = 1e-1; % 阈值
rangeTheta = 0:pi/20:pi;
Trans = calcLinkTrans(pi/3, pi/3, pi/6, rangeTheta + 0, rangeTheta, rangeTheta);
A = product(Trans, [1 0 0]');
B = productP(rotz(pi/3*2), A);
C = productP(rotz(pi/3*4), A);
parts = {A, B, C};

figure;
colors = ['ro'; 'go'; 'bo';];
for i=1:length(parts)
    curSets = parts{i};
    if length(curSets) == 0
        continue;
    end
    plot3(curSets(1, :), curSets(2, :), curSets(3, :), colors(i, :)); 
    hold on;
end
hold off;
%%
observe(pi/3, pi/3, pi/6, 0:pi/20:pi, 0:pi/20:pi, 0:pi/20:pi, threshold);
%%
threshold = 1e-1; % 阈值
rangeTheta1 = 0:pi/20:pi;
rangeTheta2 = 0:pi/10:2*pi;
Trans = calcLinkTrans(pi/3, pi/3, pi/6, rangeTheta, rangeTheta2, rangeTheta2);
A = product(Trans, [1 0 0]');
B = productP(rotz(pi/3*2), A);
C = productP(rotz(pi/3*4), A);
parts = intersection3({A, B, C}, threshold);

figure;
colors = ['ro'; 'go'; 'mo'; 'bo'; 'yo'; 'ko'; 'co'];
for i=1:length(parts)
    curSets = parts{i};
    if length(curSets) == 0
        continue;
    end
    plot3(curSets(1, :), curSets(2, :), curSets(3, :), colors(i, :)); 
    hold on;
end
hold off;
figure;
ABCpart = parts{7};
plot3(ABCpart(1, :), ABCpart(2, :), ABCpart(3, :), 'co');
shp = alphaShape(ABCpart(1, :)', ABCpart(2, :)', ABCpart(3, :)',1);
plot(shp)
%%
observe(pi/180*80, pi/180*10, pi/180*10, 0:pi/20:pi, 0:pi/10:2*pi, 0:pi/10:2*pi, threshold);
%%
observe(pi/3, pi/3, pi/6, 0:pi/20:pi, (0:pi/20:pi)+pi/2, 0:pi/20:pi, threshold);
%%
observe(pi/180*80, pi/180*10, pi/180*10, 0:pi/20:pi, 0:pi/20:pi, 0:pi/20:pi, threshold);
%%
observeWithImg(pi/180*80, pi/180*10, pi/180*10, 0:pi/20:pi, 0:pi/20:pi, 0:pi/20:pi, 1e-1, '80-10-10-180-180-180');
%%
observeWithImg(pi/180*60, pi/180*60, pi/180*30, 0:pi/20:pi, 0:pi/20:pi, 0:pi/20:pi, 1e-1, '60-60-30-180-180-180');
%%
observeWithImg(pi/180*60, pi/180*60, pi/180*30, 0:pi/20:pi, 0:pi/10:2*pi, 0:pi/10:2*pi, 1e-1, '60-60-30-180-360-360');
%%
observeWithImg(pi/180*90, pi/180*30, pi/180*30, 0:pi/20:pi, 0:pi/20:pi, 0:pi/20:pi, 1e-1, '90-30-30-180-180-180');
%%
function observeWithImg(alpha1, alpha2, alpha3, theta1, theta2, theta3, threshold, imgName)
Trans = calcLinkTrans(alpha1, alpha2, alpha3, theta1, theta2, theta3);
A = product(Trans, [1 0 0]');
B = productP(rotz(pi/3*2), A);
C = productP(rotz(pi/3*4), A);
parts = intersection3({A, B, C}, threshold);

figure;
colors = ['ro'; 'go'; 'mo'; 'bo'; 'yo'; 'ko'; 'co'];
for i=1:length(parts)
    curSets = parts{i};
    if length(curSets) == 0
        continue;
    end
    plot3(curSets(1, :), curSets(2, :), curSets(3, :), colors(i, :)); 
    hold on;
end

[~, filename, ~] = fileparts(matlab.desktop.editor.getActiveFilename);

view([0 0]);
saveas(gcf, sprintf('../figure/%s_%s_all_00.png', filename, imgName));

view([45 45]);
saveas(gcf, sprintf('../figure/%s_%s_all_45.png', filename, imgName));

view([0 90]);
saveas(gcf, sprintf('../figure/%s_%s_all_90.png', filename, imgName));

hold off;

figure;
ABCpart = parts{7};
ABCpartUp = [];
for i=1:size(ABCpart, 2)
    curPos = ABCpart(:, i);
    if curPos(3) > 0
        ABCpartUp = [ABCpartUp curPos];
    end
end
figure;
plot3(ABCpartUp(1, :), ABCpartUp(2, :), ABCpartUp(3, :), 'co');

view([0 0]);
saveas(gcf, sprintf('../figure/%s_%s_intersect_00.png', filename, imgName));

view([45 45]);
saveas(gcf, sprintf('../figure/%s_%s_intersect_45.png', filename, imgName));

view([0 90]);
saveas(gcf, sprintf('../figure/%s_%s_intersect_90.png', filename, imgName));


save(sprintf('../cache/%s_%s.mat', filename, imgName), "ABCpartUp");
end

function observe(alpha1, alpha2, alpha3, theta1, theta2, theta3, threshold)
Trans = calcLinkTrans(alpha1, alpha2, alpha3, theta1, theta2, theta3);
A = product(Trans, [1 0 0]');
B = productP(rotz(pi/3*2), A);
C = productP(rotz(pi/3*4), A);
parts = intersection3({A, B, C}, threshold);

figure;
colors = ['ro'; 'go'; 'mo'; 'bo'; 'yo'; 'ko'; 'co'];
for i=1:length(parts)
    curSets = parts{i};
    if length(curSets) == 0
        continue;
    end
    plot3(curSets(1, :), curSets(2, :), curSets(3, :), colors(i, :)); 
    hold on;
end
hold off;

figure;
ABCpart = parts{7};
plot3(ABCpart(1, :), ABCpart(2, :), ABCpart(3, :), 'co');
end

function parts = intersection3(posSets, threshold)
    nums = length(posSets);
    records = {[]};
    for i = 1:nums
        curSet = posSets{i};
        curSetCols = size(curSet, 2);
        records{i} = zeros(curSetCols, nums);
        records{i}(:, i) = 1;
    end

    for i = 1:nums
        curSet = posSets{i};
        for j = i+1:nums
            oneOtherSets = posSets{j};
            for pointI = 1:size(curSet, 2)
                curPoint = curSet(:, pointI);
                for oneOtherPointJ = 1:size(oneOtherSets, 2)
                    oneOtherPoint = oneOtherSets(:, oneOtherPointJ);
                    distances = sum((curPoint - oneOtherPoint).^2, 1);
                    if distances < threshold^2
                        records{i}(pointI, j) = 1;
                        records{j}(oneOtherPointJ, i) = 1;
                        break;
                    end
                end
            end
        end
    end

    parts = {};

    for i = 1:2^nums-1
        parts{i} = [];
    end

    for i = 1:nums
        curSet = posSets{i};
        for j = 1:size(curSet, 2)
            partsI = bi2de(records{i}(j, :));
            parts{partsI} = [parts{partsI} posSets{i}(:, j)];
        end
    end
end

function [Apart, Bpart, ABpart] = intersection(A, B, threshold)
    Apart = [];
    Bpart = [];
    ABpart = [];

    matchedInA = false(1, size(A, 2));
    matchedInB = false(1, size(B, 2));

    for i = 1:size(A, 2)
        pointA = A(:, i);

        distances = sqrt(sum((B - pointA).^2, 1));

        if any(distances < threshold)
            matchedInA(i) = true;
            matchedInB = matchedInB | (distances < threshold);
        end
    end
    
    Apart = A(:, ~matchedInA);
    Bpart = B(:, ~matchedInB);
    ABpart = [A(:, matchedInA) B(:, matchedInB)];
end

function Trans = calcLinkTrans(alpha1, alpha2, alpha3, theta1, theta2, theta3)
arcs = sym('alpha_%d', [1 3]);
rots = sym('theta_%d', [1 3]);
m = rotationOnSphere(rots, arcs);
mFunc = matlabFunction(m);
len = length(theta1);
Trans = [];
count = 1;
for i = 1:len
    for j = 1:len
        for k = 1:len
            Trans(:, :, count) = mFunc(alpha1, alpha2, alpha3, theta1(i), theta2(j), theta3(k));
            count = count + 1;
        end
    end
end
end

function xyz = product(A, pos)
xyz = [];
for i = 1:size(A, 3)
    xyz(:, i) = A(:, :, i) * pos;
end
end

function xyz = productP(A, pos)
xyz = [];
for i = 1:size(pos, 2)
    xyz(:, i) = A * pos(:, i);
end
end

function m = rotationOnSphere(rots, arcs)
    m = eye(3);
    assert(length(rots) == length(arcs));
    len = length(rots);
    for i = 1:len
        m = m * rotx(rots(i)) * rotz(arcs(i));
    end
end

function m = rotx(theta)
    m = rotation_matrix([1 0 0], theta);
end

function m = rotz(theta)
    m = rotation_matrix([0 0 1], theta);
end

function R = rotation_matrix(axis, theta)
    ux = axis(1);
    uy = axis(2);
    uz = axis(3);
    
    u_cross = [0, -uz, uy; uz, 0, -ux; -uy, ux, 0];
    R = eye(3) * cos(theta) + (1 - cos(theta)) * (axis' * axis) + u_cross * sin(theta);
end