" An example for a vimrc file.
"
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last change:  2019 Dec 17
"
" To use it, copy it to
"              for Unix:  ~/.vimrc
"             for Amiga:  s:.vimrc
"        for MS-Windows:  $VIM\_vimrc
"             for Haiku:  ~/config/settings/vim/vimrc
"           for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup          " do not keep a backup file, use versions instead
else
  set backup            " keep a backup file (restore to previous version)
  let vim_backup_dir = expand('$HOME/tmp/.vim/backupdir')
  if !isdirectory(vim_backup_dir)
    call mkdir(vim_backup_dir, "p")
  endif
  set backupdir=$HOME/tmp/.vim/backupdir

  set undofile          " configure undo file and directory
  let vim_undo_dir = expand('$HOME/tmp/.vim/undodir')
  if !isdirectory(vim_undo_dir)
    call mkdir(vim_undo_dir, "p")
  endif
  set undodir=$HOME/tmp/.vim/undodir

  set swapfile
  let vim_swp_dir = expand('$HOME/tmp/.vim/swp')
  if !isdirectory(vim_swp_dir)
    call mkdir(vim_swp_dir, "p")
  endif
  set directory=$HOME/tmp/.vim/swp
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 100 characters.
  autocmd FileType text setlocal textwidth=100
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

set wrap                " Automatically wrap text
set encoding=utf-8      " Set encoding
set incsearch           " Enable incremental search
set number              " Show line number
set laststatus=2        " Enable Status bar
" Toggle list in normal mode
nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬     " Define list characters
set mouse=nvi   
set tags+=./tags,tags,~/.vim/system.tags    " Define tag files
set autoindent                  " Respect indentation when starting new line

set background=dark
"colorscheme solarized " Pick a colorscheme
colorscheme desert " Pick a colorscheme

" Only do this part when compiled with support for autocommands
if has("autocmd")
  filetype on         " Enable file type detection
  filetype plugin on  " Enable plugins and load plugins for the detected file type
  filetype indent on  " Load and indent files for the detected file types

  " Syntax of these languages is fussy over tabs Vs spaces
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Customisations based on house-style (arbitrary)
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType python set foldmethod=indent
  autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType cpp setlocal ts=4 sts=4 sw=4 expandtab

  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml
  " Open folds on Buffer Read
  autocmd BufRead * normal zR
endif

let g:netrw_banner = 0

" add built-in packages first
packadd termdebug
packadd VimYouCompleteMe
" Load and configure the undotree plugin
noremap <f5> :UndotreeToggle <cr>
packadd undotree
" Load the vim auto-tags plugin
packadd vimautoctags
let g:auto_ctags = 1

packadd vcscommand
packadd vimvc
" g:vc_username = "ysereckissy@markem-imaje.com"
" g:vc_password = "Whhachiaow!11"
packadd vimopenbrowser
packadd vimplantumlsyntax
packadd vimplantumlpreviewer
packadd grepoperator

set spelllang+=fr_FR
set viminfo='1000,f1,<500,%,s100,h
" packadd spellCheck

packloadall   " Load all plugins.
silent! helptags ALL    " Load help files for all plugins

source $HOME/dotfiles/.vim/config/mappings.vim

" Configure different plugins
let NERDTreeHijackNetrw = 0
source $HOME/dotfiles/.config/plugins/nerd-tree.vim

" Add some useful abbreviations
" :iabbrev @@ yannick.sereckissy@gmail.com
:iabbrev ccopy Copyright 2025 Yannick Sereckissy-Namboy, all rights reserved.
:iabbrev ssig -- <cr>Yannick Sereckissy<cr>yannick.sereckissy@gmail.com

autocmd BufNewFile * :write
