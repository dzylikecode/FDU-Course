clear;clc;close all;
r = 2;
f1 = @(x) x.*exp(r*(1-x));
observe(f1, 0.8, 100, [0, 2], [0, 2], 100, [0, 2], [0, 2], '1_x0_1');
observe(f1, 1.2, 100, [0, 2], [0, 2], 100, [0, 2], [0, 2], '1_x0_2');


function observe(func, x0, times1D, xSpan1D, ySpan1D, times2D, xSpan2D, ySpan2D, id)
id1D = sprintf('%s_1D.gif', id);
id2D = sprintf('%s_2D.gif', id);
observe1D(func, x0, times1D, xSpan1D, ySpan1D, id1D);
observe2D(func, x0, times2D, xSpan2D, ySpan2D, id2D);
end

function observe2D(func, x0, times, xSpan, ySpan, id)
frames = getFramesOfPhase2D(func, x0, times, xSpan, ySpan);
imgs = frames2ims(frames);
% animate the frames
% animateImgs(imgs);
filename = formatFilename(id);
saveGif(filename, imgs);
end

function observe1D(func, x0, times, xSpan, ySpan, id)
frames = getFramesOfPhase1D(func, x0, times, xSpan, ySpan);
imgs = frames2ims(frames);
% animate the frames
% animateImgs(imgs);
filename = formatFilename(id);
saveGif(filename, imgs);
end

function imgs = frames2ims(frames)
for i = 1:length(frames)
    imgs{i} = frame2im(frames(i));
end
end

function animateImgs(imgs)
for i = 1:length(imgs)
    image(imgs{i});
    drawnow
    pause(0.1);
end
end

function frames = getFramesOfIteration2D(hfig, func, x0, times)
% set the figure
figure(hfig);
% set(hfig, 'Visible','off');
hold on;
% draw the progress of the iteration
r = zeros(1, times+1);
r(1)=x0;
for i = 1:times
    r(i+1)=func(r(i));
    if i==1
        quiver(r(i),r(i),0,r(i+1)-r(i),'off','red','LineWidth',1);
    else
        quiver([r(i-1),r(i)],[r(i),r(i)],[r(i)-r(i-1),0],[0,r(i+1)-r(i)],'off','red','LineWidth',1);
    end
    scatter(r(i),r(i+1),'b','LineWidth',2);
    syms x;
    title(sprintf('2D Phase of $f(x)=%s$ starting with $x_0=%.2f$ and iterating %d times.', latex(simplify(func(x))), x0, i), 'Interpreter','latex');
    frames(i) = getframe(hfig);
    drawnow
end
hold off;
% set(hfig, 'Visible','on');
end

function frames = getFramesOfPhase2D(func, x0, times, xSpan, ySpan)
% set the figure
hfig = figure;
xs = xSpan(1):0.1:xSpan(2);
plot(xs,func(xs),'LineWidth',1.5,'Color','k');
hold on;
plot(xs,xs,'LineWidth',1.5,'Color','k');
xlim(xSpan);
ylim(ySpan);
syms x;
title(sprintf('2D Phase of $f(x)=%s$ starting with $x_0=%.2f$ and iterating %d times.', latex(simplify(func(x))), x0, 0), 'Interpreter','latex');
rawFrame = getframe(hfig);
drawnow
iterFrames = getFramesOfIteration2D(hfig, func, x0, times);
frames = [rawFrame, iterFrames];
end

function frames = getFramesOfIteration1D(hfig, func, x0, times)
% set the figure
figure(hfig);
hold on;
% draw the progress of the iteration
curX=x0;
scatter(x0,0,'b','LineWidth',2);
for i = 1:times
    nxtX=func(curX);
    circArrow(curX, nxtX);
    scatter(nxtX,0,'b','LineWidth',2);
    syms x;
    title(sprintf('1D Phase of $f(x)=%s$ starting with $x_0=%.2f$ and iterating %d times.', latex(simplify(func(x))), x0, i), 'Interpreter','latex');
    frames(i) = getframe(hfig);
    drawnow
    curX = nxtX;
end
hold off;
end

function frames = getFramesOfPhase1D(func, x0, times, xSpan, ySpan)
% set the figure
hfig = figure;
xs = xSpan(1):0.1:xSpan(2);
ys = zeros(1, length(xs));
plot(xs, ys, 'LineWidth', 1.5, 'Color', 'k');
xlim(xSpan);
ylim(ySpan);
rawFrame = getframe(hfig);
drawnow
iterFrames = getFramesOfIteration1D(hfig, func, x0, times);
frames = [rawFrame, iterFrames];
end

% [circular_arrow - File Exchange - MATLAB Central](https://www.mathworks.com/matlabcentral/fileexchange/59917-circular_arrow?s_tid=srchtitle)
% start: arrow_angle - angle
% end  : arrow_angle
function circular_arrow(figHandle, radius, centre, arrow_angle, angle, direction, colour, head_size, head_style)
% This is a function designed to draw a circular arrow onto the current
% figure. It is required that "hold on" must be called before calling this
% function.
%
% The correct calling syntax is:
%   circular_arrow(height, centre, angle, direction, colour, head_size)
%   where:
%       figHandle - the handle of the figure to be drawn on.
%       radius - the radius of the arrow.
%       centre - a vector containing the desired centre of the circular
%                   arrow.
%       arrow_angle - the desired orientation angle of the circular arrow.
%                   This is measured in degrees counter-clockwise
%       angle - the angle between starting and end point of the arrow in
%                   degrees.
%       direction - variable set to determine format of arrow head. Use 1
%                   to get a clockwise arrow, -1 to get a counter clockwise
%                   arrow, 2 to get a double headed arrow and 0 to get just
%                   an arc.
%       colour (optional) - the desired colour of the arrow, using Matlab's
%                   <a href="matlab:
%                   web('https://au.mathworks.com/help/matlab/ref/colorspec.html')">Color Specification</a>.
%       head_size (optional) - the size of the arrow head.
%       head_style (optional) - the style of the arrow head.
%                   For more information, see <a href="matlab:
%                   web('http://au.mathworks.com/help/matlab/ref/annotationarrow-properties.html#property_HeadStyle')">Annotation Arrow Properties</a>.
%Ensure proper number of arguments
if (nargin < 6)||(nargin > 9)
    error(['Wrong number of parameters '...
        'Enter "help circular_arrow" for more information']);
end
% arguments 7, 8 and 9 are optional,
if nargin < 9
    head_style = 'vback2';
end
if nargin < 8
    head_size = 10;
end
if nargin < 7
    colour = 'k';
end
% display a warning if the headstyle has been specified, but direction has
% been set to no heads
if nargin == 9 && direction == 0
    warning(['Head style specified, but direction set to 0! '...
        'This will result in no arrow head being displayed.']);
end

% Check centre is vector with two points
[m,n] = size(centre);
if m*n ~= 2
    error('Centre must be a two element vector');
end
arrow_angle = deg2rad(arrow_angle); % Convert angle to rad
angle = deg2rad(angle); % Convert angle to rad
xc = centre(1);
yc = centre(2);
% Creating (x, y) values that are in the positive direction along the x
% axis and the same height as the centre
x_temp = centre(1) + radius;
y_temp = centre(2);
% Creating x & y values for the start and end points of arc
x1 = (x_temp-xc)*cos(arrow_angle+angle/2) - ...
    (y_temp-yc)*sin(arrow_angle+angle/2) + xc;
x2 = (x_temp-xc)*cos(arrow_angle-angle/2) - ...
    (y_temp-yc)*sin(arrow_angle-angle/2) + xc;
x0 = (x_temp-xc)*cos(arrow_angle) - ...
    (y_temp-yc)*sin(arrow_angle) + xc;
y1 = (x_temp-xc)*sin(arrow_angle+angle/2) + ...
    (y_temp-yc)*cos(arrow_angle+angle/2) + yc;
y2 = (x_temp-xc)*sin(arrow_angle-angle/2) + ...
    (y_temp-yc)*cos(arrow_angle-angle/2) + yc;
y0 = (x_temp-xc)*sin(arrow_angle) + ...
    (y_temp-yc)*cos(arrow_angle) + yc;
% Plotting twice to get angles greater than 180
i = 1;
% Creating points
P1 = struct([]);
P2 = struct([]);
P1{1} = [x1;y1]; % Point 1 - 1
P1{2} = [x2;y2]; % Point 1 - 2
P2{1} = [x0;y0]; % Point 2 - 1
P2{2} = [x0;y0]; % Point 2 - 1
centre = [xc;yc]; % guarenteeing centre is the right dimension
n = 1000; % The number of points in the arc
v = struct([]);

while i < 3
    v1 = P1{i}-centre;
    v2 = P2{i}-centre;
    c = det([v1,v2]); % "cross product" of v1 and v2
    a = linspace(0,atan2(abs(c),dot(v1,v2)),n); % Angle range
    v3 = [0,-c;c,0]*v1; % v3 lies in plane of v1 and v2 and is orthog. to v1
    v{i} = v1*cos(a)+((norm(v1)/norm(v3))*v3)*sin(a); % Arc, center at (0,0)
    plot(v{i}(1,:)+xc,v{i}(2,:)+yc,'Color', colour) % Plot arc, centered at P0
    i = i + 1;
end
position = struct([]);
% Setting x and y for CW and CCW arrows
if direction == 1
    position{1} = [x2 y2 x2-(v{2}(1,2)+xc) y2-(v{2}(2,2)+yc)];
elseif direction == -1
    position{1} = [x1 y1 x1-(v{1}(1,2)+xc) y1-(v{1}(2,2)+yc)];
elseif direction == 2
    position{1} = [x2 y2 x2-(v{2}(1,2)+xc) y2-(v{2}(2,2)+yc)];
    position{2} = [x1 y1 x1-(v{1}(1,2)+xc) y1-(v{1}(2,2)+yc)];
elseif direction == 0
    % Do nothing
else
    error('direction flag not 1, -1, 2 or 0.');
end
% Loop for each arrow head
i = 1;
while i < abs(direction) + 1
    h=annotation('arrow'); % arrow head
    set(h,'parent', gca, 'position', position{i}, ...
        'HeadLength', head_size, 'HeadWidth', head_size,...
        'HeadStyle', head_style, 'linestyle','none','Color', colour);
    i = i + 1;
end
end

function circArrow(x1, x2)
center = (x1 + x2)/2;
radius = abs(x2 - x1)/2;
if (x1 < x2)
    angle = 180;
else
    angle = -180;
end
circular_arrow(gcf, radius, [center, 0], 90, angle, 1);
end

function saveGif(filename, imgs)
for i = 1:length(imgs)
    [imind,map] = rgb2ind(imgs{i},256);
    if i == 1
        imwrite(imind,map,filename,'gif','LoopCount',Inf,'DelayTime',0.1);
    else
        imwrite(imind,map,filename,'gif','WriteMode','append','DelayTime',0.1);
    end
end
end

function filename = formatFilename(id)
[~, currentName, ~] = fileparts(matlab.desktop.editor.getActiveFilename);
filename = sprintf('../figure/%s_%s', currentName, id);
end