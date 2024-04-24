delta1 = @(epsilon) - epsilon.*epsilon/2;
delta2_1 = @(epsilon, zeta) 1 + sqrt(epsilon.^2 - 4 * zeta.^2) - 1/8 * epsilon.^2;
delta2_2 = @(epsilon, zeta) 1 - sqrt(epsilon.^2 - 4 * zeta.^2) - 1/8 * epsilon.^2;
delta3_1 = @(epsilon, zeta) 4 + sqrt(epsilon.^4/16 - 16 * zeta.^2) + 1/6 * epsilon.^2;
delta3_2 = @(epsilon, zeta) 4 - sqrt(epsilon.^4/16 - 16 * zeta.^2) + 1/6 * epsilon.^2;

eps = 0:0.001:0.4;
zeta = 0;
% test delta 1
td1 = delta1(eps);
td2_1 = delta2_1(eps, zeta);
td2_2 = delta2_2(eps, zeta);
td3_1 = delta3_1(eps, zeta);
td3_2 = delta3_2(eps, zeta);

plot(td1, eps, 'k', td2_1, eps, 'k', td2_2, eps, 'k', td3_1, eps, 'k', td3_2, eps, 'k');
xlim([-0.1 6]);

eps = 0:0.001:0.4;
zeta = 0;
% test delta 1
td1 = delta1(eps);
td2_1 = delta2_1(eps, zeta);
td2_2 = delta2_2(eps, zeta);
td3_1 = delta3_1(eps, zeta);
td3_2 = delta3_2(eps, zeta);

figure;
plot(td1, eps, 'k:', td2_1, eps, 'k:', td2_2, eps, 'k:', td3_1, eps, 'k:', td3_2, eps, 'k:');

eps = 0:0.0001:0.4;
zeta = -0.08;
isrealM = @(array) arrayfun(@(z) abs(imag(z)) <= 1e-5, array);
realM = @(array) arrayfun(@real, array);
% ds = [
%     @delta1,
%     @(e) delta2_1(e, zeta),
%     @(e) delta2_2(e, zeta),
%     @(e) delta3_1(e, zeta),
%     @(e) delta3_2(e, zeta),
% ];

% for f = ds
%     res_complex = f(eps);
%     res_real_index = isrealM(res_complex);
% end

td1 = delta1(eps);              r1   = isrealM(td1);   reps1   = eps(r1);   rtd1   = realM(td1(r1));
td2_1 = delta2_1(eps, zeta);    r2_1 = isrealM(td2_1); reps2_1 = eps(r2_1); rtd2_1 = realM(td2_1(r2_1));
td2_2 = delta2_2(eps, zeta);    r2_2 = isrealM(td2_2); reps2_2 = eps(r2_2); rtd2_2 = realM(td2_2(r2_2));
td3_1 = delta3_1(eps, zeta);    r3_1 = isrealM(td3_1); reps3_1 = eps(r3_1); rtd3_1 = realM(td3_1(r3_1));
td3_2 = delta3_2(eps, zeta);    r3_2 = isrealM(td3_2); reps3_2 = eps(r3_2); rtd3_2 = realM(td3_2(r3_2));
hold on;
plot(rtd1, reps1, 'k:')
plot(rtd2_1, reps2_1, 'k:')
plot(rtd2_2, reps2_2, 'k:')
plot(rtd3_1, reps3_1, 'k:')
plot(rtd3_2, reps3_2, 'k:')
xlim([-0.1 6]);
hold off;

figure;
plot(rtd2_1, reps2_1, 'k:')

figure;
plot(rtd2_2, reps2_2, 'k:')
