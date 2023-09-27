/**
 * git clone the from repo:https://github.com/dzylikecode/matlab-file-converter
 */
const path = require("path");
const exec = require("child_process").exec;

const workscripts = "D:\\code\\matlab-file-converter\\Convert.js";

const curDir = path.resolve(__dirname, "../..");

console.log("curDir", curDir);

const codeDir = path.resolve(curDir, "docs\\机械振动\\01\\HW\\code\\*.mlx");

exec(`node ${workscripts} ${codeDir}`, (err, stdout, stderr) => {
  if (err) {
    console.log(err);
  } else {
    console.log(stdout);
  }
});
