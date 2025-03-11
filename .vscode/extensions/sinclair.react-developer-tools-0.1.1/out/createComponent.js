"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const fs = require("fs");
const path = require("path");
const vscode = require("vscode");
const arrowComponent_1 = require("./templates/arrowComponent");
exports.default = async (componentName, { dir, styled }) => {
    const COMPONENT_FILE_NAME = `${componentName}.tsx`;
    const projectRoot = vscode.workspace.workspaceFolders[0].uri.fsPath;
    if (!dir) {
        dir =
            (await vscode.window.showInputBox({
                value: "/",
                prompt: `Path from root`,
                ignoreFocusOut: true,
                valueSelection: [-1, -1],
            })) || "";
    }
    if (!dir.includes(projectRoot)) {
        dir = projectRoot + dir;
    }
    if (dir[dir.length - 1] !== "/") {
        dir = dir + "/";
    }
    const dirWithFileName = dir + componentName;
    const filePath = (fileName) => dirWithFileName + "/" + fileName;
    createDir(dirWithFileName);
    // if (styled) {
    //   await createFile(
    //     filePath(COMPONENT_FILE_NAME),
    //     styledArrowComponent(componentName)
    //   );
    //   await createFile(filePath(STYLED_FILE_NAME), styledFile());
    // } else {
    await createFile(filePath(COMPONENT_FILE_NAME), (0, arrowComponent_1.default)(componentName));
    // }
    setTimeout(() => {
        vscode.workspace
            .openTextDocument(filePath(COMPONENT_FILE_NAME))
            .then((editor) => {
            if (!editor) {
                return;
            }
            vscode.window.showTextDocument(editor);
        });
    }, 50);
};
const createDir = (targetDir) => {
    const pathSeperator = path.sep;
    const initDir = path.isAbsolute(targetDir) ? pathSeperator : "";
    const baseDir = __dirname;
    return targetDir.split(pathSeperator).reduce((parentDir, childDir) => {
        const cwd = path.resolve(baseDir, parentDir, childDir);
        try {
            fs.mkdirSync(cwd);
        }
        catch (err) {
            if (err.code === "EEXIST") {
                return cwd;
            }
            // To avoid `EISDIR` error on Mac and `EACCES`-->`ENOENT` and `EPERM` on Windows.
            if (err.code === "ENOENT") {
                // Throw the original parentDir error on curDir `ENOENT` failure.
                throw new Error(`EACCES: permission denied, mkdir '${parentDir}'`);
            }
            const error = ["EACCES", "EPERM", "EISDIR"].indexOf(err.code) > -1;
            if (!error || (error && cwd === path.resolve(targetDir))) {
                throw err;
            }
        }
        return cwd;
    }, initDir);
};
const createFile = async (filePath, content) => {
    if (!fs.existsSync(filePath)) {
        fs.createWriteStream(filePath).close();
        fs.writeFile(filePath, content, (err) => {
            if (err) {
                vscode.window.showErrorMessage("React Developer Tools can't write to file.");
            }
        });
    }
    else {
        vscode.window.showWarningMessage("File already exists.");
    }
};
//# sourceMappingURL=createComponent.js.map