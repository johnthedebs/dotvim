filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
" Enable file type detection. Just needed to be off for pathogen
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
set showmode
set ruler
set title
set wildmenu
set wildmode=list:longest
set wildignore+=~*,*.pyc,*.o,*.obj,*.rbc,.git,.svn,.hg,.DS_Store,__pycache__,.sass-cache,node_modules,bower_components,tmp,vendor,__pycache__,dist
set nolist
set listchars=tab:▸\ ,eol:¬,trail:·
set showbreak=↪
set fileformats=unix,dos,mac
set scrolloff=0
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
set statusline=%f\ %m%r\ [%Y]%=%(\ %l,%v\ @\ %p%%\ of\ %L\ %)
set laststatus=2
set t_Co=256
set hidden
set formatprg=par
set viminfo='10,\"100,:20,!,%,n~/.vim/info/viminfo

colorscheme monokai
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
    set guifont=Inconsolata:h15
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
    " Use soft 4-space tabs by default for everything
    "autocmd BufEnter *.py,*.html,*.rb,*.sls,*.js,*.css,*.md,*.txt,*.coffee,*.sass set ts=4 sts=4 sw=4 expandtab
    autocmd BufEnter *.rb,*.js,*.css,*.sass set ts=2 sts=2 sw=2 expandtab
    autocmd BufEnter *.py,*.html,*.md,*.coffee,*.txt set ts=4 sts=4 sw=4 expandtab
    autocmd BufEnter,BufRead,BufNewFile,FileType make setlocal noexpandtab
    autocmd FileType coffee set colorcolumn=79
    autocmd FileType python set colorcolumn=79
    autocmd FileType html set ft=htmldjango

    " Add json syntax highlighting
    autocmd BufNewFile,BufRead *.json set ft=javascript
    " Add hamlc syntax highlighting
    autocmd BufNewFile,BufRead *.hamlc set ft=haml

    " Save file when vim loses focus
    autocmd FocusLost * :wa
    " Remember where you were the last time you edited the file and return to the same position
    autocmd BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
    " Clean up the QuickFix window
    autocmd Filetype qf setl nolist
    autocmd Filetype qf setl nowrap
    " Project Tree
    autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
    autocmd FocusGained * call s:UpdateNERDTree()
    autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
endif


" vim-airline settings
let g:airline_detect_paste=0
let g:airline_section_y=""
let g:airline_section_z="%(%l\ of\ %L\ @\ %p%%,\ col %v%)"
let g:airline_right_sep=""
let g:airline_left_sep=""
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=0

" Ctrl-P settings
let g:ctrlp_switch_buffer = 1
let g:ctrlp_map = '<leader>p'

" DelimitMate settings
let loaded_delimitMate = 1

" Gundo settings
let g:gundo_preview_bottom=1

" Complete Python syntax highlighting
let python_highlight_all=1

" NERDTree settings
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$', 'node_modules$']
let NERDTreeChDirMode=2

" NERDCommenter settings
let g:NERDCustomDelimiters = { 'htmldjango': { 'left': '{#','right': '#}', 'leftAlt': '<!--', 'rightAlt': '-->' } }

" Disable netrw (it interferes with NERDTree when a
" directory argument is passed from the command line)
let loaded_netrw=1
let loaded_netrwPlugin=1

" Easily save a file as root
cmap w!! w !sudo tee % >/dev/null

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Make windows take up the same amount of space
nnoremap <leader>= <C-w>=

" Toggle comments
map <D-/> <plug>NERDCommenterToggle
map <leader>- <plug>NERDCommenterToggle

" Use `Q` to repeat macros instead of entering Ex-mode
nmap Q @@
" Fix `vv`
noremap vv V
" Fix `V`
noremap V <ESC>v$h
" Fix `Y`
nmap Y y$
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Dash integration
nmap <silent> <leader>d <plug>DashGlobalSearch
" Get out of insert mode more easily
inoremap jj <ESC>
inoremap hh <ESC>
" Remap F1 to do what ESC does, and F2 to do what F1 does
inoremap <F1> <ESC>
noremap <F1> <ESC>
inoremap <F2> <F1>
noremap <F2> <F1>
" Search in project: Ack with a literal
nnoremap <leader>/ :Ack! --literal<space>
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
" Open GitX
nnoremap <leader>g :silent ! stree<CR>:redraw!<CR>
" Open Gundo
nnoremap <leader>G :GundoToggle<CR>
" Search/Replace the current file
nnoremap <leader>R :%s//g<left><left>
" Open in Sublime Text
nnoremap <leader>S :silent ! subl .<CR>
" Switch tabs to spaces
nnoremap <leader>t :set expandtab<CR>:retab<CR>
" Reselect pasted text
nnoremap <leader>v V`]
" Open new h split and switch to it
nnoremap <leader>h :sp<CR><C-w>j
" Open new v split and switch to it
nnoremap <leader>w :vs<CR><C-w>l
" Strip trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" Pretty print JSON
nnoremap <leader>ppj :%!python -m json.tool<CR>
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

" Switch windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

command! -nargs=* Wrap set wrap linebreak nolist

call togglebg#map("<F5>")


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

  if exists(":CtrlPClearCache")
      CtrlPClearCache
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


" Utility functions to create file commands
function s:CommandCabbr(abbreviation, expansion)
  execute 'cabbrev ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction

function s:FileCommand(name, ...)
  if exists("a:1")
    let funcname = a:1
  else
    let funcname = a:name
  endif

  execute 'command -nargs=1 -complete=file ' . a:name . ' :call ' . funcname . '(<f-args>)'
endfunction

function s:DefineCommand(name, destination)
  call s:FileCommand(a:destination)
  call s:CommandCabbr(a:name, a:destination)
endfunction


" Public NERDTree-aware versions of builtin functions
function ChangeDirectory(dir, ...)
  execute "cd " . fnameescape(a:dir)
  let stay = exists("a:1") ? a:1 : 1

  NERDTree

  if !stay
    wincmd p
  endif
endfunction

function Touch(file)
  execute "!touch " . shellescape(a:file, 1)
  call s:UpdateNERDTree()
endfunction

function Remove(file)
  let current_path = expand("%")
  let removed_path = fnamemodify(a:file, ":p")

  if (current_path == removed_path) && (getbufvar("%", "&modified"))
    echo "You are trying to remove the file you are editing. Please close the buffer first."
  else
    execute "!rm " . shellescape(a:file, 1)
  endif

  call s:UpdateNERDTree()
endfunction

function Mkdir(file)
  execute "!mkdir " . shellescape(a:file, 1)
  call s:UpdateNERDTree()
endfunction

function Edit(file)
 if exists("b:NERDTreeRoot")
   wincmd p
 endif

 execute "e " . fnameescape(a:file)

ruby << RUBY
 destination = File.expand_path(VIM.evaluate(%{system("dirname " . shellescape(a:file, 1))}))
 pwd         = File.expand_path(Dir.pwd)
 home        = pwd == File.expand_path("~")

 if home || Regexp.new("^" + Regexp.escape(pwd)) !~ destination
   VIM.command(%{call ChangeDirectory(fnamemodify(a:file, ":h"), 0)})
 end
RUBY
endfunction

" Define the NERDTree-aware aliases
call s:DefineCommand("cd", "ChangeDirectory")
call s:DefineCommand("touch", "Touch")
call s:DefineCommand("rm", "Remove")
call s:DefineCommand("e", "Edit")
call s:DefineCommand("mkdir", "Mkdir")