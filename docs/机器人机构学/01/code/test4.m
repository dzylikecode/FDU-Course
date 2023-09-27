clear;clc;
syms x_1 y_1 z_1 p_1 q_1 r_1 x_2 y_2 z_2 p_2 q_2 r_2
S_1 = [x_1 y_1 z_1 p_1 q_1 r_1];
S_2 = [x_2 y_2 z_2 p_2 q_2 r_2];
%
S_1_s = getS(S_1)
S_1_s0 = getS0(S_1)
S_2_s = getS(S_2)
S_2_s0 = getS0(S_2)
target = dot(S_1_s, S_2_s0) + dot(S_2_s, S_1_s0)
%
S_1_h = calcH(S_1)
S_2_h = calcH(S_2)
%
S_1_r0 = calcR0(S_1)
S_2_r0 = calcR0(S_2)
%
[d n] = calcD(S_1, S_2)
cos_phi = dot(S_1_s, S_2_s)
sin_phi_e = cross(S_1_s, S_2_s)
sin_phi_2 = dot(sin_phi_e, sin_phi_e)
%

d2_sin2_calc = expand(d^2*sin_phi_2)
d2_sin2_test = expand(((S_1_h + S_2_h)*cos_phi - target)^2 * dot(n, n))
%
eq = simplify(d2_sin2_calc - d2_sin2_test)

function res = dot(v1, v2)
res = v1(1)*v2(1) + v1(2)*v2(2) + v1(3)*v2(3);
end

function res = getS(S)
res = [S(1) S(2) S(3)];
end

function res = getS0(S)
res = [S(4) S(5) S(6)];
end

function res = calcH(S)
s = getS(S);
s0 = getS0(S);
res = dot(s, s0);
res = simplify(res);
end

function res = calcR0(S)
s = getS(S);
s0 = getS0(S);
res = cross(s, s0);
res = simplify(res);
end

function [d n] = calcD(S_1, S_2)
s_1 = getS(S_1);
s_2 = getS(S_2);
n1 = s_1;
n2 = s_2;
r0_1 = calcR0(S_1);
r0_2 = calcR0(S_2);
AA = r0_2 - r0_1;
n = cross(n1, n2);
res = dot(n, AA);
res = simplify(res);
d = res;
end

function res = cross(v1, v2)
res = [v1(2)*v2(3)-v1(3)*v2(2) v1(3)*v2(1)-v1(1)*v2(3) v1(1)*v2(2)-v1(2)*v2(1)];
end

function res = norm(v)
res = sqrt(dot(v, v));
end