x = [3, -1, 0, 5, 9, 0, -3, 2];
y = reArrange(x);
disp(strjoin(string(y), ', '));
reArrange(0:2^4-1)
reArrange(0:2^3-1)
FFT_prime(x);
test([1 0 0 -1 0 0 -1 1]);
test([1 2])
test([1 2 3 4])
%%
function X = FFT_prime(xs)
theta = reArrange(xs);                          ; theta = sym(theta)
while getCols(theta) ~= 1
                                                ; disp('---------' + string(getRows(theta)));
    [alpha, beta] = partition(theta);           ; a = observe(alpha), b = observe(beta)
    rotateM = rotateMatrix(getRows(beta));      ; W = observe(rotateM)
    betaPart = rotateM*beta;                    % the core of the algorithm
    phi_1 = alpha + betaPart;                   ; phi1 = observe(phi_1)
    phi_2 = alpha - betaPart;                   ; phi2 = observe(phi_2)
    theta = [phi_1; phi_2];                     ; o = observe(theta)
end
X = theta.';
end

function X = FFT_prime_new(xs)
theta = xs;                                     ; theta = sym(theta)
while getCols(theta) ~= 1
                                                ; disp('---------' + string(getRows(theta)));
    [alpha, beta] = partition_new(theta);       ; a = observe(alpha), b = observe(beta)
    rotateM = rotateMatrix(getRows(beta));      ; W = observe(rotateM)
    betaPart = rotateM*beta;                    % the core of the algorithm
    phi_1 = alpha + betaPart;                   ; phi1 = observe(phi_1)
    phi_2 = alpha - betaPart;                   ; phi2 = observe(phi_2)
    theta = [phi_1; phi_2];                     ; o = observe(theta)
end
X = theta.';
end

function [evenIdxElems, oddIdxElems] = partition_new(xs)
evenIdxElems = xs(:,1:end/2);
oddIdxElems = xs(:,end/2+1:end);
end


function test(xs)
res1 = FFT_prime(xs);
res2 = FFT_prime_new(xs);
double(res1)
fft(xs)
double(res2)
end

function ys = reArrange(xs)
N = length(xs);
n = log2(N);
N_new = 2^n;
ys = zeros(1, N_new);
for i = 1:N
    ys(i) = xs(bitReverse(i-1, n)+1);
end
end

function y = bitReverse(x, n)
bitString = dec2bin(x, n);
reversedBitString = bitString(end:-1:1);
y = bin2dec(reversedBitString);
end

function [evenIdxElems, oddIdxElems] = partition(xs)
evenIdxElems = xs(:,1:2:end);
oddIdxElems = xs(:,2:2:end);
end

function cols = getCols(xs)
cols = size(xs, 2);
end

function rows = getRows(xs)
rows = size(xs, 1);
end

function m = rotateMatrix(dims)
n = 2 * dims;
W_n = exp(sym(-1i * 2*pi / n));
dig_W = arrayfun(@(i) W_n^i, 0:dims-1);
m = diag(dig_W);
end


function v = observe(var)
v = var;
latex(var)
end