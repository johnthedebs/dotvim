call plug#begin("~/.vim/plugged")
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'antoinemadec/coc-fzf'
Plug 'dyng/ctrlsf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'gruvbox-community/gruvbox'
Plug 'hail2u/vim-css3-syntax'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'
Plug 'lfv89/vim-interestingwords'
Plug 'liuchengxu/vim-which-key'
Plug 'markonm/traces.vim'
Plug 'mattn/emmet-vim'
Plug 'mattn/gist-vim'
Plug 'mg979/vim-visual-multi'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'psliwka/vim-smoothie'
Plug 'rhysd/clever-f.vim'
Plug 'sheerun/vim-polyglot'
Plug 'simnalamburt/vim-mundo'
Plug 'sirver/UltiSnips', has('gui_running') ? {} : { 'on': [] }
Plug 'styled-components/vim-styled-components', { 'branch': 'develop' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'voldikss/vim-floaterm'
Plug 'wellle/targets.vim'
Plug '~/.vim/bundle/django'
call plug#end()

runtime macros/matchit.vim

filetype plugin indent on
syntax enable

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
set listchars=tab:▸\ ,eol:¬,trail:·
set showbreak=↪
set fileformats=unix,dos,mac
set scrolloff=1
set sidescrolloff=3
set sidescroll=1
set history=300
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
set mouse=a
set viminfo='10,\"100,:50,n~/.vim/persist/viminfo
set backupdir=~/.vim/persist/backup//
set directory=~/.vim/persist/backup//
set termguicolors
set background=dark


if has("persistent_undo")
    set undofile
    set undodir=~/.vim/persist/undo
endif

if has("gui_running")
    cabbrev h tab help
    cabbrev help tab help

    set columns=110
    set lines=999
    set fuoptions=maxhorz,maxvert " Proper fullscreen mode in MacVim
    set guioptions-=T " Hide menu icons by default in MacVim
    set guioptions-=L " Disable left scroll bar
    set guioptions-=r " Disable right scroll bar
    "set guifont=Inconsolata:h16
    set guifont=JetBrains\ Mono:h14
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
    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType html set ft=htmldjango
    autocmd FileType floaterm set winfixheight
    " Keep search matches in the middle of the window. For some reason
    " (NOTE: conflicting with n/N mappings from interestingwords probably)
    " these re-mappings don't work if set in the standard way
    autocmd VimEnter * nnoremap n nzz
    autocmd VimEnter * nnoremap N Nzz
    " Reload snippets after editing snippets
    autocmd BufWritePost snippets call UltiSnips#RefreshSnippets()
    " Save file when vim loses focus
    autocmd FocusLost * silent! :wa
    " Equalize splits on resize
    autocmd VimResized * wincmd =
    " Return to last line on each opened file
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   execute 'normal! g`"' |
        \ endif
    " Refresh NERDTree when window is focused
    autocmd FocusGained * silent! NERDTreeRefreshRoot
    autocmd BufEnter * if (winnr("$") == 1 && &filetype == "ctrlsf") | q | endif
    " Close NERDTree if it's the only pane left
    autocmd WinEnter * if exists("t:NERDTreeBufName") |
        \ if bufwinnr(t:NERDTreeBufName) != -1 | if winnr("$") == 1 |
        \ q | endif | endif | endif
    " Start NERDTree in directory when Vim starts with a directory argument
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
        \ execute 'cd '.argv()[0] | endif
augroup END


" Set the leader to something easier than \
let mapleader=" "

" coc settings
let g:coc_global_extensions = [
\   'coc-css',
\   'coc-emmet',
\   'coc-html',
\   'coc-pyright',
\   'coc-snippets',
\   'coc-styled-components',
\   'coc-svg',
\   'coc-tailwindcss',
\   'coc-tsserver',
\   'coc-yaml',
\   'coc-phpls',
\ ]
"\   'coc-eslint',
"https://github.com/rodrigore/coc-tailwind-intellisense

" ctrlsf.vim settings
let $RIPGREP_CONFIG_PATH=$HOME.'/.vim/ripgreprc'
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

" delimiteMate settings
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
let delimitMate_expand_inside_quotes = 1

" emmet settings
let g:user_emmet_leader_key=','

" floaterm settings
let g:floaterm_autoclose=1
let g:floaterm_keymap_toggle='<C-t>t'
let g:floaterm_keymap_new='<C-t>n'
let g:floaterm_keymap_kill='<C-t>k'
let g:floaterm_height=15
let g:floaterm_wintype='normal'

" fzf settings
set rtp+=/usr/local/opt/fzf
let $FZF_DEFAULT_COMMAND='fd --type f'

" gruvbox settings
let $BAT_THEME="gruvbox-dark"
" Need to be before gruvbox is loaded
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
let g:gruvbox_vert_split='bg3'
let g:gruvbox_hls_cursor='aqua'
colorscheme gruvbox
" Needs to be after gruvbox is loaded
let g:fzf_colors = { 
\   'fg':      ['fg', 'Normal'],
\   'bg':      ['bg', 'Normal'],
\   'hl':      ['fg', 'Comment'],
\   'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\   'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\   'hl+':     ['fg', 'Statement'],
\   'info':    ['fg', 'PreProc'],
\   'border':  ['fg', 'Identifier'],
\   'prompt':  ['fg', 'Conditional'],
\   'pointer': ['fg', 'Exception'],
\   'marker':  ['fg', 'Keyword'],
\   'spinner': ['fg', 'Label'],
\   'header':  ['fg', 'Comment']
\ }

nnoremap * :call gruvbox#hls_show()<CR>*
nnoremap / :call gruvbox#hls_show()<CR>/

" indentLine settings
let g:indentLine_char_list = ['|', '¦']
let g:indentLine_enabled=0

" interestingwords settings
let g:interestingWordsGUIColors = ['#83a598', '#d3869b', '#8ec07c', '#fabd2f', '#fb4934', '#b8bb26', '#ebdbb2', '#fe8019']
let g:interestingWordsTermColors = ['109', '175', '108', '214', '167', '142', '223', '208']

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

" NERDCommenter settings
let g:NERDCreateDefaultMappings = 0
let g:NERDCustomDelimiters={ 'htmldjango': { 'left': '{#','right': '#}', 'leftAlt': '<!--', 'rightAlt': '-->' } }

" NERDTree settings
let NERDTreeAutoDeleteBuffer=1
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$', 'node_modules$', '__pycache__', '.DS_Store', 'plugged']

" python syntax settings
let python_highlight_all=1

" sneak.vim settings
let g:sneak#label = 1

" supertab settings
" For some reason supertab mappings were backwards. This fixes them
let g:SuperTabMappingForward='<s-tab>'
let g:SuperTabMappingBackward='<tab>'

" UltiSnips settings
let g:UltiSnipsExpandTrigger='<C-j>'
let g:UltiSnipsEditSplit='vertical'

" which-key settings
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
set timeoutlen=500

let g:which_key_map = {
\ 'name'    : 'root',
\ '<space>' : 'clear search highlight',
\ '/'       : 'search project',
\ '?'       : 'search/replace in buffer',
\ '-'       : 'toggle commented',
\ '='       : 'equalize split sizes',
\ ';'       : 'run cli command',
\ '!'       : 'run cli command, output in split',
\ '<Up>'    : 'increase split size',
\ '<Down>'  : 'decrease split size',
\ 'B'       : 'fzf Buffers',
\ 'C'       : 'fzf Commits',
\ 'f'       : 'reveal current File in nerdtree',
\ 'F'       : 'open cwd in Finder',
\ 'g'       : 'open Git gui',
\ 'I'       : 'open icons directories',
\ 'k'       : 'mark interesting word',
\ 'K'       : 'clear interesting words',
\ 'l'       : 'toggle Line #s and whitespace',
\ 'm'       : 'toggle Mundo',
\ 'n'       : 'toggle Nerdtree',
\ 'p'       : 'fzf Project files',
\ 'P'       : 'fzf Project code',
\ 'h'       : 'Horizontal split',
\ 'H'       : 'fzf Help tags',
\ 'R'       : 'Reveal current file in finder',
\ 'S'       : 'fzf Snippets',
\ 'T'       : 'fzf Tags in buffer',
\ 'v'       : 'Vertical split',
\ 'W'       : 'strip trailing Whitespace',
\ 's'       : 'Sort lines',
\ }

let g:which_key_map['a'] = {
\ 'name' : '+align',
\ '#'    : 'align #',
\ ','    : 'align ,',
\ ';'    : 'align first :',
\ '='    : 'align first =',
\ 'f'    : 'align "from"',
\ 'i'    : 'align "import"',
\ }

let g:which_key_map['c'] = {
\ 'name' : '+code-actions',
\ 'a'    : 'apply codeAction to selected region',
\ 'c'    : 'coc commands',
\ 'd'    : 'coc diagnostics',
\ 'f'    : 'format selected code',
\ 'h'    : 'reapply code highlighting',
\ 'l'    : 'coc list',
\ 'o'    : 'coc outline',
\ 't'    : 'recompile ctags',
\ }

let g:which_key_map['e'] = {
\ 'name' : '+edit',
\ 's'    : 'edit snippets',
\ 'v'    : 'edit vimrc',
\ }

let g:which_key_map['r'] = {
\ 'name' : '+rename/retab/reload',
\ 'n'    : 'rename symbol',
\ 't'    : 'retab file w/ spaces',
\ 'v'    : 'reload vimrc',
\ }


"let g:which_key_map['w'] = {
      "\ 'name' : '+windows' ,
      "\ 'w' : ['<C-W>w'     , 'other-window']          ,
      "\ 'd' : ['<C-W>c'     , 'delete-window']         ,
      "\ '-' : ['<C-W>s'     , 'split-window-below']    ,
      "\ '|' : ['<C-W>v'     , 'split-window-right']    ,
      "\ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      "\ 'h' : ['<C-W>h'     , 'window-left']           ,
      "\ 'j' : ['<C-W>j'     , 'window-below']          ,
      "\ 'l' : ['<C-W>l'     , 'window-right']          ,
      "\ 'k' : ['<C-W>k'     , 'window-up']             ,
      "\ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      "\ 'J' : [':resize +5'  , 'expand-window-below']   ,
      "\ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      "\ 'K' : [':resize -5'  , 'expand-window-up']      ,
      "\ '=' : ['<C-W>='     , 'balance-window']        ,
      "\ 's' : ['<C-W>s'     , 'split-window-below']    ,
      "\ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      "\ '?' : ['Windows'    , 'fzf-window']            ,
      "\ }

"let g:which_key_map =  {}
"let g:which_key_map['name'] = 'space-vim root'

"for s:i in range(1, 9)
  "let g:which_key_map[s:i] = 'window-'.s:i
"endfor
"unlet s:i

"let g:which_key_map['?'] = [ 'Maps', 'show-keybindings' ]
"let g:which_key_map[';'] = [ '<Plug>NERDCommenterToggle','commenter' ]
"let g:which_key_map[' '] = {
      "\ 'name': '+tab' ,
      "\ '1' : 'tab-1'  ,
      "\ '2' : 'tab-2'  ,
      "\ '3' : 'tab-3'  ,
      "\ '4' : 'tab-4'  ,
      "\ '5' : 'tab-5'  ,
      "\ '6' : 'tab-6'  ,
      "\ '7' : 'tab-7'  ,
      "\ '8' : 'tab-8'  ,
      "\ '9' : 'tab-9'  ,
      "\ 'c' : ['tabclose', 'close-current-tab'],
      "\ }

"let g:which_key_map['a'] = {
      "\ 'name' : '+align',
      "\ }

"let g:which_key_map['b'] = {
      "\ 'name' : '+buffer'       ,
      "\ '1' :  'buffer-1'        ,
      "\ '2' :  'buffer-2'        ,
      "\ '3' :  'buffer-3'        ,
      "\ '4' :  'buffer-4'        ,
      "\ '5' :  'buffer-5'        ,
      "\ '6' :  'buffer-6'        ,
      "\ '7' :  'buffer-7'        ,
      "\ '8' :  'buffer-8'        ,
      "\ '9' :  'buffer-9'        ,
      "\ 'd' :  'delete-buffer'   ,
      "\ 'f' :  'first-buffer'    ,
      "\ 'h' :  'home-buffer'     ,
      "\ 'k' :  'kill-buffer'     ,
      "\ 'l' :  'last-buffer'     ,
      "\ 'n' :  'next-buffer'     ,
      "\ 'p' :  'previous-buffer' ,
      "\ 'b' :  'fzf-buffer'      ,
      "\ '?' :  'fzf-buffer'      ,
      "\ }

"let g:which_key_map['c'] = {
      "\ 'name' : '+cscope'                            ,
      "\ 's' : ['spacevim#vim#cscope#Find("symbol")'   , 'find-this-symbol']                       ,
      "\ 'g' : ['spacevim#vim#cscope#Find("global")'   , 'global-definition']                      ,
      "\ 'c' : ['spacevim#vim#cscope#Find("calls")'    , 'find-functions-calling-this-function']   ,
      "\ 't' : ['spacevim#vim#cscope#Find("text")'     , 'text']                                   ,
      "\ 'e' : ['spacevim#vim#cscope#Find("egrep")'    , 'egrep']                                  ,
      "\ 'f' : ['spacevim#vim#cscope#Find("file")'     , 'find-this-file']                         ,
      "\ 'i' : ['spacevim#vim#cscope#Find("includes")' , 'find-files-#include-this-file']          ,
      "\ 'd' : ['spacevim#vim#cscope#Find("called")'   , 'find-functions-called-by-this-function'] ,
      "\ }

"let g:which_key_map['d'] = 'scroll-down'

"let g:which_key_map['e'] = {
      "\ 'name' : '+errors'     ,
      "\ 'n' : 'next-error'     ,
      "\ 'p' : 'previous-error' ,
      "\ }

"let g:which_key_map['f'] = {
      "\ 'name' : '+find/files/fold'             ,
      "\ '0' : '0-fold-level'                    ,
      "\ '1' : '1-fold-level'                    ,
      "\ '2' : '2-fold-level'                    ,
      "\ '3' : '3-fold-level'                    ,
      "\ '4' : '4-fold-level'                    ,
      "\ '5' : '5-fold-level'                    ,
      "\ '6' : '6-fold-level'                    ,
      "\ '7' : '7-fold-level'                    ,
      "\ '8' : '8-fold-level'                    ,
      "\ '9' : '9-fold-level'                    ,
      "\ 'd' : 'find-current-buffer-in-NERDTree' ,
      "\ 'f' : 'files-in-home-direcotry'         ,
      "\ 's' : 'save-file'                       ,
      "\ 't' : 'toggle-NERDTree'                 ,
      "\ '?' : 'files-in-current-direcotry'      ,
      "\ 'R' : 'reload-vimrc'                    ,
      "\ 'b' : ['spacevim#map#manager#BLines()'  , 'fzf-find-current-buffer'] ,
      "\ }

"let g:which_key_map['g'] = {
      "\ 'name' : '+git/version-control' ,
      "\ 'b' : ['Gblame'                 , 'fugitive-blame']             ,
      "\ 'c' : ['BCommits'               , 'commits-for-current-buffer'] ,
      "\ 'C' : ['Gcommit'                , 'fugitive-commit']            ,
      "\ 'd' : ['Gdiff'                  , 'fugitive-diff']              ,
      "\ 'e' : ['Gedit'                  , 'fugitive-edit']              ,
      "\ 'l' : ['Glog'                   , 'fugitive-log']               ,
      "\ 'r' : ['Gread'                  , 'fugitive-read']              ,
      "\ 's' : ['Gstatus'                , 'fugitive-status']            ,
      "\ 'w' : ['Gwrite'                 , 'fugitive-write']             ,
      "\ 'p' : ['Git push'               , 'fugitive-push']              ,
      "\ 'y' : ['Goyo'                   , 'goyo-mode']                  ,
      "\ }

"let g:which_key_map['h'] = {
      "\ 'name' : '+help',
      "\ }

"let g:which_key_map['j'] = {
      "\ 'name' : '+jump/json'                   ,
      "\ 'j' : 'easymotion-goto-char'       ,
      "\ 'J' : 'easymotion-goto-char-2'     ,
      "\ 'l' : 'jump-linewise'              ,
      "\ 'w' : 'jump-to-word-bidirectional' ,
      "\ 'f' : 'jump-forward-wordwise'      ,
      "\ 'b' : 'jump-backword-wordwise'     ,
      "\ 'F' : ['execute line(".")."!python -m json.tool"', 'format-current-raw-oneline-json'],
      "\ }

"let g:which_key_map['l'] = {
      "\ 'name' : '+lsp'                               ,
      "\ 'a' : ['spacevim#lang#util#CodeAction()'      , 'code-action']      ,
      "\ 'f' : ['spacevim#lang#util#Format()'          , 'formatting']       ,
      "\ 'h' : ['spacevim#lang#util#Hover()'           , 'hover']            ,
      "\ 'r' : ['spacevim#lang#util#FindReferences()'  , 'references']       ,
      "\ 'R' : ['spacevim#lang#util#Rename()'          , 'rename']           ,
      "\ 's' : ['spacevim#lang#util#DocumentSymbol()'  , 'document-symbol']  ,
      "\ 'S' : ['spacevim#lang#util#WorkspaceSymbol()' , 'workspace-symbol'] ,
      "\ 'g' : {
        "\ 'name': '+goto'                                       ,
        "\ 'd' : ['spacevim#lang#util#Definition()'     , 'definition']      ,
        "\ 't' : ['spacevim#lang#util#TypeDefinition()' , 'type-definition'] ,
        "\ 'i' : ['spacevim#lang#util#Implementation()' , 'implementation']  ,
        "\ }                                                     ,
      "\ }

"let g:which_key_map['p'] = {
      "\ 'name' : '+projects'                      ,
      "\ 'f' : ['spacevim#map#manager#FindFiles()' , 'find-file-in-project']         ,
      "\ 's' : ['spacevim#map#manager#Rg()'        , 'search-in-project']            ,
      "\ 'a' : ['Rag'                              , 'search-in-project-via-ag']     ,
      "\ 'r' : ['spacevim#map#manager#Rg()'        , 'search-in-project-via-rg']     ,
      "\ 'w' : ['spacevim#map#manager#RgCword()'   , 'find-cword-in-project-via-rg'] ,
      "\ 'W' : ['spacevim#plug#fzf#SearchCword()'  , 'find-cword-in-project']        ,
      "\ }

"let g:which_key_map['r'] = {
      "\ 'c' : 'replace-current-word-in-current-file',
      "\ }

"let g:which_key_map['q'] = [ 'q', 'quit' ]

"let g:which_key_map['Q'] = [ 'qa!', 'quit-without-saving' ]

"let g:which_key_map['s'] = {
      "\ 'name' : '+search/show'                        ,
      "\ 'c' : 'search-clear-highlight'                 ,
      "\ 'h' : ['spacevim#util#SyntaxHiGroup()'         , 'show-highlight-group']              ,
      "\ 'b' : ['spacevim#map#manager#BLines()'         , 'search-in-buffer']                  ,
      "\ 'B' : ['spacevim#map#manager#BufCword()'       , 'search-cword-in-buffer']            ,
      "\ 'r' : ['spacevim#map#manager#SearchRecently()' , 'search-recently-buffers-and-files'] ,
      "\ }

"let g:which_key_map['t'] = {
      "\ 'name' : '+toggle/tag'                      ,
      "\ 'g' : ['spacevim#plug#toggle#Git()'         , 'git-status-indicator']   ,
      "\ 'i' : ['IndentGuidesToggle'                 , 'indent-guide']           ,
      "\ 'p' : ['setlocal paste!'                    , 'paste-mode']             ,
      "\ 's' : ['SyntasticToggleMode'                , 'syntastic']              ,
      "\ 'b' : ['spacevim#map#manager#BufTags()'     , 'tags-in-current-buffer'] ,
      "\ 'T' : ['TagbarToggle'                       , 'tagbar']                 ,
      "\ 'c' : ['spacevim#vim#toggle#CursorColumn()' , 'cursor-column']          ,
      "\ 'C' : ['spacevim#vim#toggle#ColorColumn()'  , 'color-column']           ,
      "\ }

"let g:which_key_map['u'] = 'scroll-up'

"let g:which_key_map['w'] = {
      "\ 'name' : '+windows'                       ,
      "\ 'w' :  'other-window'                     ,
      "\ 'd' :  'delete-window'                    ,
      "\ '-' :  'split-window-below'               ,
      "\ '|' :  'split-window-right'               ,
      "\ '2' :  'layout-double-columns'            ,
      "\ 'o' :  ['only', 'close-all-windows-except-current'] ,
      "\ 'h' :  'window-left'                      ,
      "\ 'j' :  'window-below'                     ,
      "\ 'l' :  'window-right'                     ,
      "\ 'k' :  'window-up'                        ,
      "\ 'H' :  'expand-window-left'               ,
      "\ 'J' :  'expand-window-below'              ,
      "\ 'L' :  'expand-window-right'              ,
      "\ 'K' :  'expand-window-up'                 ,
      "\ '=' :  'balance-window'                   ,
      "\ 's' :  'split-window-below'               ,
      "\ 'v' :  'split-window-below'               ,
      "\ '?' :  'fzf-window'                       ,
      "\ }

"let g:which_key_map['x'] = {
      "\ 'name' : '+text'           ,
      "\ 'a' : ['<Plug>(EasyAlign)' , 'easy-align']                 ,
      "\ 'd' : ['StripWhitespace'   , 'delete-trailing-whitespace'] ,
      "\ }

call which_key#register('<Space>', "g:which_key_map")

" terminal color settings
let g:terminal_ansi_colors = repeat([0], 16)
let g:terminal_ansi_colors[0] = "#2e2e2e" " black
let g:terminal_ansi_colors[8] = "#555555" " black bright
let g:terminal_ansi_colors[1] = "#f36559" " red
let g:terminal_ansi_colors[9] = "#f36559" " red bright
let g:terminal_ansi_colors[2] = "#90c364" " green
let g:terminal_ansi_colors[10] = "#a2bb64" " green bright
let g:terminal_ansi_colors[3] = "#f9ca60" " yellow
let g:terminal_ansi_colors[11] = "#f9ca60" " yellow bright
let g:terminal_ansi_colors[4] = "#2a93cb" " blue
let g:terminal_ansi_colors[12] = "#2a93cb" " blue bright
let g:terminal_ansi_colors[5] = "#ab7aef" " magenta
let g:terminal_ansi_colors[13] = "#ab7aef" " magenta bright
let g:terminal_ansi_colors[6] = "#54dbed" " cyan
let g:terminal_ansi_colors[14] = "#54dbed" " cyan bright
let g:terminal_ansi_colors[7] = "#feffff" " white
let g:terminal_ansi_colors[15] = "#feffff" " white bright
augroup TermColors
    autocmd!
    highlight NormalNC guifg=#FFFBF6 guibg=#252731 ctermfg=white ctermbg=black
    autocmd FileType floaterm set wincolor=NormalNC
augroup END


command! -bang -nargs=? -complete=dir Search
    \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>),
    \ <bang>0,
    \ fzf#vim#with_preview({'options': ['--preview-window=down,50%', '--layout=reverse', '--info=inline']}),
    \ <bang>0)


" Toggle comments
map <D-/> <plug>NERDCommenterToggle
map <leader>- <plug>NERDCommenterToggle
" Use `Q` to repeat macros instead of entering Ex-mode
nmap Q @q
" Fix `vv`
noremap vv V
" Fix `V`
noremap V <ESC>v$h
" Fix `Y`
nmap Y y$
" Shortcut to rapidly toggle line numbers and white space
nmap <silent> <leader>l :setlocal number!<CR>:setlocal list!<CR>:setlocal cursorcolumn!<CR>:IndentLinesToggle<CR>
" Remap F1 to do what ESC does, and F2 to do what F1 does
inoremap <F1> <ESC>
noremap <F1> <ESC>
inoremap <F2> <F1>
noremap <F2> <F1>
" Normal mode indent with one keypress
nmap > >>
nmap < <<
" Move visual blocks up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" Search in project
nnoremap <leader><leader>/ :CtrlSF<space>""<left>
vnoremap <leader><leader>/ <ESC>:CtrlSF<space>""<left>
nnoremap <leader>/ :Search<space>
vnoremap <leader>/ :Search<space>
" Avoid needing to use shift for ex mode
nnoremap ; :
vnoremap ; :
" Select text that was just pasted
nnoremap gp `[v`]
" Run a command line operation
nnoremap <leader>; :silent !
" Search/Replace the current file
nnoremap <leader>? :%s//<left>
" fzf bindings
nnoremap <leader>B :Buffers<CR>
nnoremap <leader>C :Commits<CR>
nnoremap <leader>H :Helptags<CR>
nnoremap <leader>S :Snippets<CR>
nnoremap <leader>T :BTags<CR>
nnoremap <leader>bc :BCommits<CR>
" Recompile ctags
nnoremap <leader>ct :silent !ctags<CR>
" Re-apply syntax highlighting
nnoremap <leader>ch <ESC>:syntax sync fromstart<CR>
" Change to Molokai colorscheme
nnoremap <leader>cm :colorscheme molokai<CR>
" Change to gruvbox colorscheme
nnoremap <leader>cg :colorscheme gruvbox<CR>
" Make splits take up the same amount of space
nnoremap <leader>= <C-w>=
" Make current split a bit bigger
nnoremap <leader><Up> :vertical resize +15<CR>
" Make current split a bit smaller
nnoremap <leader><Down> :vertical resize -15<CR>
" Turn NERDTree on or off
nnoremap <silent> <leader>n :NERDTreeToggle<CR>:silent! NERDTreeRefreshRoot<CR>
" Clear search highlights
nnoremap <leader><space> :call gruvbox#hls_hide()<CR>:nohlsearch<CR>
" Quick scratch access
nnoremap <leader><tab> :Sscratch<CR>
" Edit UltiSnips
nnoremap <leader>es :UltiSnipsEdit<CR>
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
" Open project icons and fontawesome SVG directory
nnoremap <leader>I :silent !open ./app/public/icons<CR>:silent !open '/Users/johndebs/Documents/Design Stuff/fontawesome-free-5.13.0-web/svgs/'<CR>
" Open Mundo
nnoremap <leader>m :MundoToggle<CR>
" Open fzf for files
nnoremap <leader>p :Files<CR>
" Open fzf for lines of code
nnoremap <leader>P :Rg<CR>
" Reveal current file in Finder
nnoremap <leader>R :silent !open -R %<CR>
" Switch tabs to spaces
nnoremap <leader>rt :set expandtab<CR>:retab<CR>
" Reformat current line as json
nnoremap <leader>j :.!python -m json.tool<CR>
" Reformat selected text as json
vnoremap <leader>j :'<,'>!python -m json.tool<CR>
" Open new h split and switch to it
nnoremap <leader>h :sp<CR><C-w>j
" Open new v split and switch to it
nnoremap <leader>v :vs<CR><C-w>l
" Strip trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" Sort lines
nnoremap <leader>s vip:!sort<cr>
vnoremap <leader>s :!sort<cr>
" Make j/k/0/$ move by display line, rather than by file line
nnoremap j gj
nnoremap k gk
"nnoremap 0 g0
"nnoremap $ g$
" Keep cursor in the middle of the window when jumping around
nnoremap <c-o> <c-o>zz
nnoremap <c-i> <c-i>zz
" Switch windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-b> <C-\><C-n>
nnoremap <C-t><C-t> <C-w>:FloatermToggle<CR>
tnoremap <C-t><C-t> <C-w>:FloatermToggle<CR>
tnoremap <C-l> <C-w>:FloatermNext<CR>
tnoremap <C-h> <C-w>:FloatermPrev<CR>
tnoremap <D-r> clear<CR>
tnoremap <D-w> <C-w>:FloatermKill<CR>

" Move windows (alt + hjkl)
noremap ˙ <C-w>H
noremap ∆ <C-w>J
noremap ˚ <C-w>K
noremap ¬ <C-w>L
" Align on special characers (only first occurrence for '=' and ':')
nmap <leader>a= :Tabularize /^[^=]*\zs=/l1l1<CR>
vmap <leader>a= :Tabularize /^[^=]*\zs=/l1l1<CR>
nmap <leader>a; :Tabularize /^[^:]*\zs:/l1l1<CR>
vmap <leader>a; :Tabularize /^[^:]*\zs:/l1l1<CR>
nmap <leader>a, :Tabularize /,<CR>
vmap <leader>a, :Tabularize /,<CR>
nmap <leader>ai :Tabularize /import<CR>
vmap <leader>ai :Tabularize /import<CR>
nmap <leader>af :Tabularize /from<CR>
vmap <leader>af :Tabularize /from<CR>
nmap <leader>a# :Tabularize /#<CR>
vmap <leader>a# :Tabularize /#<CR>


let s:term_pos = {} " { bufnr: [winheight, n visible lines] }
function! EnterTerminalNormalMode()
    if &buftype != 'terminal' || mode('') != 't'
        return 0
    endif
    call feedkeys("\<LeftMouse>\<c-w>N", "x")
    let s:term_pos[bufnr()] = [winheight(winnr()), line('$') - line('w0')]
    call feedkeys("\<ScrollWheelUp>")
endfunction
function! ExitTerminalNormalModeIfBottom()
    if &buftype != 'terminal' || !(mode('') == 'n' || mode('') == 'v')
        return 0
    endif
    let term_pos = s:term_pos[bufnr()]
    let vis_lines = line('$') - line('w0')
    let vis_empty = winheight(winnr()) - vis_lines
    " if size has only expanded, match visible lines on entry
    if term_pos[1] <= winheight(winnr())
        let req_vis = min([winheight(winnr()), term_pos[1]])
        if vis_lines <= req_vis | call feedkeys("i", "x") | endif
    " if size has shrunk, match visible empty lines on entry
    else
        let req_vis_empty = term_pos[0] - term_pos[1]
        let req_vis_empty = min([winheight(winnr()), req_vis_empty])
        if vis_empty >= req_vis_empty | call feedkeys("i", "x") | endif
    endif
endfunction
" scrolling up enters normal mode in terminal window, scrolling back to
" the cursor's location upon entry resumes terminal mode. only limitation
" is that terminal window must have focus before you can scroll to
" enter normal mode
tnoremap <silent> <ScrollWheelUp> <c-w>:call EnterTerminalNormalMode()<CR>
nnoremap <silent> <ScrollWheelDown> <ScrollWheelDown>:call ExitTerminalNormalModeIfBottom()<CR>


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