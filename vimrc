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
Plug 'lfv89/vim-interestingwords'
Plug 'markonm/traces.vim'
Plug 'mattn/emmet-vim'
Plug 'mattn/gist-vim'
Plug 'mg979/vim-visual-multi'
Plug 'michaeljsmith/vim-indent-object'
Plug 'neoclide/coc.nvim'
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
\   'coc-react-refactor',
\   'coc-snippets',
\   'coc-styled-components',
\   'coc-svg',
\   'coc-tailwindcss',
\   'coc-tsserver',
\   'coc-yaml',
\ ]
"\   'coc-eslint',
"\   'coc-pyright',

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
let $BAT_THEME="gruvbox"
" Need to be before gruvbox is loaded
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
let g:gruvbox_vert_split='bg3'
let g:gruvbox_hls_cursor='aqua'
colorscheme gruvbox
" Needs to be after gruvbox is loaded
let g:fzf_colors = {
\   'fg':      ['fg', 'GruvboxFg'],
\   'bg':      ['fg', 'GruvboxBg0'],
\   'hl':      ['fg', 'GruvboxYellow'],
\   'fg+':     ['fg', 'GruvboxFg1'],
\   'bg+':     ['fg', 'GruvboxBg1'],
\   'hl+':     ['fg', 'GruvboxYellow'],
\   'info':    ['fg', 'GruvboxBlue'],
\   'prompt':  ['fg', 'GruvboxYellow'],
\   'border':  ['fg', 'GruvboxBg1'],
\   'pointer': ['fg', 'GruvboxYellow'],
\   'marker':  ['fg', 'GruvboxOrange'],
\   'spinner': ['fg', 'GruvboxYellow'],
\   'header':  ['fg', 'GruvboxBg1'],
\ }

nnoremap * :call gruvbox#hls_show()<CR>*
nnoremap / :call gruvbox#hls_show()<CR>/

" indentLine settings
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
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
let g:NERDCustomDelimiters={ 'htmldjango': { 'left': '{#','right': '#}', 'leftAlt': '<!--', 'rightAlt': '-->' } }

" NERDTree settings
let NERDTreeAutoDeleteBuffer=1
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\.pyc$', '\.rbc$', '\~$', 'node_modules$', '__pycache__', '.DS_Store', 'plugged']

" python syntax settings
let python_highlight_all=1

" supertab settings
" For some reason supertab mappings were backwards. This fixes them
let g:SuperTabMappingForward='<s-tab>'
let g:SuperTabMappingBackward='<tab>'

" UltiSnips settings
let g:UltiSnipsExpandTrigger='<C-j>'

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
nmap <leader>l :setlocal number!<CR>:set list!<CR>:IndentLinesToggle<CR>
" Remap F1 to do what ESC does, and F2 to do what F1 does
inoremap <F1> <ESC>
noremap <F1> <ESC>
inoremap <F2> <F1>
noremap <F2> <F1>
" Search in project
nnoremap <leader>/ :CtrlSF<space>""<left>
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
nnoremap <leader>C :Commits<CR>
nnoremap <leader>H :Helptags<CR>
nnoremap <leader>S :Snippets<CR>
nnoremap <leader>t :BTags<CR>
nnoremap <leader>bc :BCommits<CR>
" Recompile ctags
nnoremap <leader>ct :silent !ctags<CR>
" Re-apply syntax highlighting
nnoremap <leader>ch <Esc>:syntax sync fromstart<CR>
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
nnoremap <leader>es <C-w><C-v><C-l>:UltiSnipsEdit<CR>
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
" Open Mundo
nnoremap <leader>m :MundoToggle<CR>
" Open fzf for files
nnoremap <leader>p :Files<CR>
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