# My VSCODE extension

## Dev

- Setup:

```bash
sudo npm install -g yo generator-code
```

- Run` yo code` in the terminal to start the generator.
- Follow the prompts to set up your extension, choosing "TypeScript" when asked for the language.
- Open your new extension in VS Code
- Modify `src/extension.ts` and `package.json`
- In `package.json`: `commands->title` will be what is shown when you press `Ctrl+Shift+P`
- Click F5 to enter debug/try mode

## Recompile

- Sometimes your change won't take effect in F5 debug mode
- You might need to clean up the build files and recompile your extension to make sure your changes are reflected.

```bash
rm -rf out/*0
npm run compile
```

## Publish as local .vsix file

- Set up: `npm install -g vsce`
- Need to edit the READEME.md (or next command will tell you to)
- Navigate to your extension's project folder in the terminal and run the following command to package your extension into a .vsix file:

```bash
vsce package
```

- This will create a .vsix file in the same directory as your extension's package.json file.

## Install the local .vsix file

- Open Visual Studio Code and go to the Extensions view by clicking on the Extensions icon in the Activity Bar on the side of the window.
- Click on the ellipsis (three dots) in the upper right corner of the Extensions view, and then select "Install from VSIX..." in the dropdown menu.
- Browse to the location of the .vsix file you created in step 2, select it, and click "Open" to install your extension.

## Reinstall

- Uninstall the existing extension: Find the extension you want to reinstall in the list of installed extensions. Click the gear icon next to the extension's name and select "Uninstall" from the dropdown menu. Restart Visual Studio Code if prompted.
- Install again