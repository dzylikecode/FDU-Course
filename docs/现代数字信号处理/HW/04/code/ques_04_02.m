clc; clear; close all;
fs=1000;                    % 采样频率
f_pass=100;                 % 上限频率
f_stop=200;                 % 下限频率
alpha_pass=3;               % 衰减率
alpha_stop=10;              % 衰减率
wnn=f_pass/(fs/2)
[n,Wn]=buttord(f_pass/(fs/2),f_stop/(fs/2),alpha_pass,alpha_stop) 
[z, p, k] = buttap(n)
p1 = exp(i * 3/4 * pi)
p2 = exp(i * 5/4 * pi)
[b,a]=butter(n,wnn)