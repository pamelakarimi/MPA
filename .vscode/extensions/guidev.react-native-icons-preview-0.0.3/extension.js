const vscode = require("vscode");

const displayIcon = require("./src/utils/displayIcon");
const objectEquality = require("./src/utils/objectEquality");
const constants = require("./src/configs/constants");

/**
 * @param {vscode.ExtensionContext} context
 */

function activate(context) {
  const iconRegex = /<([A-Z][a-zA-Z0-9.]*)\s+([^>]+?)\/?>/g;
  const multilineIconRegex = /([a-zA-Z0-9 ])*<([A-Z][a-zA-Z0-9 ]*)/g;
  let throttleIds = {};
  const fontNames = constants.FONT_NAMES;
  let lines = {};

  function isJsOrTsFile(document) {
    const lang = document.languageId;
    return lang.includes("javascript") || lang.includes("typescript");
  }
  const scan = (editor) => {
    const nextLines = {};
    if (!editor.document || !editor.document.uri) return;

    let noneMatchedLine = { lineNum: undefined, content: "" };
    const isStartFontTag = (t) =>
      fontNames.some((f) => new RegExp(`^( )*<${f}`).test(t));

    try {
      for (let line = 0; line < editor.document.lineCount; line++) {
        const text = editor.document.lineAt(line).text;
        let match = iconRegex.exec(text);

        if (!match) match = iconRegex.exec(text);

        if (text && !match) {
          if (!noneMatchedLine.content && !isStartFontTag(text));
          else {
            if (!noneMatchedLine.content) {
              let matching = multilineIconRegex.exec(text);
              if (!matching) matching = multilineIconRegex.exec(text);
              if (!matching) continue;

              noneMatchedLine.lineNum = line;
            }

            const fullText = noneMatchedLine.content.concat(text);
            noneMatchedLine.content = fullText;

            const new_match = iconRegex.exec(fullText);
            const line_ = noneMatchedLine.lineNum;

            if (new_match) {
              const icon = displayIcon(fullText, new_match[1]);
              if (icon) {
                nextLines[line_] = icon;
                noneMatchedLine = { lineNum: undefined, content: "" };
              }
            }
          }
        } else if (match && noneMatchedLine.content)
          noneMatchedLine = { lineNum: undefined, content: "" };

        if (text && match) {
          const icon = displayIcon(text, match[1]);
          if (icon) nextLines[line] = icon;
        }
      }

      if (objectEquality(lines, nextLines)) return;

      const nextKeys = Object.keys(nextLines);
      const prevKeys = Object.keys(lines);
      const range = (l, text) => new vscode.Range(+l, 0, +l, text.length);

      prevKeys.forEach((line) => {
        if (!nextLines[line] && lines[line]) {
          lines[line].decorationType.dispose();
          delete lines[line];
        }
      });

      nextKeys.forEach((line) => {
        const { text, decorationType } = nextLines[line];
        if (lines[line]) lines[line].decorationType.dispose();
        editor.setDecorations(decorationType, [range(line, text)]);
      });

      lines = { ...nextLines };
    } catch (error) {
      console.log(error);
    }
  };

  const refresh = () => {
    vscode.window.visibleTextEditors
      .filter((p) => p.document != null)
      .forEach((props) => throttledScan(props));
  };

  let throttledScan = (editor) => {
    if (
      editor.document &&
      editor.document.uri &&
      isJsOrTsFile(editor.document)
    ) {
      const lookupKey = editor.document.uri.toString();
      if (throttleIds[lookupKey]) clearTimeout(throttleIds[lookupKey]);
      throttleIds[lookupKey] = setTimeout(() => {
        scan(editor);
        delete throttleIds[lookupKey];
      }, 1000);
    }
  };

  context.subscriptions.push(
    vscode.workspace.onDidChangeTextDocument((e) => {
      refresh();
    })
  );

  context.subscriptions.push(
    vscode.window.onDidChangeActiveTextEditor((e) => {
      if (e) throttledScan(e);
    })
  );

  context.subscriptions.push(
    vscode.workspace.onDidChangeWorkspaceFolders(() => {
      refresh();
    })
  );

  refresh();
}

module.exports = {
  activate,
};
