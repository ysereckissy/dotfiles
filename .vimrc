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
set showtabline=0
set wrap               " Automatically wrap text
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
" Abbreviations Definitions --------------------------------------------- {{{
" Add some useful abbreviations
iabbrev adn and
iabbrev waht what
iabbrev tehn then
iabbrev @@ ysereckissy@markem-imaje.com
iabbrev ccopy Copyright 2025 Yannick Sereckissy-Namboy, all rights reserved.
iabbrev ssig -- <cr>Yannick Sereckissy<cr>ysereckissy@markem-imaje.com
" }}}
" Projects Configurations -------------------------------------------- {{{
let cpp_id_configuration_file = '/workdir/config/vim/projects/config.vim'
if filereadable(expand(cpp_id_configuration_file))
  execute "source " . expand(cpp_id_configuration_file)
endif
" }}}
let g:netrw_banner = 0

set viminfo='1000,f1,<500,%,s100,h
silent! helptags ALL    " Load help files for all plugins

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

" External Vim Plugins Configurations ----------------- {{{
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin management with vim-plug
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-ctrlspace/vim-ctrlspace'
Plug 'mhinz/vim-signify'
Plug 'inside/vim-grep-operator'
Plug 'mbbill/undotree'
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'aklt/plantuml-syntax'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" C/C++ Plugins
Plug 'bfrg/vim-c-cpp-modern'
Plug 'ludovicchabant/vim-gutentags'
Plug 'preservim/tagbar'
Plug 'vim-scripts/vim-svngutter'
" Web development Plugin
Plug 'mattn/emmet-vim'
Plug 'skammer/vim-css-color'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'airblade/vim-tailwind'
" Plug 'ycm-core/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}
call plug#end()

" Vim Airline Plugin Configuration --------------------------- {{{
let g:airline_theme = 'google_light'
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#show_buffers = 1
" let g:airline_statusline_ontop=1
let g:airline_left_sep = '>'
let g:airline_right_sep = '<'
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
let g:airline_exclude_preview = 1

" enable/disable vim-ctrlspace integration
let g:airline#extensions#ctrlspace#enable = 1
let g:ctrlspace_status_line_function = "airline#extensions#ctrlspace#statusline()"

let g:ctrlspace_use_tabline = 1
hi CtrlSpaceSelected term=reverse ctermfg=187   guifg=#d7d7af ctermbg=23    guibg=#005f5f cterm=bold gui=bold
hi CtrlSpaceNormal   term=NONE    ctermfg=244   guifg=#808080 ctermbg=232   guibg=#080808 cterm=NONE gui=NONE
hi CtrlSpaceSearch   ctermfg=220  guifg=#ffd700 ctermbg=NONE  guibg=NONE    cterm=bold    gui=bold
hi CtrlSpaceStatus   ctermfg=230  guifg=#ffffd7 ctermbg=234   guibg=#1c1c1c cterm=NONE    gui=NONE
" }}}
" Control Space Plugin Configuration ------------------------------------- {{{
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif
" }}}
" NERDTree Plugin Configuration --------------------------------------- {{{
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:NERDTreeFileLines = 1
let g:NERDTreeDirArrowExpandable = '|'
let g:NERDTreeDirArrowCollapsible = '--'

" Configure vim-nerdtree-syntax-highlight plugin
let g:WebDevIconsDisableDefaultFolderSymbolColorFromNERDTreeDir = 1
let g:WebDevIconsDisableDefaultFileSymbolColorFromNERDTreeFile = 1

" Disable Highlighting
let g:NERDTreeDisableFileExtensionHighlight = 1
let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1

" Highlight full name
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" Highlight folder using exact match
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

" Customizing colors
" you can add these colors to your .vimrc to help customizing
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = s:blue " sets the color of css files to blue

let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files

let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb

let g:WebDevIconsDefaultFolderSymbolColor = s:beige " sets the color for folders that did not match any rule
let g:WebDevIconsDefaultFileSymbolColor = s:blue " sets the color for files that did not match any rule

" If you have vim-devicons you can customize your icons for each file type.
let g:NERDTreeExtensionHighlightColor = {} "this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = '' "assigning it to an empty string will skip highlight

" Disable uncommon file extension highlighting
let g:NERDTreeLimitedSyntax = 1

" Disable all default file highlighting
let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeSyntaxDisableDefaultExactMatches = 1
let g:NERDTreeSyntaxDisableDefaultPatternMatches = 1

" set g:NERDTreeExtensionHighlightColor if you want a custom color instead of the default one
let g:NERDTreeSyntaxEnabledExtensions = ['hbs', 'lhs'] " enable highlight to .hbs and .lhs files with default colors
let g:NERDTreeSyntaxEnabledExactMatches = ['dropbox', 'node_modules', 'favicon.ico'] " enable highlight for dropbox and node_modules folders, and favicon.ico files with default colors
" NERDTree Syntax Hightlight Plugin Configuration ----------------- {{{
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = s:blue " sets the color of css files to blue

let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files

let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb

let g:WebDevIconsDefaultFolderSymbolColor = s:beige " sets the color for folders that did not match any rule
let g:WebDevIconsDefaultFileSymbolColor = s:blue " sets the color for files that did not match any rule
" }}}
" }}}

" }}}
