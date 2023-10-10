// FFT
function reArrange(xs) {
  const N = xs.length;
  const n = Math.log2(N);
  const N_new = 1 << n;
  const ys = new Array(N_new).fill(0);
  for (var i = 0; i < N; i++) {
    ys[i] = xs[bitReverse(i, n)];
  }
  return ys;
}

function bitReverse(x, n) {
  const bitString = x.toString(2).padStart(n, "0");
  const reversedBitString = bitString.split("").reverse().join("");
  return parseInt(reversedBitString, 2);
}

(function () {
  const x = [3, -1, 0, 5, 9, 0, -3, 2];
  const y = reArrange(x);
  console.log(y);
})();
