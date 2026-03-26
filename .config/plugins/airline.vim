" Air-line configuration
let g:airline_theme = 'solarized_flood'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
" let g:airline_statusline_ontop=1
let g:airline_left_sep = '>'
let g:airline_right_sep = '<'
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1

" enable/disable vim-ctrlspace integration
let g:airline#extensions#ctrlspace#enable = 1
let g:CtrlSpaceStatuslineFunction = "airline#extensions#ctrlspace#statusline()"
let g:CtrlSpaceSearchTiming = 1000
