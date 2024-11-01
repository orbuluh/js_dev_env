
# `fd` Command Cookbook

## 1. **List All Files Recursively (Similar to `ls -R`)**

- **Scenario**: List all files and directories in the current directory.
- **Command**:

  ```bash
  fd
  ```

- **Example**:

  ```bash
  fd
  ```

## 2. **Simple Search for a File or Directory**

- **Scenario**: Search for files or directories with a name containing a specific pattern in the current directory.
- **Command**:

  ```bash
  fd <pattern>
  ```

- **Example**:

  ```bash
  fd netfl
  ```

## 3. **Search for a Specific File Extension**

- **Scenario**: Find files with a particular extension.
- **Command**:

  ```bash
  fd -e <extension>
  ```

- **Example**:

  ```bash
  fd -e md
  ```

## 4. **Case-Insensitive Search**

- **Scenario**: Search for files or directories ignoring case.
- **Command**:

  ```bash
  fd -i <pattern>
  ```

- **Example**:

  ```bash
  fd -i myfile
  ```

## 5. **Search in Hidden and Ignored Files**

- **Scenario**: Search in hidden files and directories (including `.gitignore`-ignored files).
- **Command**:

  ```bash
  fd -H -I <pattern>
  ```

- **Example**:

  ```bash
  fd -H -I secret
  ```

## 6. **Match Full Path Instead of Filename Only**

- **Scenario**: Match the full path of files, not just the filename.
- **Command**:

  ```bash
  fd -p <pattern>
  ```

- **Example**:

  ```bash
  fd -p '^/home/user/documents'
  ```

## 7. **Limit Search Depth**

- **Scenario**: Search only within a specified number of directory levels.
- **Command**:

  ```bash
  fd -d <depth> <pattern>
  ```

- **Example**:

  ```bash
  fd -d 2 config
  ```

## 8. **Execute a Command for Each Search Result**

- **Scenario**: Run a command on each search result (e.g., formatting files).
- **Command**:

  ```bash
  fd -x <command> <args>
  ```

- **Example**:

  ```bash
  fd -e cpp -x clang-format -i
  ```

## 9. **Batch Execute a Command for All Results**

- **Scenario**: Run a single command for all search results at once.
- **Command**:

  ```bash
  fd -X <command> <args>
  ```

- **Example**:

  ```bash
  fd -e txt -X cat > all_text_files.txt
  ```

## 10. **Search Using Regular Expressions**

- **Scenario**: Use regular expressions to refine the search pattern.
- **Command**:

  ```bash
  fd '<regex_pattern>'
  ```

- **Example**:

  ```bash
  fd '^x.*rc$'
  ```

## 11. **Exclude Specific Files or Directories**

- **Scenario**: Exclude files or directories that match a specified pattern.
- **Command**:

  ```bash
  fd -E <pattern> <search_term>
  ```

- **Example**:

  ```bash
  fd -H -E .git private_data
  ```

## 12. **Glob-Based Search**

- **Scenario**: Search using glob patterns (instead of regex).
- **Command**:

  ```bash
  fd -g <glob_pattern>
  ```

- **Example**:

  ```bash
  fd -g '*.so' /usr
  ```

## 13. **Delete Files that Match a Pattern**

- **Scenario**: Find and delete files that match a pattern (use carefully).
- **Command**:

  ```bash
  fd -X rm <pattern>
  ```

- **Example**:

  ```bash
  fd -H '^\.DS_Store$' -tf -X rm
  ```

## 14. **Filter by File Size**

- **Scenario**: Search for files within a specific size range.
- **Command**:

  ```bash
  fd -S <size> <pattern>
  ```

- **Example**:

  ```bash
  fd -S +1M -S -10M large_file
  ```

## 15. **Search by File Type**

- **Scenario**: Limit results by file type, such as files, directories, symlinks, etc.
- **Command**:

  ```bash
  fd -t <filetype> <pattern>
  ```

- **Example**:

  ```bash
  fd -t f config
  ```

## 16. **Display Results in Long Listing Format**

- **Scenario**: Show results with details (like `ls -l`).
- **Command**:

  ```bash
  fd -l <pattern>
  ```

- **Example**:

  ```bash
  fd -l
  ```

## 17. **Follow Symbolic Links**

- **Scenario**: Follow symbolic links in the search.
- **Command**:

  ```bash
  fd -L <pattern>
  ```

- **Example**:

  ```bash
  fd -L my_symlink
  ```

## 18. **Search Files Modified Within a Time Range**

- **Scenario**: Search for files changed within a specific time period.
- **Command**:

  ```bash
  fd --changed-within <duration> <pattern>
  ```

- **Example**:

  ```bash
  fd --changed-within 1d notes
  ```

## 19. **Use Placeholders in Command Execution**

- **Scenario**: Perform specific actions on matched files using placeholders.
- **Command**:

  ```bash
  fd -e jpg -x mv {} /backup
  ```

- **Example**:

  ```bash
  fd -e jpg -x convert {} {.}.png
  ```

## 20. **Use Global and Local Ignore Files**

- **Scenario**: Ignore files and directories permanently with `.fdignore`.
- **Command**:

  ```bash
  echo "*.bak" > ~/.fdignore
  ```
