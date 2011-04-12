filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" Enable file type detection. Just needed to be off for pathogen
filetype plugin indent on

set nocompatible " Always first
set modelines=0
set encoding=utf-8
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
set wildignore+=*.pyc,*.o,*.obj,*.rbc,.git,.svn,.hg
set nolist
set listchars=tab:▸\ ,eol:¬,trail:·
set showbreak=↪
set fileformats=unix,dos,mac
set scrolloff=5
set sidescrolloff=3
set sidescroll=1
set history=1000
set linespace=0
set incsearch
set hlsearch
set gdefault
set nowrap
set backspace=indent,eol,start
set cursorline
set textwidth=130
set formatoptions=qrn1
set visualbell
set binary noeol
set noequalalways
set clipboard=unnamed
set nofoldenable
set autoread
set statusline=%f\ %m%r\ [%Y]%=%(\ %l,%v\ @\ %p%%\ of\ %L\ %)
set laststatus=2
set t_Co=256
set hidden
set formatprg=par
set background=dark

colorscheme solarized
noh
syntax on

let loaded_delimitMate=1

" Set the leader to something easier than \
let mapleader=" "

if !has("python") || version < 703
    let g:gundo_disable=1
endif

if has("gui_running")
    set columns=120
    set fuoptions=maxhorz,maxvert " Proper fullscreen mode in MacVim
    set guioptions-=T " Hide menu icons by default in MacVim
    set guioptions-=L " Disable left scroll bar
    set guioptions-=r " Disable right scroll bar
    set guifont=Menlo:h11
    set lines=999
    set mouse=a
    highlight SpellBad term=underline gui=undercurl guisp=Orange
    " Command-][ to increase/decrease indentation
    vnoremap <D-]> >gv
    vnoremap <D-[> <gv
    nnoremap <D-]> v>gv<ESC>
    nnoremap <D-[> v<gv<ESC>

    " Command-Option-ArrowKey to switch viewports
    map <D-M-Up> <C-w>k
    imap <D-M-Up> <Esc> <C-w>k
    map <D-M-Down> <C-w>j
    imap <D-M-Down> <Esc> <C-w>j
    map <D-M-Right> <C-w>l
    imap <D-M-Right> <Esc> <C-w>l
    map <D-M-Left> <C-w>h
    imap <D-M-Left> <C-w>h
endif

if has("persistent_undo")
    set undofile
    set undodir=~/.undo
endif

set backupdir=~/.vim/backup
set directory=~/.vim/backup

if has("autocmd")
    " Use soft 4-space tabs by default for everything
    autocmd BufEnter * set ts=4 sts=4 sw=4 expandtab
    autocmd FileType python set colorcolumn=80
    autocmd FileType html set ft=htmldjango
    " Save file when vim loses focus
    autocmd FocusLost * :wa
    " Start NERDTree when Vim starts without any file or directory arguments
    if argc() == 0
        "autocmd VimEnter * silent NERDTree
        " If $WORKDIR is defined, start NERDTree there.
        if strlen($WORKDIR) > 0
            cd $WORKDIR
            " Switch to a different project
            nnoremap <leader>sp :cd $WORKDIR/
        endif
    elseif isdirectory(argv(0))
        exec "cd " . argv(0)
    endif
endif

" Command-T settings
let g:CommandTMaxHeight=8
" Gundo settings
let g:gundo_preview_bottom=1
" Complete Python syntax highlighting
let python_highlight_all=1
" YankRing settings
let g:yankring_history_file='.yankring_history'
" NERDTree settings
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$']
let NERDTreeChDirMode=2
" Disable netrw (it interferes with NERDTree when a
" directory argument is passed from the command line)
let loaded_netrw=1
let loaded_netrwPlugin=1

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Fix `vv`
noremap vv V
" Fix `V`
noremap V <ESC>v$h
" Fix `Y`
nmap Y y$
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
inoremap <C-c> :call InsertCloseTag()<CR>
" Avoid needing to use shift for ex mode
nnoremap ; :
" Run a command line operation
nnoremap <leader>; :silent !
" Turn NERDTree on or off
nnoremap <leader>n :NERDTreeToggle<CR>
" Clear search highlights
nnoremap <leader><space> :noh<CR>
" Quick scratch access
nnoremap <leader><tab> :Sscratch<CR>
" Ack with a literal
nnoremap <leader>al :Ack --literal<space>
" Ack with a regex
nnoremap <leader>ar :Ack<space>
" Edit ~/.vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
" Source (reload) ~/.vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>
" Set filetype to htmldjango
nnoremap <leader>sd :set filetype=htmldjango<CR>
" Open current working directory in Finder
nnoremap <leader>f :silent !open .<CR>
" Find the current file in the NERDTree
nnoremap <leader>F :NERDTreeFind<CR>
" Open GitX
nnoremap <leader>g :silent ! gitx<CR>
" Open Gundo
nnoremap <leader>G :GundoToggle<CR>
" Toggle HexHighlight plugin
nnoremap <leader>h :call HexHighlight()<CR>
" Sort CSS properties
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>
" Make CommandT work
nnoremap <leader>t :CommandT<CR>
" Open current working directory in TextMate
nnoremap <leader>T :silent !mate .<CR>
" Reselect pasted text
nnoremap <leader>v V`]
" Open new v split and switch to it
nnoremap <leader>w <C-w>v<C-w>l
" Strip trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
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

command! -nargs=* Wrap set wrap linebreak nolist

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