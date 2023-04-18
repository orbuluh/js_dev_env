// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import * as vscode from "vscode";

// This method is called when your extension is activated
// Your extension is activated the very first time the command is executed

export function activate(context: vscode.ExtensionContext) {
  let disposable = vscode.commands.registerCommand(
    "extension.mdfold",
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

      await editor.edit((editBuilder) => {
        // You can replace these with the text you want to add
        const topText =
          '<details><summary markdown="span">Examples</summary>\n';
        const bottomText = "</summary></details>\n";

        editBuilder.insert(selection.start, topText);
        editBuilder.insert(selection.end, bottomText);
      });
    }
  );

  context.subscriptions.push(disposable);
}

// This method is called when your extension is deactivated
export function deactivate() {}
