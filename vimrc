call plug#begin("~/.vim/plugged")
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'dyng/ctrlsf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'gruvbox-community/gruvbox'
Plug 'hail2u/vim-css3-syntax'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'lfv89/vim-interestingwords'
Plug 'markonm/traces.vim'
Plug 'mattn/emmet-vim'
Plug 'mattn/gist-vim'
Plug 'neoclide/coc.nvim'
Plug 'psliwka/vim-smoothie'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'simnalamburt/vim-mundo'
Plug 'sirver/UltiSnips', has('gui_running') ? {} : { 'on': [] }
Plug 'styled-components/vim-styled-components'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/taglist.vim'
Plug '~/.vim/bundle/django'
call plug#end()

runtime macros/matchit.vim

filetype plugin indent on

set modelines=0
set encoding=utf-8
set autoindent
set ignorecase
set smartcase
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set showmatch
set noshowmode
set title
set wildmenu
set wildmode=list:longest
set wildignore+=.git,.svn,.hg
set wildignore+=~*,*.o,*.obj,.DS_Store
set wildignore+=.pyc,__pycache__
set wildignore+=node_modules
set wildignore+=tmp,vendor,dist,dist-dev
set wildignore+=.tfstate,*.tfstate.backup
set wildignore+=.sassc,.scssc,.sass-cache
set wildignore+=.meteor
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
set linebreak
set backspace=indent,eol,start
set cursorline
set textwidth=130
set formatoptions=qrn1
set visualbell
set binary
set noeol
set clipboard=unnamed
set nofoldenable
set autoread
set laststatus=2
set t_Co=256
set hidden
set formatprg=par
set viminfo='10,\"100,:20,!,%,n~/.vim/info/viminfo
set mouse=a
set backupdir=~/.vim/backup
set directory=~/.vim/backup

if has("persistent_undo")
    set undofile
    set undodir=~/.vim/undo
endif

syntax enable
nohlsearch

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'


if has("gui_running")
    cabbrev h tab help
    cabbrev help tab help

    set columns=110
    set lines=999
    set fuoptions=maxhorz,maxvert " Proper fullscreen mode in MacVim
    set guioptions-=T " Hide menu icons by default in MacVim
    set guioptions-=L " Disable left scroll bar
    set guioptions-=r " Disable right scroll bar
    set guifont=Inconsolata:h16
    highlight SpellBad term=underline gui=undercurl guisp=Orange

    " Switch tabs
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

augroup Misc
    autocmd!
    autocmd FileType python set colorcolumn=80
    autocmd FileType html set ft=htmldjango
    " Keep search matches in the middle of the window. For some reason,
    " these re-mappings don't work if set in the standard way
    autocmd VimEnter * nnoremap n nzz
    autocmd VimEnter * nnoremap N Nzz
    " Save file when vim loses focus
    autocmd FocusLost * :wa
    " Equalize splits on resize
    autocmd VimResized * exe "normal! \<C-w>="
    " Project Tree behavior
    autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
    autocmd FocusGained * call s:UpdateNERDTree()
    autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
    " Return to last line on each opened file
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   execute 'normal! g`"' |
        \ endif
augroup END


" Set the leader to something easier than \
let mapleader=" "

" ctrlsf.vim settings
let g:ctrlsf_default_view_mode = 'compact'
let g:ctrlsf_auto_close = {
\   "normal" : 0,
\   "compact": 0,
\ }
let g:ctrlsf_mapping = {
\   "next"   : "n",
\   "prev"   : "N",
\   "split"  : "",
\   "vsplit" : "<C-v>",
\ }
let g:ctrlsf_auto_focus = {
\   "at": "start"
\ }

" emmet settings
let g:user_emmet_leader_key=','

" fzf settings
let $FZF_DEFAULT_COMMAND='fd --type f'
set rtp+=/usr/local/opt/fzf

" gruvbox settings
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
let g:gruvbox_vert_split='bg3'
colorscheme gruvbox
let $BAT_THEME="gruvbox"

" indentLine settings
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_enabled=0

" lightline settings
let g:lightline = {
\ 'active': {
\   'left': [ [ 'mode' ],
\             [ 'readonly', 'relativepath', 'modified' ],
\   ],
\   'right': [ [ 'lineprogress' ],
\              [ 'percent' ],
\              [ 'filetype' ],
\   ],
\ },
\ 'inactive': {
\   'left': [ [ 'relativepath' ]
\    ],
\   'right': [ [ 'lineinfo' ],
\            [ 'percent' ]
\   ],
\ },
\ 'component': {
\   'lineprogress': "%{line('.') . '/' . line('$') . ':' . col('.')}",
\   'percent': '%p%%',
\ },
\ }

" Python syntax settings
let python_highlight_all=1

" NERDCommenter settings
let g:NERDCustomDelimiters={ 'htmldjango': { 'left': '{#','right': '#}', 'leftAlt': '<!--', 'rightAlt': '-->' } }

" NERDTree settings
let NERDTreeAutoDeleteBuffer=1
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$', 'node_modules$', '__pycache__']

" supertab settings
" For some reason supertab mappings were backwards. This fixes them
let g:SuperTabMappingForward='<s-tab>'
let g:SuperTabMappingBackward='<tab>'

" taglist settings
let Tlist_Compact_Format=1
let Tlist_Enable_Fold_Column=1
let Tlist_Exit_OnlyWindow=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Show_One_File=1
let Tlist_Use_Right_Window=1
let Tlist_WinWidth=40

" UltiSnips settings
let g:UltiSnipsExpandTrigger="<C-j>"


" Toggle comments
map <D-/> <plug>NERDCommenterToggle
map <leader>- <plug>NERDCommenterToggle
" Make jumping to matches easier
map <tab> %
" Use `Q` to repeat macros instead of entering Ex-mode
nmap Q @@
" Fix `vv`
noremap vv V
" Fix `V`
noremap V <ESC>v$h
" Fix `Y`
nmap Y y$
" Shortcut to rapidly toggle line numbers and white space
nmap <leader>l :setlocal number!<CR>:set list!<CR>
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
vnoremap ; :
" Run a command line operation
nnoremap <leader>; :silent !
" fzf bindings
nnoremap <leader>C :Commits<CR>
nnoremap <leader>H :Helptags<CR>
nnoremap <leader>S :Snippets<CR>
nnoremap <leader>T :BTags<CR>
nnoremap <leader>bc :BCommits<CR>
" Toggle taglist
nnoremap <leader>t :TlistToggle<CR>
" Recompile ctags
nnoremap <silent> <leader>c :silent !ctags<CR>
" Make splits take up the same amount of space
nnoremap <leader>= <C-w>=
" Make current split a bit bigger
nnoremap <leader><Up> :vertical resize +15<CR>
" Make current split a bit smaller
nnoremap <leader><Down> :vertical resize -15<CR>
" Turn NERDTree on or off
nnoremap <silent> <leader>n :NERDTreeToggle<CR>:NERDTreeRefreshRoot<CR>
" Clear search highlights
nnoremap <leader><space> :nohlsearch<CR>
" Quick scratch access
nnoremap <leader><tab> :Sscratch<CR>
" Edit UltiSnips
nnoremap <leader>es :UltiSnipsEdit<CR>
" Reload snippets
nnoremap <leader>rs :call UltiSnips#RefreshSnippets()<CR>
" Edit ~/.vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<CR>
" Source (reload) ~/.vimrc
nnoremap <leader>rv :source $MYVIMRC<CR>
" Find the current file in NERDTree
nnoremap <leader>f :NERDTreeFind<CR>
" Open current working directory in Finder
nnoremap <leader>F :silent !open .<CR>
" Open SourceTree
nnoremap <leader>g :silent !stree<CR>:redraw!<CR>
" Toggle line indent markers
nnoremap <leader>i :IndentLinesToggle<CR>
" Open Mundo
nnoremap <leader>m :MundoToggle<CR>
" Open fzf for files
nnoremap <leader>p :Files<CR>
" Search/Replace the current file
nnoremap <leader>r :%s//<left>
" Reveal current file in Finder
nnoremap <leader>R :silent !open -R %<CR>
" Switch tabs to spaces
nnoremap <leader>T :set expandtab<CR>:retab<CR>
" Open new h split and switch to it
nnoremap <leader>h :sp<CR><C-w>j
" Open new v split and switch to it
nnoremap <leader>v :vs<CR><C-w>l
" Strip trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" Sort lines
nnoremap <leader>s vip:!sort<cr>
vnoremap <leader>s :!sort<cr>
" Make j/k move by display line, rather than by file line
nnoremap j gj
nnoremap k gk
" Keep cursor in the middle of the window when jumping around
nnoremap <c-o> <c-o>zz
nnoremap <c-i> <c-i>zz
" Switch windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" Move windows (alt + hjkl)
noremap ˙ <C-w>H
noremap ∆ <C-w>J
noremap ˚ <C-w>K
noremap ¬ <C-w>L
" Align on special characers
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


" Run a cli operation and put output in a new split
nnoremap <leader>! :Shell<space>

command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
function! s:ExecuteInShell(command) " {{{
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction " }}}


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


" NERDTree on-start behavior
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