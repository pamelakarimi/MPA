const vscode = require("vscode");
const { reactTemp, reactTsxTemp } = require("./reactTemp");
const fs = require("fs");

const generateFunction = async (Uri) => {
  try {
    let input = await vscode.window.showInputBox({
      prompt: "Component name",
    });
    if (input === undefined || input.length === 0) {
      vscode.window.showErrorMessage("Input name is undefined");
    } else {
      let res = input[0].toUpperCase() + input.slice(1);
      let config = vscode.workspace
        .getConfiguration("foldergenerator")
        .get("SelectTemplate");
      let ext = "jsx";
      let fun = reactTemp;

      if (config === "TypeScript") {
        ext = "tsx";
        fun = reactTsxTemp;
      }
      if (!fs.existsSync(Uri.fsPath + `/${res}`)) {
        await vscode.workspace.fs.writeFile(
          vscode.Uri.file(Uri.fsPath + `/${res}/${res}.${ext}`),
          new Uint8Array(Buffer.from(fun(res)))
        );

        await vscode.workspace.fs.writeFile(
          vscode.Uri.file(Uri.fsPath + `/${res}/${res}.module.scss`),
          new Uint8Array()
        );

        await vscode.window.showTextDocument(
          vscode.Uri.file(Uri.fsPath + `/${res}/${res}.${ext}`)
        );

        vscode.window.showInformationMessage("Creation successful");
      } else {
        vscode.window.showErrorMessage(
          "Folder with the same name already exists"
        );
      }
    }
  } catch (error) {
    vscode.window.showErrorMessage(error);
  }
};

module.exports = {
  generateFunction,
};
