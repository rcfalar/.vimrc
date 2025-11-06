" ════════════════════════════════════════════════════════════════════════════════════════════════
"  simple .vimrc Configuration
"  Last Modified: 11/06/2025 - RCF
" ════════════════════════════════════════════════════════════════════════════════════════════════

" ────────────────────────────────────────────────────────────────────────────────────────────────
"  General Settings
" ────────────────────────────────────────────────────────────────────────────────────────────────

set nocompatible                    " Disable old vi compatibility
filetype plugin indent on           " Enable filetype detection, plugins, and indent
syntax on                           " Enable syntax highlighting
set encoding=utf-8                  " Use UTF-8 encoding
set number                          " Show line numbers
set relativenumber                  " Show relative line numbers
set showcmd                         " Show last command in status line
set showmode                        " Show current mode
set wrap                            " Enable word wrapping
set ruler                           " Show line/column info
set cursorline                      " Highlight current line
set hidden                          " Allow switching buffers without saving
set clipboard=unnamedplus           " Use system clipboard
colorscheme blue                    " Default color theme

" ────────────────────────────────────────────────────────────────────────────────────────────────
"  Leader Key
" ────────────────────────────────────────────────────────────────────────────────────────────────
let mapleader = " "                 " Set leader key to spacebar

" ────────────────────────────────────────────────────────────────────────────────────────────────
"  Indentation & Tabs
" ────────────────────────────────────────────────────────────────────────────────────────────────
set tabstop=4                       " Number of spaces per tab
set shiftwidth=4                    " Indent width
set smartindent                     " Auto-indent new lines
set autoindent                      " Copy indent from current line
set formatoptions-=o                " Don't auto-insert comment leader
set matchpairs+=<:>                 " Match angle brackets

" ────────────────────────────────────────────────────────────────────────────────────────────────
"  Search Settings
" ────────────────────────────────────────────────────────────────────────────────────────────────
set ignorecase                      " Case-insensitive search
set smartcase                       " Case-sensitive if search has capitals
set hlsearch                        " Highlight search results
set incsearch                       " Incremental search

" ────────────────────────────────────────────────────────────────────────────────────────────────
"  UI Enhancements
" ────────────────────────────────────────────────────────────────────────────────────────────────
set wildmenu                        " Better command-line completion
set lazyredraw                      " Faster scrolling
set termguicolors                   " Enable true colors
set scrolloff=9                     " Keep 9 lines visible around cursor
set signcolumn=auto                 " Show sign column when needed

" ────────────────────────────────────────────────────────────────────────────────────────────────
"  Status Line
" ────────────────────────────────────────────────────────────────────────────────────────────────
set laststatus=2                    " Always show status line
set statusline=%<%f%h%w%r           " File info on left
set statusline+=%=                  " Switch to middle
set statusline+=line\ %l/%L\ \|\ %p%%  " Line count and percentage
set statusline+=\ %=                " Switch to right
set statusline+=%{strftime(\"\%m/\%d/\%y\ \%H:\%M\")}\ %m  " Date, time, modified flag

" ────────────────────────────────────────────────────────────────────────────────────────────────
"  Split Navigation
" ────────────────────────────────────────────────────────────────────────────────────────────────
nnoremap <C-h> <C-w>h               " Move to left split
nnoremap <C-j> <C-w>j               " Move to split below
nnoremap <C-k> <C-w>k               " Move to split above
nnoremap <C-l> <C-w>l               " Move to right split

" ────────────────────────────────────────────────────────────────────────────────────────────────
"  Quality of Life
" ────────────────────────────────────────────────────────────────────────────────────────────────
set confirm                         " Ask before quitting unsaved file
set history=1000                    " Command history size
set undofile                        " Persistent undo
set undolevels=10000                " More undo history
set undoreload=10000                " Save more lines for undo on buffer reload
set backupdir=~/.vim/tmp,.          " Backup directory
set directory=~/.vim/tmp,.          " Swap file directory

" ────────────────────────────────────────────────────────────────────────────────────────────────
"  Netrw File Explorer Settings
" ────────────────────────────────────────────────────────────────────────────────────────────────
let g:netrw_banner = 0              " Hide banner
let g:netrw_liststyle = 3           " Tree-style view
let g:netrw_browse_split = 3        " Open files in a new tab 
let g:netrw_altv = 1                " Open splits to the right
let g:netrw_winsize = 25            " Width of netrw window (25%)

" ────────────────────────────────────────────────────────────────────────────────────────────────
"  Autocommands
" ────────────────────────────────────────────────────────────────────────────────────────────────

" Apply relative line numbers to netrw buffers
augroup netrw_settings
    autocmd!
    autocmd FileType netrw setlocal number relativenumber
augroup END

" Apply relative line numbers to all buffers
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

" Launch netrw in vertical split on startup if no file is specified
augroup netrw_startup
    autocmd!
    autocmd VimEnter * if argc() == 0 | Vexplore | wincmd l | endif
augroup END

" Prevent auto-commenting on new lines
augroup format_options
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=ro
augroup END

" TCL-SPECIFIC SETTINGS
augroup tcl_settings
    autocmd!
    autocmd FileType tcl setlocal commentstring=#\ %s
    autocmd FileType tcl setlocal expandtab tabstop=4 shiftwidth=4
    autocmd FileType tcl setlocal iskeyword+=:,-  " Include : and - in word definition
augroup END

" ────────────────────────────────────────────────────────────────────────────────────────────────
"  Netrw Toggle Functions
" ────────────────────────────────────────────────────────────────────────────────────────────────

" Check if netrw buffer exists in current tab
function! NetrwIsOpen()
    for i in range(1, winnr('$'))
        if getwinvar(i, '&filetype') == 'netrw'
            return i
        endif
    endfor
    return 0
endfunction

" Toggle netrw in vertical split
function! ToggleNetrwVSplit()
    let netrw_win = NetrwIsOpen()
    if netrw_win
        if winnr() == netrw_win
            close
        else
            execute netrw_win . 'wincmd w'
            close
        endif
    else
        Vexplore
    endif
endfunction

" Toggle netrw in current window
function! ToggleNetrwNormal()
    let netrw_win = NetrwIsOpen()
    if netrw_win
        if winnr() == netrw_win
            if winnr('$') == 1
                bprevious
            else
                close
            endif
        else
            execute netrw_win . 'wincmd w'
        endif
    else
        Explore
    endif
endfunction

" ────────────────────────────────────────────────────────────────────────────────────────────────
"  Key Bindings
" ────────────────────────────────────────────────────────────────────────────────────────────────
nnoremap <leader>e :call ToggleNetrwVSplit()<CR>            " Toggle netrw in vertical split
nnoremap <leader>E :call ToggleNetrwNormal()<CR>            " Toggle netrw in current window

" VISUAL BLOCK MODE (Ctrl+V remapped for paste)
nnoremap <leader>q <C-v>                                    " Visual block mode with Spacebar+Q

"CLIPBOARD OPERATIONS
vnoremap <C-c> "+y                                          " Copy to system clipboard in visual mode
vnoremap <C-x> "+d                                          " Cut to system clipboard in visual mode
nnoremap <C-v> "+p                                          " Paste from system clipboard in normal mode
inoremap <C-v> <C-r>+                                       " Paste from system clipboard in insert mode
vnoremap <C-v> "+p                                          " Paste from system clipboard in visual mode

" BUFFER MANAGEMENT
nnoremap <leader>n :bnext<CR>                               " Next buffer
nnoremap <leader>p :bprevious<CR>                           " Previous buffer
nnoremap <leader>d :bdelete<CR>                             " Delete buffer
nnoremap <leader>ls :ls<CR>:b<Space>                        " List and switch buffers

" SEARCH ENHANCEMENTS
nnoremap <leader>h :nohlsearch<CR>                          " Clear search highlighting
nnoremap n nzzzv                                            " Center screen on next search result
nnoremap N Nzzzv                                            " Center screen on previous search result

" BUFFER MANAGEMENT
nnoremap <leader>n :bnext<CR>                               " Next buffer
nnoremap <leader>p :bprevious<CR>                           " Previous buffer
nnoremap <leader>d :bdelete<CR>                             " Delete buffer
nnoremap <leader>ls :ls<CR>:b<Space>                        " List and switch buffers

" SEARCH ENHANCEMENTS
nnoremap <leader>h :nohlsearch<CR>                          " Clear search highlighting
nnoremap n nzzzv                                            " Center screen on next search result
nnoremap N Nzzzv                                            " Center screen on previous search result

" QUICK COMMENTING FOR TCL (# comment style)
nnoremap <leader>c I# <Esc>                                 " Comment line
nnoremap <leader>u ^2x                                      " Uncomment line
vnoremap <leader>c :s/^/# /<CR>:nohlsearch<CR>              " Comment selection
vnoremap <leader>u :s/^# //<CR>:nohlsearch<CR>              " Uncomment selection

" SPLIT MANAGEMENT
nnoremap <leader>v :vsplit<CR>                              " Vertical split
nnoremap <leader>s :split<CR>                               " Horizontal split
set splitright                                              " New vertical splits on right
set splitbelow                                              " New horizontal splits below

" SEARCH AND REPLACE
nnoremap <leader>* :%s/\<<C-r><C-w>\>//g<Left><Left>        " Replace word under cursor

" SPLIT AND TAB MANAGEMENT
nnoremap <leader>x <C-w>c                                   " Close current split
nnoremap <leader>o <C-w>o                                   " Close all other splits (keep current)
nnoremap <leader>T <C-w>T                                   " Move split to new tab
nnoremap <leader>tn :tabnew<CR>                             " New tab
nnoremap <leader>tc :tabclose<CR>                           " Close tab
nnoremap <leader>1 1gt                                      " Go to tab 1
nnoremap <leader>2 2gt                                      " Go to tab 2
nnoremap <leader>3 3gt                                      " Go to tab 3
nnoremap <leader>4 4gt                                      " Go to tab 4
nnoremap <leader>5 5gt                                      " Go to tab 5
nnoremap gt :tabnext<CR>                                    " Next tab
nnoremap gT :tabprevious<CR>                                " Previous tab

" ════════════════════════════════════════════════════════════════════════════════════════════════
"  End of Configuration
"════════════════════════════════════════════════════════════════════════════════════════════════
