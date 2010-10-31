filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" Enable file type detection. Just needed to be off for pathogen
filetype plugin indent on

set nocompatible " Always first
set modelines=0
set background=dark
set autoindent
set smartindent
set ignorecase
set smartcase
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set showmatch
set showmode
set ruler
set title
set wildmenu
set wildmode=list:longest
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
set visualbell
set binary noeol
set clipboard=unnamed
set foldmethod=indent
set foldnestmax=3
set nofoldenable
set autoread
set statusline=%f\ %=%-14.(%m%r%h%w\ ff:%{&ff}\ ft:%Y\ \ %l,%v\ @\ %p%%\ of\ %L%)\ Line\(s\)
set mouse=a
set t_Co=256
"set colorcolumn=80

noh
syntax on
colors molokai

if !has("python")
    let loaded_gundo=1
endif

if has("gui_running")
    set fuoptions=maxhorz,maxvert " Proper fullscreen mode in MacVim
    set guioptions-=T " Hide menu icons by default in MacVim
    highlight SpellBad term=underline gui=undercurl guisp=Orange
    " Start in the projects directory; define $WORKDIR in
    " your .bashrc or .bash_profile
    cd $WORKDIR
endif

if has("persistent_undo")
    set undofile
    set undodir=~/.undo
endif

if has("autocmd")
    " Use soft 4-space tabs for my most common files
    autocmd FileType html setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType htmldjango setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType sass setlocal ts=4 sts=4 sw=4 expandtab
    autocmd FileType vim setlocal ts=4 sts=4 sw=4 expandtab
endif

" NERDTree settings
let NERDTreeIgnore=['\.pyc$']
let NERDTreeChDirMode=2
if has("autocmd")
    " Use the same NERDTree between buffers
    autocmd BufEnter * silent NERDTreeMirror
    if has("gui_macvim")
        " Start NERTree when vim starts
        autocmd VimEnter * silent NERDTree
    endif
endif

" Save file when vim loses focus
au FocusLost * :wa
" Command-T settings
let g:CommandTMaxHeight=8
" Disable netrw (it interferes with NERDTree when a
" directory argument is passed from the command line)
let loaded_netrw=1
let loaded_netrwPlugin=1

" Set the leader to \
let mapleader="\\"
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Turn Rainbow Parentheses on or off
nmap <leader>r :RainbowParenthesesToggle<CR>
" Refresh Command-T
nmap <leader>R :CommandTFlush<CR>
" Get out of insert mode more easily
call arpeggio#map('i', '', 0, 'jk', '<Esc>') " Press j and k at the same time
inoremap jj <ESC>
" HTML tag closing
inoremap <C-_> <Space><BS><Esc>:call InsertCloseTag()<CR>
" Avoid needing to use shift for ex mode
nnoremap ; :
" Make CommandT work
nnoremap <leader>t :CommandT<CR>
" Open current working directory in TextMate
nnoremap <leader>T :silent !mate .<CR>
" Gundo
nnoremap <leader>G :GundoToggle<CR>
" Run a command line operation
nnoremap <leader>; :silent !
" Quick scratch access
nnoremap <leader><tab> :Sscratch<CR>
" Clear search highlights
nnoremap <leader><space> :noh<CR>
" Turn NERDTree on or off
nnoremap <leader>\ :NERDTreeToggle<CR>
" Ack with a literal
nnoremap <leader>al :Ack --literal 
" Ack with a regex
nnoremap <leader>ar :Ack 
" Edit ~/.vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
" Source (reload) ~/.vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>
" Find the current file in the NERDTree
nnoremap <leader>f :NERDTreeFind<CR>
" Open current working directory in Finder
nnoremap <leader>F :silent !open .<CR>
" Open gitx
nnoremap <leader>g :silent ! gitx<CR>
" Toggle Hex Highlight plugin
nnoremap <leader>h :call HexHighlight()<CR>
" Open new v split and switch to it
nnoremap <leader>w <C-w>v<C-w>l
" Strip trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" Sort CSS properties
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
" Make j/k move by display line, rather than by file line
nnoremap j gj
nnoremap k gk

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