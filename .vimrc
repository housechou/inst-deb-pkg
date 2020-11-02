
"NeoBundle Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/house/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('/home/house/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'majutsushi/tagbar'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/unite-outline'
" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'garbas/vim-snipmate'
NeoBundle 'honza/vim-snippets'
NeoBundle 'bogado/file-line'
"NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'junegunn/fzf.vim'
"NeoBundle 'ntpeters/vim-better-whitespace'
NeoBundle 'scrooloose/nerdtree'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------


set backspace=indent,eol,start
set rtp+=~/.fzf
"# Plugins setting
" This is the default extra key bindings
"let g:fzf_action = {
"  \ 'ctrl-t': 'tab split',
"  \ 'ctrl-x': 'split',
"  \ 'ctrl-v': 'vsplit' }

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

function! s:build_location_list(lines)
  call setloclist(0, map(copy(a:lines), '{ "filename": v:val }'))
  lopen
  lc
endfunction

let g:fzf_action = {
  \ 'ctrl-l': function('s:build_location_list'),
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
"let g:fzf_layout = { 'down': '~40%' }

" You can set up fzf window using a Vim command (Neovim or latest Vim 8 required)
"let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
"let g:fzf_layout = { 'window': '10split enew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '
nmap <C-p> :Files<CR>
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --ignore-case '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

nnoremap <C-p>a :Rg 
"## air-line
set laststatus=2
"let g:airline#extensions#tabline#enabled = 1
let g:airline_exclude_preview = 1
let g:airline_theme='dark'

"## Tagbar
nmap <F2> :TagbarToggle<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set t_BE=
set history=700
set autoread
set nu
set hlsearch
set mouse=a
set noexpandtab
set shiftwidth=4
set tabstop=4

"Set leader to <Space>
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

"Edit vimrc quickly and apply immediately
nmap <leader>e :e ~/.vimrc<CR>
autocmd! bufwritepost .vimrc source ~/.vimrc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"A buffer becomes hidden when it is abandoned
set hidden

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

"# Files, backups and undo
" ## Turn backup off
set nobackup
set nowb
set noswapfile

"Toggles paste mode
"nnoremap <F12> :set invpaste paste?<CR>i
"set pastetoggle=<F12>
set showmode
set clipboard=unnamedplus
"Toggles indent line
set list listchars=tab:\|-,trail:.,extends:>
set nolist
nmap <leader>i :set list!<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
colorscheme wombat256
set t_Co=256
hi Normal guibg=NONE ctermbg=NONE
if has('gui_running')
set guifont=Monospace\ 14
colorscheme desert256
set lines=999 columns=999
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when <leader><cr> is pressed
nnoremap <silent> <leader><cr> :noh<cr>
" Smart way to move between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap <leader>j <C-W>j
noremap <leader>k <C-W>k
noremap <leader>h <C-W>h
noremap <leader>l <C-W>l

" Useful mappings for managing tabs
nnoremap <leader>tn :tabnew<space>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>

"Exit insert mode quickly
inoremap jj <ESC>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
noremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

au BufNewFile,BufRead *.icli setlocal ft=c
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Grep searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map  <F5> :execute "lgrep! -srnw --binary-files=without-match --exclude-dir=.git --exclude-dir=.svn . -e " . expand("<cword>") . " "<bar>lw<CR><CR>
if executable("rg")
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%m
endif
nnoremap  <leader>g :lgrep! "\b<C-R><C-W>\b"<CR>:lw<CR>

nnoremap <silent> <leader>lt :call LocationlistToggle()<CR>
augroup LoctionlistToggle
  autocmd!
  autocmd BufWinEnter quickfix let g:llist_opened = 1
  autocmd BufWinLeave quickfix let g:llist_opened = 0
augroup END
set switchbuf+=usetab,newtab "new tab for quickfix

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! LocationlistToggle()
  if g:llist_opened
    lclose
    let g:llist_opened = 0
  else
    lopen
    let g:llist_opened = 1
  endif
endfunction
