# Quick Intro and Usage Guide for `fzf`

[Examples](https://github.com/junegunn/fzf/wiki/examples)

## What is `fzf`?

`fzf` is a powerful command-line fuzzy finder that lets you quickly search through and select from lists, such as files, directories, or other data. It’s highly customizable and integrates well with other commands and workflows.

- **Interactive Selection**: `fzf` reads input from standard input (STDIN), displays the list interactively for searching and selection, and outputs the chosen items to standard output (STDOUT).
- **Versatile Use**: Use it to navigate files, directories, git commits, and more.

## Basic Usage Examples

### Example 1: Search Files with `find` and `fzf`

```bash
find * -type f | fzf > selected
```

1. `find * -type f` generates a list of all files in the current directory and subdirectories, which is piped to `fzf`.
2. `fzf` displays this list interactively for you to search and select.
3. The chosen file path is saved to `selected`.

### Example 2: Launch `fzf` Without Input List

```bash
fzf
```

Without an input list, `fzf` scans the file system from the current directory, allowing you to select a file or directory directly.

### Example 3: Open a Selected File in `vim`

```bash
vim $(fzf)
```

1. `fzf` provides a file selection interface.
2. The selected file path is passed to `vim`, which opens it for editing.

### Example 4: Multi-Select Mode with `fzf`

To enable multi-select mode, press `TAB` to mark items. Use `--multi` option for unlimited selection.

```bash
fzf -m
```

## Advanced Search Syntax

In extended-search mode (enabled by default), you can use multiple search terms and special tokens:

| Token       | Match Type                   | Description                                      |
|-------------|------------------------------|--------------------------------------------------|
| `sbtrkt`    | Fuzzy match                  | Matches items that contain "sbtrkt"              |
| `'wild`     | Exact match                  | Matches items that include "wild"                |
| `^music`    | Prefix exact match           | Matches items that start with "music"            |
| `.mp3$`     | Suffix exact match           | Matches items that end with ".mp3"               |
| `!fire`     | Inverse exact match          | Matches items that do not include "fire"         |
| `!^music`   | Inverse prefix exact match   | Matches items that do not start with "music"     |
| `!.mp3$`    | Inverse suffix exact match   | Matches items that do not end with ".mp3"        |
| `|`         | OR                           | Combines terms as an OR operator                 |

### Example Query

To match entries starting with "core" and ending with "go", "rb", or "py":

```text
^core go$ | rb$ | py$
```

## Commonly Used Options

### Search Options

- `-x`, `--extended`: Enable extended-search mode (default).
- `-e`, `--exact`: Enable exact-match mode.
- `-i`, `--ignore-case`: Case-insensitive match (default: smart-case).
  
### Interface and Display

- `-m`, `--multi`: Enable multi-select mode.
- `--height=[~]HEIGHT[%]`: Set the display height of `fzf`.
- `--layout=LAYOUT`: Choose layout (`default`, `reverse`, or `reverse-list`).

### Preview and Scripting

- `--preview=COMMAND`: Display a preview of the highlighted line.
- `--history=FILE`: Enable command history.

### Environment Variables

- `FZF_DEFAULT_COMMAND`: Default command to populate the list (e.g., `find *`).
- `FZF_DEFAULT_OPTS`: Default options (e.g., `--layout=reverse --info=inline`).
