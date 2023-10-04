const path = require("path");
const { ConvertMlx } = require("./lib/matlabConvert");
const fs = require("fs");

const rootDir = path.resolve(__dirname, "../..");

console.log("root directory:", rootDir);

const mlxFiles = findFiles(rootDir, ".mlx");
// console.log("mlxFiles", mlxFiles);
ConvertMlx(mlxFiles);

function findFiles(dir, extension, fileList = []) {
  const files = fs.readdirSync(dir);

  files.forEach((file) => {
    const filePath = path.join(dir, file);
    const fileStat = fs.statSync(filePath);

    if (fileStat.isDirectory()) {
      findFiles(filePath, extension, fileList);
    } else if (path.extname(file) === extension) {
      fileList.push(filePath);
    }
  });

  return fileList;
}
