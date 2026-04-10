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
Plug 'ycm-core/YouCompleteMe'

call plug#end()

let airline_config_file = "$HOME/dotfiles/.vim/config/plugins/airline.vim"
if filereadable(expand(airline_config_file))
  execute "source " . expand(airline_config_file)
endif

if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif

let nerdtree_syntax_config_file = "$HOME/dotfiles/.vim/config/plugins/nerdtree-syntax-highlight.vim"
if filereadable(expand(nerdtree_syntax_config_file))
    execute "source " . expand(nerdtree_syntax_config_file)
endif

let nerdtree_config_file = "$HOME/dotfiles/.vim/config/plugins/nerd-tree.vim"
if filereadable(expand(nerdtree_config_file))
  execute "source " . expand(nerdtree_config_file)
endif

