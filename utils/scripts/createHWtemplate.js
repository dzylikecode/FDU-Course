/**
 * Create a template file for a new homework
 * usage: node createHWtemplate.js <title-num> <relativePath>
 */
const path = require("path");
const fs = require("fs");
const { get } = require("https");
const curDir = path.resolve(__dirname);
const tempDir = path.join(curDir, "temp/");
const emptySvgPath = path.join(curDir, "res/empty.drawio.svg");
const workspaceDir = path.resolve(__dirname, "../..");

const msg = process.argv[2];
const [title, numHWString] = msg.split("-");
const numHW = parseInt(numHWString);
const hwPath = process.argv[3];
const hwDir = hwPath ? path.join(workspaceDir, hwPath) : tempDir;
const fileContents = [`# HW-${title.padStart(2, "0")}`];
for (let i = 1; i <= numHW; i++) {
  fileContents.push(createHWpart(i));
}
createFile(getFilePath(`README.md`), fileContents.join("\n"));
/**
 *
 * @param {string} partNumber
 */
function createHWpart(partNumber) {
  const formattedNum = partNumber.toString().padStart(2, "0");
  const svgName = `HW-${title.padStart(2, "0")}-${formattedNum}.drawio.svg`;
  const content = `
## problem ${formattedNum}

![](${svgName})`;

  createSvgFile(getFilePath(svgName));
  return content;
}

function createSvgFile(svgPath) {
  const srcPath = emptySvgPath;
  const destPath = svgPath;

  const srcStream = fs.createReadStream(srcPath);
  const destStream = fs.createWriteStream(destPath);

  srcStream.on("error", (err) => {
    console.error(`Error reading from source file: ${err}`);
  });

  destStream.on("error", (err) => {
    console.error(`Error writing to destination file: ${err}`);
  });

  destStream.on("finish", () => {
    console.log("File copied successfully");
  });

  srcStream.pipe(destStream);
}

function getFilePath(filename) {
  return path.join(hwDir, filename);
}

// create file and write content
function createFile(filePath, content) {
  const dir = path.dirname(filePath);
  if (!fs.existsSync(dir)) {
    fs.mkdirSync(dir, { recursive: true });
  }
  fs.writeFileSync(filePath, content, (err) => {
    if (err) {
      console.log(err);
    }
  });
  console.log(`created ${filePath}`);
}
