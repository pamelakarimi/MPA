const vscode = require("vscode");
const btoa = require("btoa");

const getProps = require("./getProps");
const glyphMapToSvg = require("./glyphMapToSvg");
const searchGlyphMap = require("./searchGlyphMap");
const iconShortcut = require("./iconsShortcut");

function displayIcon(text, iconType) {
  const { name, type, color, solid, brands } = getProps(text);
  let filename = iconShortcut[type] || iconType.split(".")[0];
  let iconName = name;
  let iconColor = color;
  let fontWeight = solid ? "solid" : brands ? "brands" : undefined;

  if (!iconName) return;

  try {
    let glyphUnicode = searchGlyphMap(filename, iconName);
    if (glyphUnicode) {
      const iconPath = vscode.Uri.parse(
        "data:image/svg+xml;base64," +
          btoa(glyphMapToSvg(filename, glyphUnicode, iconColor, fontWeight))
      );
      const decorationType = vscode.window.createTextEditorDecorationType({
        before: { contentIconPath: iconPath },
      });

      return { text, decorationType };
    }
  } catch (error) {
    console.log(error);
    return undefined;
  }
}

module.exports = displayIcon;

// const vscode = require("vscode");
// const btoa = require("btoa");

// const getIconProps = require("./getIconProps");
// const glyphMapToSvg = require("./glyphMapToSvg");
// const searchGlyphMap = require("./searchGlyphMap");
// const iconShortcut = require("./iconShortcut");

// function displayIcon(editor, lines, line, text, iconType) {
//   const { name, type, color } = getIconProps(text);
//   let filename = iconShortcut[type] || iconType;
//   let iconName = name;
//   let iconColor = color;
//   let glyphUnicode = searchGlyphMap(filename, iconName);
//   const range = new vscode.Range(line, 0, line, text.length);

//   if (glyphUnicode) {
//     const iconPath = vscode.Uri.parse(
//       "data:image/svg+xml;base64," +
//         btoa(glyphMapToSvg(filename, glyphUnicode, iconColor))
//     );
//     const decorationType = vscode.window.createTextEditorDecorationType({
//       before: { contentIconPath: iconPath },
//     });

//     editor.setDecorations(decorationType, [range]);
//     return decorationType;
//   }
// }

// module.exports = displayIcon;
