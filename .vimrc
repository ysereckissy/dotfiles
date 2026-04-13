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

" Backup and Undo Redo configuration --------------- {{{
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
" }}}

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
" add built-in packages first
packadd termdebug
packloadall   " Load all plugins.

" Basic vim options setting ---------------------------- {{{
let &showtabline = 0
let &wrap = 1               " Automatically wrap text
set encoding=utf-8      " Set encoding
set incsearch           " Enable incremental search
set number              " Show line number
set laststatus=2        " Enable Status bar
set termguicolors
set listchars=tab:▸\ ,eol:¬     " Define list characters
set mouse=nvi   
set tags+=./tags,tags,~/.vim/system.tags    " Define tag files
set autoindent                  " Respect indentation when starting new line
set hidden
set foldlevelstart=0
" }}}
" FileType autocommands settings ------------------------- {{{
"set background=dark
"colorscheme solarized " Pick a colorscheme
"colorscheme desert " Pick a colorscheme

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
" }}}
let g:netrw_banner = 0

set viminfo='1000,f1,<500,%,s100,h
silent! helptags ALL    " Load help files for all plugins

" Load External Configuration Files ----------------- {{{
let vim_abbreviations_file = "$HOME/dotfiles/.vim/config/abbreviations.vim"
if filereadable(expand(vim_abbreviations_file))
  execute "source " . expand(vim_abbreviations_file)
endif

let cpp_id_configuration_file = '/workdir/config/vim/projects/config.vim'
if filereadable(expand(cpp_id_configuration_file))
  execute "source " . expand(cpp_id_configuration_file)
endif

let vim_plugin_list = "$HOME/dotfiles/plugins.vim"
if filereadable(expand(vim_plugin_list))
  execute "source " . expand(vim_plugin_list)
endif
" }}}
" Configure different plugins
let NERDTreeHijackNetrw = 0

" Some Useful Mappings ----------------------------------- {{{
let mapleader = ","
let maplocalleader = "\\"
"==============================================================
"   Commands definition Section
"==============================================================
command EditVimrc :vsplit $MYVIMRC
command SourceVimrc :source $MYVIMRC
"==============================================================
"   Normal mode Mappings Section
"==============================================================
noremap <leader>] :YcmCompleter GoTo<cr>
" nnoremap <leader>l :vertical res +10 <cr>
" nnoremap <leader>h :vertical res -10 <cr>
" nnoremap <leader>i :res +5 <cr>
" nnoremap <leader>k :res -5 <cr>
nnoremap <leader><s-n> :setlocal number!<cr>
nnoremap <leader>f :call <SID>FoldColumnToggle()<cr>
nnoremap <leader>q :call <SID>QuickfixToggle()<cr>
nnoremap <leader>ev :EditVimrc<cr>
nnoremap <leader>sv :SourceVimrc<cr>
nnoremap zz :wq<cr>
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
"==============================================================
"   Functions definition Section
"==============================================================
function! s:FoldColumnToggle()
  if &foldcolumn
    setlocal foldcolumn=0
  else
    setlocal foldcolumn=4
  endif
  echom &foldcolumn
endfunction

let g:quickfix_is_open = 0
function! s:QuickfixToggle()
  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
    execute g:quickfix_return_to_window . "wincmd w"
  else
    let g:quickfix_return_to_window = winnr()
    copen
    let g:quickfix_is_open = 1
  endif
endfunction

" The following are also response to execise 9. of Learning vimscript the Hard
" Way!
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>
nnoremap <S-h> 0
nnoremap <S-l> $

inoremap jk <esc>
nnoremap <leader>l :set list!<CR>
noremap <leader>t :TagbarToggle<CR>
:noremap <leader>- ddp
:noremap <leader>_ ddP
:inoremap <leader><c-u> jkviwU<esc>ea
:nnoremap <leader><c-u> viwU<esc>
" }}}
" Add some autocmd here combined with abbreviations
" TODO: Find some good way to manage autocmds
" Vimscript autocommands definitions -------------------- {{{
augroup code_snippet
  autocmd!
  autocmd FileType python :iabbrev <buffer> iff if:<left>
  autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
augroup end
augroup filetype_html
  autocmd!
  autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup end 

augroup filetype_vim
  au!
  au FileType vim setlocal foldmethod=marker
augroup end
" }}}
