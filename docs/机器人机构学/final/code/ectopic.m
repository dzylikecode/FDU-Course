clc;clear;close all;
a.pos = [1 2 3]';
b.pos = [1.1, 2.1, 3.1]';
isNear(a, b, 0.5)
a = [1 2 3]';
bs = [1 2 3; 2 3 4; 4 5 6;]';
dist = bs - a % test for bs - a
sum(dist, 1)
rotz(0)
alpha1 = pi/3;
alpha2 = pi/3;
alpha3 = pi/6;
theta1s = 0:pi/20:pi;
theta2s = (0:pi/20:pi) + pi/2;
theta3s = 0:pi/20:pi;
threshold = 1e-1;
as = createLinks(alpha1, alpha2, alpha3, theta1s, theta2s, theta3s, rotz(0));
bs = createLinks(alpha1, alpha2, alpha3, theta1s, theta2s, theta3s, rotz(pi*2/3));
cs = createLinks(alpha1, alpha2, alpha3, theta1s, theta2s, theta3s, rotz(pi*4/3));
%%
abcs = filterABC(as, bs, cs, threshold);
%%
observeABC(abcs)
%%
observeCond(abcs)
%%
observeWorkspace(abcs)
%%
observe(pi/3, pi/3, pi/6, 0:pi/20:pi, 0:pi/20:pi, 0:pi/20:pi, threshold)
%%
observe(pi/180*80, pi/180*10, pi/180*10, 0:pi/20:pi, 0:pi/20:pi, 0:pi/20:pi, threshold);
%%
function observe(alpha1, alpha2, alpha3, theta1s, theta2s, theta3s, threshold)
    as = createLinks(alpha1, alpha2, alpha3, theta1s, theta2s, theta3s, rotz(0));
    bs = createLinks(alpha1, alpha2, alpha3, theta1s, theta2s, theta3s, rotz(pi*2/3));
    cs = createLinks(alpha1, alpha2, alpha3, theta1s, theta2s, theta3s, rotz(pi*4/3));
    abcs = filterABC(as, bs, cs, threshold);

    observeABC(abcs)
    observeCond(abcs)
    observeWorkspace(abcs)
end
function observeABC(abcs)
    ps = [];
    for i = 1:length(abcs)
        abc = abcs(i);
        tmpa = abc.a.pos(:,end);
        % tmpb = abc.a.pos(:,end);
        % tmpc = abc.a.pos(:,end);
        
        % ps = [ps tmpa tmpb tmpc];
        ps = [ps tmpa];
    end
    figure;
    plot3(ps(1, :), ps(2, :), ps(3, :), 'co');
end

function observeWorkspace(abcs)
    % bad1 = [];
    % bad2 = [];
    % bad3 = [];
    % badJ = [];
    % good = [];
    spaces = cell(1, 5);
    indexJ = 4;
    indexD = 5;
    
    colors = ['r', 'g', 'y', 'k', 'c'];

    for i = 1:length(abcs)
        abc = abcs(i);
        if abc.ectopicType              == 'J'
            tmpa = abc.a.pos(:,end);
            % tmpb = abc.a.pos(:,end);
            % tmpc = abc.a.pos(:,end);
            % spaces{indexJ} = [spaces{indexJ} tmpa tmpb tmpc];
            spaces{indexJ} = [spaces{indexJ} tmpa];
        elseif isempty(abc.ectopicType)
            tmpa = abc.a.pos(:,end);
            % tmpb = abc.a.pos(:,end);
            % tmpc = abc.a.pos(:,end);
            % spaces{indexD} = [spaces{indexD} tmpa tmpb tmpc];
            spaces{indexD} = [spaces{indexD} tmpa];
        else
            indexB = length(abc.ectopicType);
            tmpa = abc.a.pos(:,end);
            % tmpb = abc.a.pos(:,end);
            % tmpc = abc.a.pos(:,end);
            % spaces{indexB} = [spaces{indexB} tmpa tmpb tmpc];
            spaces{indexB} = [spaces{indexB} tmpa];
        end
    end

    figure;
    for i = 1:length(spaces)
        space = spaces{i};
        if isempty(space)
            continue;
        end
        plot3(space(1,:), space(2,:), space(3,:), 'o', 'Color',colors(i));
        hold on;
    end
    hold off;
end

function observeCond(abcs)
    conds    = [];
    
    for i = 1:length(abcs)
        abc = abcs(i);
        if (isempty(abc.ectopicType))
            tmp = [i];
            conds = [conds, tmp];
        end
    end
    figure;
    stem(conds);
end

function newObj = updateWorkspace(obj)
    if obj.a.isEctopic || obj.b.isEctopic || obj.c.isEctopic
        obj.m           = zeros(5);
        obj.cond        = NaN;
        obj.ectopicType = [
            IfElse(obj.a.isEctopic, 'a', '')...
            IfElse(obj.b.isEctopic, 'b', '')...
            IfElse(obj.c.isEctopic, 'c', '')...
            ];
    else
        obj.m = motionMatrix(obj.a.G, obj.b.G, obj.c.G);
        obj.cond = cond(obj.m);
        if isnan(obj.cond) || isEctopic(obj.cond)
            obj.ectopicType = 'J';
        else
            obj.ectopicType = '';
        end
    end
    newObj = obj;
end

function res = IfElse(cond, t, f)
    if cond
        res = t;
    else
        res = f;
    end
end


function m = motionMatrix(a, b, c)
    m = [];

    m(1,:) = a(1, :);
    m(2,:) = b(1, :);
    m(3,:) = a(3, :);
    m(4,:) = b(3, :);
    m(5,:) = c(3, :);
end

function newObj = updateLinkState(obj)
    rot1 = obj.pos(:, 1);
    rot2 = obj.pos(:, 2);
    rot3 = obj.pos(:, 3);

    mov1 = rotz(pi/2) * rot1;
    mov2 = rotz(pi/2) * mov1;

    obj.J = [
              0,        0, rot1(1), rot2(1), rot3(1);
              0,        0, rot1(2), rot2(2), rot3(2);
              0,        0, rot1(3), rot2(3), rot3(3);
        mov1(1),  mov2(1),       0,       0,       0;
        mov1(2),  mov2(2),       0,       0,       0;
        mov1(3),  mov2(3),       0,       0,       0;
        ];
    obj.hatJ        = obj.J(1:end-1,:);
    obj.isEctopic   = isEctopic(cond(obj.hatJ));
    if ~obj.isEctopic
        obj.G = inv(obj.hatJ);
    else
        obj.G = zeros(size(obj.J));
    end
    newObj = obj;
end

function res = isEctopic(c)
    res = c > 1e12;
end

function abcs = filterABC(as, bs, cs, threshold)
    pbs = zeros(3, length(bs));
    for i = 1:length(bs)
        pbs(:, i) = bs(i).pos(:,end);
    end

    pcs = zeros(3, length(cs));
    for i = 1:length(cs)
        pcs(:, i) = cs(i).pos(:,end);
    end

    abcs = [];

    for i = 1:length(as)
        a = as(i).pos(:,end);
        bClosest = filterClosest(a, pbs, threshold);
        cClosest = filterClosest(a, pcs, threshold);
        if bClosest.isNear && cClosest.isNear && compareClosetPoint(bClosest, cClosest, threshold)
            abcs = [abcs workspace(as(i), bs(bClosest.index), cs(cClosest.index))];
        end
    end
end

function obj = workspace(a, b, c)
    obj = struct;
    obj.a = updateLinkState(a);
    obj.b = updateLinkState(b);
    obj.c = updateLinkState(c);

    obj = updateWorkspace(obj);
end

function near = isNear(a, b, threshold)
    aPos = a.pos(:,end);
    bPos = b.pos(:,end);
    near = sum((aPos - bPos).^2) < threshold^2;
end

function closest = filterClosest(a, bs, threshold)
    closest = struct;

    differences = bs - a;
    distances = sum(differences.^2, 1);
    [minDistance, index] = min(distances);

    closest.isNear      = minDistance < threshold^2;
    closest.index       = index;
    closest.pos         = bs(:, index);
end

function isNear = compareClosetPoint(bClosest, cClosest, threshold)
    difference = bClosest.pos - cClosest.pos;
    distance = sum(difference.^2, 1);
    isNear = distance < threshold^2;
end

function obj = LinkState(alpha1, alpha2, alpha3, theta1, theta2, theta3, posM)
    obj         = struct; %% read only once created, it's fine to add properties
    obj.alpha1  = alpha1;
    obj.alpha2  = alpha2;
    obj.alpha3  = alpha3;
    obj.theta1  = theta1;
    obj.theta2  = theta2;
    obj.theta3  = theta3;
    obj.posM    = posM;

    obj         = updateObj(obj);
end

function ls = createLinks(alpha1, alpha2, alpha3, theta1s, theta2s, theta3s, posM)
    ls = [];
    for theta1 = theta1s
        for theta2 = theta2s
            for theta3 = theta3s
                l = LinkState(alpha1, alpha2, alpha3, theta1, theta2, theta3, posM);
                ls = [ls l];
            end
        end
    end
end

function newObj = updateObj(obj)
    trans1to2 = rotx(obj.theta1) * rotz(obj.alpha1);
    trans2to3 = rotx(obj.theta2) * rotz(obj.alpha2);    trans1to3 = trans1to2 * trans2to3;
    trans3to4 = rotx(obj.theta3) * rotz(obj.alpha3);    trans1to4 = trans1to3 * trans3to4;

    pos1 = [1 0 0]';
    pos2 = trans1to2 * pos1;
    pos3 = trans1to3 * pos1;
    pos4 = trans1to4 * pos1;

    posM = obj.posM;

    obj.pos = [posM * pos1, posM * pos2, posM * pos3, posM * pos4];

    newObj = obj;
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