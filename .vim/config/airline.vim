" Air-line configuration
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
