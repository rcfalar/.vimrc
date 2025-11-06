# My .vimrc Configuration

A simple, efficient Vim setup optimized for productivity and ease of use.  

## Features

- **General Enhancements:** Syntax highlighting, line numbers, relative numbers, cursorline, word wrap, system clipboard support.  
- **Leader Key:** Spacebar as leader key for quick shortcuts.  
- **Tabs & Indentation:** Smart indentation, 4-space tabs, auto-indent.  
- **Search:** Case-insensitive with smartcase, incremental search, highlighted results.  
- **Status Line:** File info, line count, percentage, date/time, modified flag.  
- **Splits & Tabs:** Easy navigation and management with shortcuts.  
- **Netrw File Explorer:** Tree-style view, toggleable, opens in vertical split.  
- **Clipboard Shortcuts:** Copy, cut, paste integrated with system clipboard.  
- **Buffer Management:** Next/previous, delete, list buffers.  
- **Quick Commenting:** Line and selection commenting for TCL files.  
- **Persistent Undo & Backup:** Keep history and undo info across sessions.  

## Installation

```bash
# Backup existing vimrc
mv ~/.vimrc ~/.vimrc.backup

# Clone this repo and link the vimrc
git clone <repo_url> ~/.vim
ln -s ~/.vim/.vimrc ~/.vimrc
