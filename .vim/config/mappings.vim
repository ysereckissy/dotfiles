
let mapleader = ","
noremap <leader>] :YcmCompleter GoTo<cr>
nnoremap <leader>l :vertical res +10 <cr>
nnoremap <leader>h :vertical res -10 <cr>
nnoremap <leader>i :res +5 <cr>
nnoremap <leader>k :res -5 <cr>

command EditVimrc :vsplit $MYVIMRC
command SourceVimrc :source $MYVIMRC
nnoremap <leader>ev :EditVimrc<cr>
nnoremap <leader>sv :SourceVimrc<cr>
nnoremap zz :wq<cr>
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <S-h> 0
nnoremap <S-l> $
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>
vnoremap <leader>" <esc>`>a'<esc>`<i'<esc>

inoremap jk <esc>
inoremap <esc> <nop>

