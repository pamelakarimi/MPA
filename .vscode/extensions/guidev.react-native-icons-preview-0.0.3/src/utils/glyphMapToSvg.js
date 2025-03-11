const opentype = require("opentype.js");
const path = require("path");
const fs = require("fs");

const fontsFiles = path.join(__dirname, "..", "assets", "fonts");
const FA5 = "fontawesome5";
const SOLID = "solid";
const BRANDS = "brands";

const getGlyphName = (fontFilePath, glyph) => {
  const buffer = fs.readFileSync(fontFilePath);
  const font = opentype.parse(buffer.buffer);
  const glyphs = font.glyphs.glyphs;

  const glyphName = Object.keys(glyphs).find(
    (name) => glyphs[name].unicode === glyph
  );
  return { glyphName, glyphs };
};

function glyphMapToSvg(filename, glyph, color = "black", fontWeight) {
  let fileName = filename.toLocaleLowerCase();
  let fa5Files = [FA5 + ".ttf", FA5 + "_brands.ttf", FA5 + "_solid.ttf"];

  if (fontWeight && fileName === FA5) {
    if (fontWeight === SOLID) {
      fileName = fileName + "_" + SOLID;
      fa5Files = fa5Files.filter((e) => !e.includes(SOLID));
    } else if (fontWeight === "brands") {
      fileName = fileName + "_" + BRANDS;
      fa5Files = fa5Files.filter((e) => !e.includes(BRANDS));
    }
  } else if (fileName === FA5)
    fa5Files = fa5Files.filter((e) => e !== FA5 + ".ttf");

  let fontFilePath = path.join(fontsFiles, fileName + ".ttf");

  if (!fs.existsSync(fontFilePath)) throw new Error("Font file not found");

  let { glyphName, glyphs } = getGlyphName(fontFilePath, glyph);

  if (!glyphName) {
    if (fileName.includes(FA5)) {
      fontFilePath = path.join(fontsFiles, fa5Files.shift());

      glyphName = getGlyphName(fontFilePath, glyph).glyphName;
      glyphs = getGlyphName(fontFilePath, glyph).glyphs;

      if (!glyphName) {
        fontFilePath = path.join(fontsFiles, fa5Files.shift());
        glyphName = getGlyphName(fontFilePath, glyph).glyphName;
        glyphs = getGlyphName(fontFilePath, glyph).glyphs;

        if (!glyphName) throw new Error("Glyph not found in the font");
      }
    } else throw new Error("Glyph not found in the font");
  }

  const glyphObject = glyphs[glyphName];

  if (!glyphObject.unicode) {
    throw new Error("Glyph does not have a Unicode value");
  }

  const glyphPath = glyphObject.getPath(0, 0);
  const { x1, x2, y1, y2 } = glyphPath.getBoundingBox();
  const w = x2 - x1;
  const h = y2 - y1;

  return `<svg xmlns="http://www.w3.org/2000/svg" fill="${color}" width="25" height="15" viewBox="${x1} ${y1} ${w} ${h}">
  ${glyphPath.toSVG(0)}
</svg>`;
}

module.exports = glyphMapToSvg;
