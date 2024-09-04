// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import * as vscode from "vscode";

function trimAndRemoveLines(selectedText : string) : string {
  const lines = selectedText.split("\n");
  const filteredLines = lines.filter(
    (line) => !line.includes("Word Breakdown:") && line.trim().length > 0
  );
  const trimmedAndBulletLines = filteredLines.map((line) => ("- " + line.trim()));
  return trimmedAndBulletLines.join("\n");
}

// This method is called when your extension is activated
// Your extension is activated the very first time the command is executed
export function activate(context: vscode.ExtensionContext) {
  let disposable = vscode.commands.registerCommand(
    "extension.jpbkfmt",
    async () => {
      const editor = vscode.window.activeTextEditor;
      if (!editor) {
        vscode.window.showInformationMessage("No active text editor.");
        return;
      }

      const selection = editor.selection;
      if (selection.isEmpty) {
        vscode.window.showInformationMessage(
          "Please select a block of code first."
        );
        return;
      }

			const modifiedText = trimAndRemoveLines(editor.document.getText(selection));
      editor.edit(editBuilder => {
        editBuilder.replace(selection, modifiedText);
      });
    }
  );

  context.subscriptions.push(disposable);
}

// This method is called when your extension is deactivated
export function deactivate() {}
