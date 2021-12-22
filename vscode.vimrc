" In VSCode settings:
" Turn on "Vimrc: Enable"
" and set "Vimrc: Path" to `$HOME/.vim/vscode.vimrc`
" Set "Vim: Leader" to " " (no quotes)
" Turn on "Vim: Use System Clipboard"
" Turn on "Vim: Hlsearch"

set smartcase
set incsearch

" Avoid needing to use shift for ex mode
nnoremap ; :
vnoremap ; :
" Fix `vv`
noremap vv V
" Fix `V`
noremap V <ESC>v$h
" Fix `Y`
nmap Y y$
" Normal mode indent with one keypress
nmap > >>
nmap < <<
" Clear search highlights
nnoremap <leader><space> :nohlsearch<CR>
" Make splits take up the same amount of space
nnoremap <leader>= <C-w>=
" Open new h split and switch to it
nnoremap <leader>h :sp<CR><C-w>j
" Open new v split and switch to it
nnoremap <leader>v :vs<CR><C-w>l
" Switch windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
