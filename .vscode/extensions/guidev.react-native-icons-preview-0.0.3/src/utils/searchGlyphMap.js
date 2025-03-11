const fs = require("fs");
const path = require("path");

function searchGlyphMap(filename, key) {
  const fileName = filename.toLocaleLowerCase();
  const directory = path.join(__dirname, "..", "assets", "glyphmaps");
  const files = fs.readdirSync(directory);

  const matchedFile = files.find((file) => {
    const regex = new RegExp(`${fileName}\.json$`, "i");
    return regex.test(file);
  });

  if (!matchedFile) return null;

  const filePath = path.join(directory, matchedFile);
  const fileContents = fs.readFileSync(filePath, "utf-8");
  const glyphMap = JSON.parse(fileContents);

  const value = glyphMap[key];

  return value || null;
}

module.exports = searchGlyphMap;
