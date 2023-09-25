syms theta(t) t

R = [cos(theta) -sin(theta) 0; sin(theta) cos(theta) 0; 0 0 1];
omega = diff(R, t)/R