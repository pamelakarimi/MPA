const vscode = require("vscode");
const { generateFunction } = require("./generateReactTemp");

function activate(context) {
  let generate = vscode.commands.registerCommand(
    "folderGenerator.GenerateFolder",
    generateFunction
  );

  context.subscriptions.push(generate);
}

function deactivate() {}

module.exports = {
  activate,
  deactivate,
};
