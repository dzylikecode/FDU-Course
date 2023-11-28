clear; clc;
R=90;
r=41.57;
L=85;
l=140;

x0=[0,R,R+L,r,0];
y0=[0,0,0,0,0];
z0=[0,0,0,42.3844,42.3811];
x1=[0,R*cos(2*pi/3),(R+L)*cos(2*pi/3),r*cos(2*pi/3),0];
y1=[0,R*sin(2*pi/3),(R+L)*sin(2*pi/3),r*sin(2*pi/3),0];
z1=[0,0,0,42.3844,42.3811];
x2=[0,R*cos(4*pi/3),(R+L)*cos(4*pi/3),r*cos(4*pi/3),0];
y2=[0,R*sin(4*pi/3),(R+L)*sin(4*pi/3),r*sin(4*pi/3),0];
z2=[0,0,0,42.3844,42.3811];
% plot3(x0,y0,-z0,'k','LineWidth',5);
% hold on;
% plot3(x1,y1,-z1,'k','LineWidth',5);
% hold on;
% plot3(x2,y2,-z2,'k','LineWidth',5);
% hold on;
x=zeros(68*68*68,1);
y=zeros(68*68*68,1);
z=zeros(68*68*68,1);
for i=1:2:135
    for j=1:2:135
        for k=1:2:135
            [x((i-1)/2*68*68+(j-1)/2*68+(k+1)/2),y((i-1)/2*68*68+(j-1)/2*68+(k+1)/2),z((i-1)/2*68*68+(j-1)/2*68+(k+1)/2)] = DeltaForwardkinematics((k-46)/180*pi,(j-46)/180*pi,(i-46)/180*pi);
        end
    end
end
v=[x,y,-z];
% v = unique(v,'rows');
shp = alphaShape(v);
plot(shp);
%  f=convhulln(v);
%  patch('vertices',v,'faces',f,'facecolor','c');
% scatter3(x,y,z,'.');
%%
observe(shp, [0, 0], '1')
observe(shp, [45, 45], '2')
observe(shp, [0, 90], '3')
%%
function observe(data, perspect, imgName)
plot(data);
view(perspect);
[~, filename, ~] = fileparts(matlab.desktop.editor.getActiveFilename);
saveas(gcf, sprintf('../figure/%s_%s.png', filename, imgName));
end

function [x,y,z] = DeltaForwardkinematics(theta1,theta2,theta3)
%Delta腿正解
%上固定板半径R=90 脚底半径r=41.57  大腿长度L=85 小腿长度l=140
R=90;
r=41.57;
L=85;
l=140;
a1=[R,0,0];
a2=[-R/2,R*sqrt(3)/2,0];
a3=[-R/2,-R*sqrt(3)/2,0];

a1b1=[L*cos(theta1),0,L*sin(theta1)];
a2b2=[-L/2*cos(theta2),L*cos(theta2)*sqrt(3)/2,L*sin(theta2)];
a3b3=[-L/2*cos(theta3),-L*cos(theta3)*sqrt(3)/2,L*sin(theta3)];

c1o2=[-r,0,0];
c2o2=[r/2,-r*sqrt(3)/2,0];
c3o2=[r/2,r*sqrt(3)/2,0];
o1d1=a1+a1b1+c1o2;
o1d2=a2+a2b2+c2o2;
o1d3=a3+a3b3+c3o2;

o1f=(o1d1+o1d2)/2;

d1d2=o1d2-o1d1;
d1d3=o1d3-o1d1;
d2d3=o1d3-o1d2;
a=norm(d1d2);
b=norm(d1d3);
c=norm(d2d3);
p=(a+b+c)/2;
S=sqrt(p*(p-a)*(p-b)*(p-c));
normd1e=a*b*c/(4*S);
normfe=sqrt(normd1e^2-a^2/4);
dirfe1=cross(cross(d1d2,d1d3),d1d2)/(a*a*b);
dirfe=dirfe1/norm(dirfe1);
fe=normfe*dirfe;
o1e=o1f+fe;
normd1o2=l;
%normd1e=a*b*c/(4*S);
normeo2=sqrt(normd1o2^2-normd1e^2);
direo21=cross(d1d2,d1d3)/(a*b);
direo2=direo21/norm(direo21);
eo2=normeo2*direo2;
o1o2=o1e+eo2;
x=o1o2(1);
y=o1o2(2);
z=o1o2(3);
end
function [theta1,theta2,theta3] = DeltaInversekinematic(x,y,z)
%Delta腿正解
%上固定板半径R=90 脚底半径r=41.57  大腿长度L=85 小腿长度l=140
R=90;
r=41.57;
L=85;
l=140;
z=-z;
m=x^2+y^2+z^2+(R-r)^2+L^2-l^2;
A=[(m-2*x*(R-r))/(2*L)-(R-r-x)
   (m+(R-r)*(x-sqrt(3)*y))/(L)-2*(R-r)-(x-sqrt(3)*y)
   (m+(R-r)*(x+sqrt(3)*y))/(L)-2*(R-r)-(x+sqrt(3)*y)];
B=[2*z
   4*z
   4*z];
C=[(m-2*x*(R-r))/(2*L)+(R-r-x)
   (m+(R-r)*(x-sqrt(3)*y))/(L)+2*(R-r)+(x-sqrt(3)*y)
   (m+(R-r)*(x+sqrt(3)*y))/(L)+2*(R-r)+(x+sqrt(3)*y)];
theta1=2*atan((-B(1)-sqrt(B(1)^2-4*A(1)*C(1)))/(2*A(1)));
theta2=2*atan((-B(2)-sqrt(B(2)^2-4*A(2)*C(2)))/(2*A(2)));
theta3=2*atan((-B(3)-sqrt(B(3)^2-4*A(3)*C(3)))/(2*A(3)));
end