x = [3, -1, 0, 5, 9, 0, -3, 2];
y = reArrange(x);
disp(y);
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