const Rules = [
  { src: /{}/g, dst: "" },
  { src: /\s+_/g, dst: "_" },
  { src: /\(t\)/g, dst: "" },
  { src: /\\left\(\s*([^\s+-]+)\s*\\right\)/g, dst: (match, p1) => ` ${p1} ` },
  { src: /(\\theta[^\s+-]*?)''/g, dst: (match, p1) => `\\ddot ${p1}` },
  { src: /(\\theta[^\s+-]*?)'/g, dst: (match, p1) => `\\dot ${p1}` },
];

/**
 *
 * @param {string} tex
 * @returns
 */
function formatTex(tex) {
  let result = tex;
  for (const rule of Rules) {
    result = result.replace(rule.src, rule.dst);
    // console.log(result);
  }
  return result;
}

// const testString =
//   "$$\n\\begin{cases}\n-k_1 l \\sin \\left(\\theta _1\\right)-N_1 \\cos \\left(\\theta _1\\right)+N_2 \\cos \\left(\\theta _2\\right)&=l m_1 \\left(\\theta _1'' \\cos \\left(\\theta _1\\right)-\\theta _1'{}^2 \\sin \\left(\\theta _1\\right)\\right) \\\\\ng m_1-N_1 \\sin \\left(\\theta _1\\right)+N_2 \\sin \\left(\\theta _2\\right)&=l m_1 \\left(- \\theta _1'{}^2\\cos \\left(\\theta _1\\right)-\\theta _1'' \\sin \\left(\\theta _1\\right)\\right)\n\\end{cases}\n$$";

// console.log(formatTex(testString));
