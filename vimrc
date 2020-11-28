call plug#begin("~/.vim/plugged")
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/nerdcommenter'
Plug 'sjl/gundo.vim'
Plug 'kana/vim-arpeggio'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/taglist.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-git'
Plug 'mattn/gist-vim'
Plug 'godlygeek/tabular'
Plug 'Raimondi/delimitMate'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-rhubarb'
Plug 'styled-components/vim-styled-components'
Plug 'hail2u/vim-css3-syntax'
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'neoclide/coc.nvim'
Plug 'ervandew/supertab'
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-eunuch'
Plug 'morhetz/gruvbox'
Plug 'dyng/ctrlsf.vim'
Plug '~/.vim/bundle/matchit'
Plug '~/.vim/bundle/django'
call plug#end()

filetype plugin indent on

set nocompatible " Always first
set modelines=0
set encoding=utf-8
set autoindent
set nosmartindent
set ignorecase
set smartcase
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround
set showmatch
set noshowmode
set ruler
set title
set wildmenu
set wildmode=list:longest
set wildignore+=~*,*.pyc,*.o,*.obj,*.rbc,*.tfstate,*.tfstate.backup,.git,.svn,.hg,.DS_Store,__pycache__,.sassc,.scssc.sass-cache,node_modules,bower_components,tmp,__pycache__,dist,.meteor,vendor,dist-dev
set nolist
set listchars=tab:▸\ ,eol:¬,trail:·
set showbreak=↪
set fileformats=unix,dos,mac
set scrolloff=1
set sidescrolloff=3
set sidescroll=1
set history=1000
set linespace=0
set incsearch
set hlsearch
set gdefault
set nowrap
set paste
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
set laststatus=2
set t_Co=256
set hidden
set formatprg=par
set viminfo='10,\"100,:20,!,%,n~/.vim/info/viminfo


"colorscheme molokai
"" Based on molokai scheme from: https://github.com/junegunn/fzf/wiki/Color-schemes
"let $FZF_DEFAULT_OPTS='
"\  --color fg:252,bg:233,hl:67,fg+:252,bg+:235,hl+:81
"\  --color info:144,prompt:#F9BD2E,spinner:135,pointer:135,marker:118
"\'

" Gruvbox config
let g:gruvbox_vert_split='bg3'
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
" Based on gruvbox scheme from: https://github.com/junegunn/fzf/wiki/Color-schemes
let $FZF_DEFAULT_OPTS='
\  --color fg:#ebdbb2,bg:#1E2021,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
\  --color info:#83a598,prompt:#F9BD2E,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54
\'

set background=dark
set mouse=a

nohlsearch
syntax on


" Set the leader to something easier than \
let mapleader=" "

if !has("python") || version < 703
    let g:gundo_disable=1
endif

if has("gui_running")
    set columns=90
    set fuoptions=maxhorz,maxvert " Proper fullscreen mode in MacVim
    set guioptions-=T " Hide menu icons by default in MacVim
    set guioptions-=L " Disable left scroll bar
    set guioptions-=r " Disable right scroll bar
    set guifont=Inconsolata:h16
    set lines=999
    highlight SpellBad term=underline gui=undercurl guisp=Orange

    " Command-][ to increase/decrease indentation
    vnoremap <D-]> >gv
    vnoremap <D-[> <gv
    nnoremap <D-]> v>gv<ESC>
    nnoremap <D-[> v<gv<ESC>

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
endif

if has("persistent_undo")
    set undofile
    set undodir=~/.vim/undo
endif

set backupdir=~/.vim/backup
set directory=~/.vim/backup

if argc() == 0
    " If $WORKDIR is defined, start NERDTree there.
    if strlen($WORKDIR) > 0
        cd $WORKDIR
        " Switch to a different project
        nnoremap <leader>sp :cd $WORKDIR/
    endif
elseif isdirectory(argv(0))
    exec "cd " . argv(0)
endif

if has("autocmd")
    " Use soft tabs for most things, and 2-space or 4-space depending on
    " filetype
    autocmd BufEnter *.rb,*.js,*.css,*.sass,*.tf set ts=2 sts=2 sw=2 expandtab
    autocmd BufEnter *.py,*.html,*.md,*.txt set ts=4 sts=4 sw=4 expandtab
    autocmd BufEnter,BufRead,BufNewFile,FileType make setlocal noexpandtab
    autocmd FileType python set colorcolumn=79
    autocmd FileType html set ft=htmldjango

    " Save file when vim loses focus
    autocmd FocusLost * :wa

    " Clean up the QuickFix window
    autocmd Filetype qf setl nolist
    autocmd Filetype qf setl nowrap
    " Project Tree
    autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
    autocmd FocusGained * call s:UpdateNERDTree()
    autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
endif

" lightline settings
let g:lightline = {
\ 'active': {
\   'right': [ [ 'lineprogress' ],
\              [ 'percent' ],
\              [ 'filetype' ] ]
\ },
\ 'component': {
\   'lineprogress': "%{line('.') . '/' . line('$') . ':' . col('.')}",
\ },
\ }

" For some reason supertab mappings were backwards. This fixes them
let g:SuperTabMappingForward='<s-tab>'
let g:SuperTabMappingBackward='<tab>'

" Disables automatic quote/parenthesis/bracket/etc closing
"let loaded_delimitMate=1

" ctrlsf.vim settings
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_mapping = {
  \ "next" : "<D-j>",
  \ "prev" : "<D-k>",
\ }
let g:ctrlsf_auto_focus = {
  \ "at": "start"
\ }

" emmet settings
let g:user_emmet_leader_key=',' 

" fzf settings
nmap <leader>p :Files<CR>
let $FZF_DEFAULT_COMMAND='fd --type f'
set rtp+=/usr/local/opt/fzf

" Gundo settings
let g:gundo_preview_bottom=1

" Complete Python syntax highlighting
let python_highlight_all=1

" NERDTree settings
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$', 'node_modules$', '__pycache__']
let NERDTreeChDirMode=2

" NERDCommenter settings
let g:NERDCustomDelimiters={ 'htmldjango': { 'left': '{#','right': '#}', 'leftAlt': '<!--', 'rightAlt': '-->' } }

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Toggle comments
map <D-/> <plug>NERDCommenterToggle
map <leader>- <plug>NERDCommenterToggle

" Use `Q` to repeat macros instead of entering Ex-mode
nmap Q @@
" Fix `vv`
noremap vv V
" Fix `V`
"noremap V <ESC>v$h
" Fix `Y`
nmap Y y$
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Get out of insert mode more easily
inoremap jj <ESC>
inoremap hh <ESC>
" Remap F1 to do what ESC does, and F2 to do what F1 does
inoremap <F1> <ESC>
noremap <F1> <ESC>
inoremap <F2> <F1>
noremap <F2> <F1>
" Search in project
nnoremap <leader>/ :CtrlSF<space>
nnoremap <D-F> :CtrlSF<space>
" Avoid needing to use shift for ex mode
nnoremap ; :
" Run a command line operation
nnoremap <leader>; :silent !
" Make splits take up the same amount of space
nnoremap <leader>= <C-w>=
" Make current split a bit bigger
nnoremap <leader><Up> :vertical resize +15<CR>
" Make current split a bit smaller
nnoremap <leader><Down> :vertical resize -15<CR>
" Turn NERDTree on or off
nnoremap <leader>n :NERDTreeToggle<CR>
" Clear search highlights
nnoremap <leader><space> :noh<CR>
" Quick scratch access
nnoremap <leader><tab> :Sscratch<CR>
" Edit ~/.vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
" Source (reload) ~/.vimrc
nnoremap <leader>rv :source $MYVIMRC<CR>
" Open current working directory in Finder
nnoremap <leader>f :silent !open .<CR>
" Find the current file in the NERDTree
nnoremap <leader>F :NERDTreeFind<CR>
" Reveal current file in Finder
nnoremap <leader>r :silent !open -R %<CR>
" Open SourceTree
nnoremap <leader>g :silent !stree<CR>:redraw!<CR>
" Open Gundo
nnoremap <leader>G :GundoToggle<CR>
" Search/Replace the current file
nnoremap <leader>R :%s//g<left><left>
" Switch tabs to spaces
nnoremap <leader>t :set expandtab<CR>:retab<CR>
" Open new h split and switch to it
nnoremap <leader>h :sp<CR><C-w>j<C-w>=
" Open new v split and switch to it
nnoremap <leader>v :vs<CR><C-w>l<C-w>=
" Strip trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" Make j/k move by display line, rather than by file line
nnoremap j gj
nnoremap k gk

nmap <leader>a= :Tabularize /=<CR>
vmap <leader>a= :Tabularize /=<CR>
nmap <leader>a; :Tabularize /:<CR>
vmap <leader>a; :Tabularize /:<CR>
nmap <leader>a, :Tabularize /,<CR>
vmap <leader>a, :Tabularize /,<CR>
nmap <leader>ai :Tabularize /import<CR>
vmap <leader>ai :Tabularize /import<CR>
nmap <leader>af :Tabularize /from<CR>
vmap <leader>af :Tabularize /from<CR>

" Switch windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

command! -nargs=* Wrap set wrap linebreak nolist


" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function s:CloseIfOnlyNerdTreeLeft()
 if exists("t:NERDTreeBufName")
   if bufwinnr(t:NERDTreeBufName) != -1
     if winnr("$") == 1
       q
     endif
   endif
 endif
endfunction


" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . fnameescape(a:directory)
  endif

  " Allows reading from stdin
  " ex: git diff | mvim -R -
  if strlen(a:directory) == 0
    return
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if exists("a:1")
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif
endfunction


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