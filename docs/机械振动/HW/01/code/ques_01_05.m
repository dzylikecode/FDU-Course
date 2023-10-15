%% 
% 

clear; clc;
syms t x(t) c k F_0 omega_f m
f = @(v) m * diff(v, 2) + c * diff(v, 1) + k * v;
eq = f(x) == F_0 * sin(omega_f*t)
%%
assume(m > 0); % 添加条件 m > 0
assume(k > 0); % 添加条件 k > 0
res = dsolve(eq)
simplify(res)
syms C1 C2
x_p = subs(res, [C1 C2], [0 0])
x_h= res - x_p
check_res = f(res)
check_x_h = f(x_h)
%%
check_x_p = f(x_p)
A = abs(x_p)
phi = angle(x_p)
clear; clc;
syms t x(t) xi omega_n m omega_f F_0
f = @(v) diff(v, 2) + 2*xi*omega_n*diff(v, 1) + omega_n^2 * v;
f(x)
eq = f(x) == F_0/m * sin(omega_f*t)
res = simplify(dsolve(eq))
check_res = f(res)
syms C1 C2
x_p = simplify(subs(res, [C1, C2], [0, 0]))
check_x_p = simplify(f(x_p))
clear; clc;

zetaList = [0 0.1 0.2 0.3 0.5 1]; % different damping ratio

% amplitude generation
figure, hold on
for zeta = zetaList % for every damping ratio
    omegaRatio = 0:0.01:5; % wf/wn
    amplitude = 1 ./ sqrt((1-omegaRatio.^2).^2 + (2*zeta*omegaRatio).^2); % response amplitude
    plot(omegaRatio, amplitude, 'lineWidth',2);
end
hold off
h_a = gca;
set(h_a, 'XLim',[0,2.5], 'YLim',[0,5]); % axis
set(h_a, 'XGrid','on', 'YGrid','on', 'GridLineStyle','-', 'GridColor',[0.15,0.15,0.15], 'GridAlpha',0.25); % grid
xlabel('Frequency Raio $r=\frac{f}{f_n}$', 'Interpreter','Latex'), ylabel('Amlitude Ratio $X\frac{k}{F_0}$', 'Interpreter','Latex'); % label
set(h_a, 'FontName','Times New Roman', 'FontSize',10) % font
title('Amplitude', 'FontSize',16); % title
h_l = legend('\zeta=0, No Damping', '\zeta=0.1', '\zeta=0.15', '\zeta=0.25', '\zeta=0.5', '\zeta=1.0, Critical Damping'); % legend
set(h_l, 'FontSize',12);

% phase
zetaList = [0 0.1 0.2 0.3 0.5 1]; % different damping ratio
figure, hold on
for zeta = zetaList % for every damping ratio
    omegaRatio = 0:0.01:2.5; % wf/wn
    phase = atan(2*zeta*omegaRatio./(1-omegaRatio.^2));
    phase = phase + pi * (omegaRatio>1);
    plot(omegaRatio, rad2deg(phase), 'lineWidth',2);
end
h_a = gca;
set(h_a, 'XLim',[0, 2.5], 'YLim',[0,180]); % axis
set(h_a, 'XGrid','on', 'YGrid','on', 'GridLineStyle','-', 'GridColor',[0.15,0.15,0.15], 'GridAlpha',0.25); % grid
xlabel('Frequency Raio $r=\frac{f}{f_n}$', 'Interpreter','Latex'), ylabel('Phase Angle (deg) $\phi$', 'Interpreter','Latex'); % label
set(h_a, 'FontName','Times New Roman', 'FontSize',10) % font
title('Phase', 'FontSize',16); % title
h_l = legend('\zeta=0, No Damping', '\zeta=0.1', '\zeta=0.15', '\zeta=0.25', '\zeta=0.5', '\zeta=1.0, Critical Damping', 'Location', 'southeast'); % legend
set(h_l, 'FontSize',12);