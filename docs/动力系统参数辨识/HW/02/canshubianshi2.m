clc;
clear;
close all;
%% 加载数据
data1=load('.\data\experimentData1.mat');
data2=load('.\data\experimentData2.mat');
data3=load('.\data\experimentData3.mat');
data4=load('.\data\experimentData4.mat');
data5=load('.\data\experimentData5.mat');
data=[data1,data2,data3,data4,data5];
%% 定义变量
% 角度2
theta_2=zeros(20000,5);
dtheta_2=zeros(20000,5);
ddtheta_2=zeros(20000,5); % 加速度需计算
tau_2=zeros(20000,5); % 驱动力矩
% 角度3
theta_3=zeros(20000,5);
dtheta_3=zeros(20000,5);
ddtheta_3=zeros(20000,5);
tau_3=zeros(20000,5);
%% 代入数据
for i=1:5
    for j=1:20000
    theta_2(j,i)=pi*(data(i).experimentData(j,1)-460)/180;
    dtheta_2(j,i)=pi*data(i).experimentData(j,3)/180;
    tau_2(j,i)=data(i).experimentData(j,5)*83.83/1000; % 关节电机驱动力矩与实测电流的换算关系
    theta_3(j,i)=pi*(data(i).experimentData(j,2)-290)/180;
    dtheta_3(j,i)=pi*data(i).experimentData(j,4)/180;
    tau_3(j,i)=data(i).experimentData(j,6)*83.83/1000;
    end 
end
%% 计算加速度
omiga_2=[0.5*pi,0.4*pi,0.2*pi,0.6*pi,0.7*pi]'; %各组频率
omiga_3=[0.45*pi,0.4*pi,0.2*pi,0.5*pi,0.6*pi]';
% 正弦运动的角加速度=-角度*频率的平方
for i=1:5
 ddtheta_2(:,i)=-theta_2(:,i)*omiga_2(i)^2;
 ddtheta_3(:,i)=-theta_3(:,i)*omiga_3(i)^2;
end
%% 1、3、5训练
group=1;
for i=1:20000
A1((2*i-1):2*i,:)=fcn(theta_2(i,group),dtheta_2(i,group), ...
    ddtheta_2(i,group),theta_3(i,group),dtheta_3(i,group),ddtheta_3(i,group));
b1((2*i-1):2*i)=[tau_2(i,group);tau_3(i,group)];
end
group=3;
for i=1:20000
A2((2*i-1):2*i,:)=fcn(theta_2(i,group),dtheta_2(i,group), ...
    ddtheta_2(i,group),theta_3(i,group),dtheta_3(i,group),ddtheta_3(i,group));
b2((2*i-1):2*i)=[tau_2(i,group);tau_3(i,group)];
end
group=5;
for i=1:20000
A3((2*i-1):2*i,:)=fcn(theta_2(i,group),dtheta_2(i,group), ...
    ddtheta_2(i,group),theta_3(i,group),dtheta_3(i,group),ddtheta_3(i,group));
b3((2*i-1):2*i)=[tau_2(i,group);tau_3(i,group)];
end
% 观测矩阵和驱动力矩
A=[A1;A2;A3];
b=[b1';b2';b3'];
conditon=cond(A) % A条件数
%% 最小二乘法进行参数辨识
canshu=pinv(A'*A)*A'*b
%% 2、4预测
group_pre=2;
for i=1:20000
A((2*i-1):2*i,:)=fcn(theta_2(i,group_pre),dtheta_2(i,group_pre), ...
    ddtheta_2(i,group_pre),theta_3(i,group_pre),dtheta_3(i,group_pre),ddtheta_3(i,group_pre));
end
tau_pre=A*canshu;
for i=1:20000
 tau_pre_2(i)=tau_pre(2*i-1);
 tau_pre_3(i)=tau_pre(2*i);  
end
figure(1)
plot(tau_2(:,group_pre))
hold on
plot(tau_pre_2)
figure(2)
plot(tau_3(:,group_pre))
hold on
plot(tau_pre_3)

group_pre=4;
for i=1:20000
A((2*i-1):2*i,:)=fcn(theta_2(i,group_pre),dtheta_2(i,group_pre), ...
    ddtheta_2(i,group_pre),theta_3(i,group_pre),dtheta_3(i,group_pre),ddtheta_3(i,group_pre));
end
tau_pre=A*canshu;
for i=1:20000
 tau_pre_2(i)=tau_pre(2*i-1);
 tau_pre_3(i)=tau_pre(2*i);  
end
figure(3)
plot(tau_2(:,group_pre))
hold on
plot(tau_pre_2)
figure(4)
plot(tau_3(:,group_pre))
hold on
plot(tau_pre_3)
%% QR分解检测参数的可辨识性
% [Q,R]=qr(A)% 第4个参数不可辨识
%% 观测矩阵函数
% function A=fcn(theta2,dtheta2,ddtheta2,theta3,dtheta3,ddtheta3)
% d2=0.44;
% d3=0.37;
% g=9.81;
% A=zeros(2,7);
% A(1,1)=ddtheta2;
% A(1,2)=ddtheta2+ddtheta3;
% A(1,3)=d2^2*ddtheta2+g*d2*sin(theta2);
% A(1,4)=g*sin(theta2);
% A(1,5)=d2*(2*ddtheta2+ddtheta3)*sin(theta3)+d2*(2*dtheta2^2+dtheta3^3)*cos(theta3)-g*cos(theta2+theta3);
% A(1,6)=sign(dtheta2); % 摩擦力矩假设为摩擦力和粘性阻尼力
% A(1,7)=dtheta2;
% A(2,1)=0;
% A(2,3)=0;
% A(2,4)=0;
% A(2,2)=A(1,2);
% A(2,5)=d2*ddtheta2*sin(theta3)-d2*dtheta2^2*cos(theta3)+g*cos(theta2+theta3);
% A(2,6)=sign(dtheta3);
% A(2,7)=dtheta3;
% end
%% 去除第4个参数的观测矩阵函数
function A=fcn(theta2,dtheta2,ddtheta2,theta3,dtheta3,ddtheta3)
d2=0.44;
d3=0.37;
g=9.81;
A=zeros(2,6);
A(1,1)=ddtheta2;
A(1,2)=ddtheta2+ddtheta3;
A(1,3)=d2^2*ddtheta2+g*d2*sin(theta2);
A(1,4)=d2*(2*ddtheta2+ddtheta3)*sin(theta3)+d2*(2*dtheta2^2+dtheta3^2)*cos(theta3)-g*cos(theta2+theta3);
A(1,5)=sign(dtheta2); % 摩擦力矩假设为摩擦力和粘性阻尼力
A(1,6)=dtheta2;
A(2,1)=0;
A(2,3)=0;
A(2,2)=A(1,2);
A(2,4)=d2*ddtheta2*sin(theta3)-d2*dtheta2^2*cos(theta3)+g*cos(theta2+theta3);
A(2,5)=sign(dtheta3);
A(2,6)=dtheta3;
end