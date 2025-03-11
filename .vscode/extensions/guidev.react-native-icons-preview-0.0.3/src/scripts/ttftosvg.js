// // const opentype = require("opentype.js");
// // const fs = require("fs");
// // const path = require("path");

// // const glyphMapsFolderPath = path.join(__dirname, "..", "assets", "glyphmaps");
// // const outputFolderPath = path.join(__dirname, "..", "assets", "svg");

// // fs.readdir(glyphMapsFolderPath, (err, files) => {
// //   if (err) {
// //     console.error("Error reading glyph map folder:", err);
// //     return;
// //   }

// //   // Iterate over the glyph map files
// //   files.forEach((file) => {
// //     const glyphMapPath = path.join(
// //       __dirname,
// //       "..",
// //       "assets",
// //       "glyphmaps",
// //       file
// //     );

// //     // Read the contents of the glyph map file
// //     fs.readFile(glyphMapPath, "utf8", (err, data) => {
// //       if (err) {
// //         console.error(`Error reading glyph map file '${file}':`, err);
// //         return;
// //       }

// //       // Parse the JSON data
// //       const glyphMap = JSON.parse(data);

// //       // Convert each glyph to SVG
// //       Object.keys(glyphMap).forEach((glyphName) => {
// //         const glyphUnicode = glyphMap[glyphName];
// //         const fontFile = path.join(
// //           __dirname,
// //           "..",
// //           "assets",
// //           "fonts",
// //           file.replace("json", "ttf")
// //         );

// //         // Load the font file
// //         opentype.load(fontFile, (err, font) => {
// //           if (err) {
// //             console.error("Error loading font:", err);
// //             return;
// //           }

// //           console.log({ glyphUnicode, path: fontFile });

// //           // Retrieve the glyph based on its Unicode value
// //           console.log("here...1");
// //           const glyph = font.glyphs.get(0);
// //           console.log("here...2");

// //           if (glyph) {
// //             console.log("here...");
// //             // Convert the glyph to SVG path
// //             const svgPath = glyph.getPath().toSVG();

// //             // Write the SVG data to a file
// //             const svgFileName = `${outputFolderPath}/${glyphName}.svg`;
// //             fs.writeFileSync(svgFileName, svgPath);

// //             console.log(`Converted glyph '${glyphName}' to SVG.`);
// //           } else {
// //             console.warn(`Glyph '${glyphName}' not found in the font.`);
// //           }
// //         });
// //       });
// //     });
// //   });
// // });

// var opentype = require("opentype.js");
// const path = require("path");
// const fs = require("fs");
// const svg2img = require("svg2img");

// const FONT_NAME = "AntDesign";

// var buffer = fs.readFileSync(
//   path.join(__dirname, "..", "assets", "fonts", FONT_NAME + ".ttf")
// );
// const result = opentype.parse(buffer.buffer);

// for (let key in result.glyphs.glyphs) {
//   let item = result.glyphs.glyphs[key];
//   if (!item.unicode) {
//   } else {
//     const glyphPath = item.getPath(0, 0);
//     const { x1, x2, y1, y2 } = glyphPath.getBoundingBox();
//     const w = x2 - x1;
//     const h = y2 - y1;

//     const svgDocument = `<svg width="${w}" height="${h}" viewBox="${x1} ${y1} ${w} ${h}">
//   ${glyphPath.toSVG(0)}
// </svg>`;

//     var glyphmap = fs.readFileSync(
//       path.join(__dirname, "..", "assets", "glyphmaps", FONT_NAME + ".json"),
//       "utf-8"
//     );

//     const rs = JSON.parse(glyphmap);

//     const name = Object.keys(JSON.parse(glyphmap)).find(
//       (e) => rs[e] === item.unicode
//     );

//     // fs.writeFileSync(
//     //   path.join(__dirname, "..", "assets", "svg", FONT_NAME, name + ".svg"),
//     //   svgDocument
//     // );

//     svg2img(svgDocument, function (error, buffer) {
//       fs.writeFileSync(
//         path.join(__dirname, "..", "assets", "svg", FONT_NAME, name + ".png"),
//         buffer
//       );
//     });
//   }
// }

// const fs = require("fs");
// const path = require("path");

// const FONT_NAME = "AntDesign";

// var glyphmap = fs.readFileSync(
//   path.join(__dirname, "..", "assets", "glyphmaps", FONT_NAME + ".json"),
//   "utf-8"
// );
// const obj = JSON.parse(glyphmap);
// const glyphmapsArray = Object.entries(obj);

// console.log(glyphmapsArray);

// const glyphMapToSvg = require("../utils/glyphMapToSvg");
// const searchGlyphMap = require("../utils/searchGlyphMap");

// const filename = "FontAwesome5";
// const key = "firefox";

// const glyphUnicode = searchGlyphMap(filename, key);
// console.log(glyphUnicode, glyphMapToSvg(filename, glyphUnicode));

// const line = "<FontAwesome5 name='user' color='red' /> ";
// const line = "<AntDesign name='firefox' color='#fff' />";
// const line =
//   '<Icon type="FontAwesome5" name="firefox" size={30} color="black" />';
// const line =
//   '<Icon type=`AntDesign" name="comments" size={30} color={"#900"} />';

// const path = require("path");
// const getIconProps = require("../utils/getIconProps");

// const component =
//   "<Icon name='comments' size={30} color={'#900'}  a=\"500\" b=`200` c='6'/>";

// console.log(getIconProps(component));

const fs = require("fs");
const path = require("path");
const prefix = "md";
const fileName = "MaterialIcons";
const file = fileName.toLocaleLowerCase();

const inputFilePath = path.join(
  __dirname,
  "..",
  "assets",
  "glyphmaps",
  file + ".json"
);
const outputFilePath = path.join(__dirname, "..", "snippets", prefix + ".json");

// Read the JSON file
fs.readFile(inputFilePath, "utf8", (err, data) => {
  if (err) {
    console.error("Error reading JSON file:", err);
    return;
  }

  try {
    const glyphmaps = JSON.parse(data);

    // Refactor the JSON keys
    const refactoredGlyphmaps = {};
    for (const key in glyphmaps) {
      const refactoredKey = `${prefix}-${key}`;
      const refactoredValue = {
        scope: "javascriptreact, typescriptreact",
        prefix: `${prefix}-${key}`,
        body: `<${fileName} name="${key}" color="black" size={25}/>$0`,
        description: `${key} icon from ${fileName} font.`,
      };
      refactoredGlyphmaps[refactoredKey] = refactoredValue;
    }

    // Convert the refactored JSON back to string
    const refactoredJsonString = JSON.stringify(refactoredGlyphmaps, null, 2);

    // Write the refactored JSON to a new file
    fs.writeFile(outputFilePath, refactoredJsonString, "utf8", (err) => {
      if (err) {
        console.error("Error writing JSON file:", err);
        return;
      }

      console.log("JSON file refactored and saved successfully!");
    });
  } catch (err) {
    console.error("Error parsing JSON:", err);
  }
});
