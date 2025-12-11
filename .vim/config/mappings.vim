
let mapleader = ","
"==============================================================
"   Commands definition Section
"==============================================================
command EditVimrc :vsplit $MYVIMRC
command SourceVimrc :source $MYVIMRC
"==============================================================
"   Normal mode Mappings Section
"==============================================================
noremap <leader>] :YcmCompleter GoTo<cr>
nnoremap <leader>l :vertical res +10 <cr>
nnoremap <leader>h :vertical res -10 <cr>
nnoremap <leader>i :res +5 <cr>
nnoremap <leader>k :res -5 <cr>
nnoremap <leader><s-n> :setlocal number!<cr>
nnoremap <leader>f :call <SID>FoldColumnToggle()<cr>
nnoremap <leader>q :call <SID>QuickfixToggle()<cr>
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

vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>
vnoremap <leader>" <esc>`>a'<esc>`<i'<esc>

inoremap jk <esc>
inoremap <esc> <nop>

