# React component generator

A simpler VS Code extension for generating new React component files with the following structure:

- `NewComponentName`
  - `NewComponentName.jsx`
  - `NewComponentName.module.scss`

## Features

Right click in the file editor or on a file in the explorer and click `Generate component folder` after providing a name as input a new folder will be created in that location with the input as folder name and with 2 files (JSX and SCSS) within it.

The JSX file already has a functional component template written plus the import statement of the SCSS file.

This extension was inspired by React component generator created by https://github.com/andrewmcgov

## Latest update

0.6 - TypeScript template added.


If a folder with the same name provided already exists, the existing folder will not be overwritten and an error message will be shown.

If the input is empty, there won't be a folder with the name "undefined" created and an error message will be shown.

Input's first letter is automatically capitalized.

When created the text editor opens the JSX file automatically and a success message is shown.
