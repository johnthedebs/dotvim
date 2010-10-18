filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible
set modelines=0
set background=dark
set autoindent
set smartindent
set ignorecase
set smartcase
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set showmatch
set showmode
set ruler
set title
set wildmenu
set wildignore+=*.pyc,.git,.svn,.hg
set list
set listchars=tab:▸\ ,eol:¬,trail:·
set encoding=utf-8
set fileformats=unix,dos,mac
set scrolloff=10
set sidescrolloff=7
set sidescroll=1
set history=1000
set linespace=0
set incsearch
set hlsearch
set gdefault
set nowrap
set backspace=indent,eol,start
set cursorline
set textwidth=79
set formatoptions=qrn1
set undofile
set undodir=~/.undo
set visualbell
set binary noeol
set clipboard=unnamed
set foldmethod=indent
set foldnestmax=3
set nofoldenable
set autoread
set mouse=a
set t_Co=256
"set colorcolumn=80
"set virtualedit=onemore

colors molokai
syntax on
noh

if has("gui_running")
    set fuopt=maxhorz,maxvert " Proper fullscreen mode in MacVim
    set guioptions-=T " Hide menu icons by default in MacVim
endif

if has("autocmd")
    " Enable file type detection
    filetype plugin indent on
    " Use soft 4-space tabs for my most common files
    autocmd FileType html setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType sass setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType vim setlocal ts=4 sts=4 sw=4 expandtab
    " Start NERTree when vim starts
    autocmd VimEnter * silent NERDTree
    " Use the same NERDTree between buffers
    autocmd BufEnter * silent NERDTreeMirror
endif

" NERDTree settings
let NERDTreeIgnore=['\.pyc$']
let NERDTreeChDirMode=2
let g:NERDTreeMapOpenVSplit="i"

" Command-T settings
let g:CommandTMaxHeight=8

" Save file when vim loses focus
au FocusLost * :wa
" Start in the projects directory
cd $WORKDIR

" Set the leader to something easier than \
let mapleader=" "
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Git diff
nmap <leader>d :!git diff %<CR>
" Get out of insert mode more easily
inoremap jj <ESC>
" Run a command line operation
nnoremap <leader>; :silent !
" Avoid needing to use shift for ex mode
nnoremap ; :
" Quick scratch access
nnoremap <leader><tab> :Sscratch<CR>
" Turn NERDTree on or off
nnoremap <leader>\ :NERDTreeToggle<CR>
" Edit ~/.vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" Clear search highlights
nnoremap <leader><space> :noh<CR>
" Find the current file in the NERDTree
nnoremap <leader>f :NERDTreeFind
" Open gitx
nnoremap <leader>g :silent ! gitx<CR>
" Turn Rainbow Parentheses on or off
nmap <leader>r :RainbowParenthesesToggle<CR>
" Refresh Command-T and NERTree
nmap <leader>R :CommandTFlush
nmap <leader>NR :NERDTreeMapRefreshRoot
" Open new v split and switch to it
nnoremap <leader>w <C-w>v<C-w>l
" Strip trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" Sort CSS properties
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
" Get to Ack
nnoremap <leader>a :Ack 

" Switch windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Switch tabs
map <D-S-]> gt
map <D-S-[> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

" Make j/k move by display line, rather than by file line
nnoremap j gj
nnoremap k gk

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Set tabstop, softtabstop and shiftwidth to the same value
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction